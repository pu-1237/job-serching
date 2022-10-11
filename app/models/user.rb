class User < ApplicationRecord
    has_many :event_applicants, foreign_key: 'applicant_id', dependent: :destroy
    has_many :events, dependent: :destroy

    before_create :default_image
    
    validates :last_name, :first_name, :last_name_kana, :first_name_kana, :prefecture_code, :address_city, :address_street, :station, :gender, :birthday, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: "が正しく入力されていません" }, uniqueness: { case_sensitive: false }
    validates :number, presence: true, uniqueness: true, format: {with: /\A\d{10}$|^\d{11}\z/, message: "が正しく入力されていません"}
    validates :postcode, presence: true, format: {with: /\A\d{7}\z/, message: "が正しく入力されていません"}
    has_secure_password
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数を両方含む必要があります"}, allow_nil: true

    has_many :images, class_name: "UserImage"

    accepts_nested_attributes_for :images

    has_one_attached :profile_picture
    attribute :new_profile_picture

    attr_accessor :remember_token, :reset_token

    include JpPrefecture
    jp_prefecture :prefecture_code


    # 都道府県コードを文字に変換する
    def prefecture_name
        JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
    end
    
    def prefecture_name=(prefecture_name)
        self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end


    before_save do
        if new_profile_picture
            self.profile_picture = new_profile_picture
        end 
    end

    def self.ransackable_attributes(auth_object = nil)
        %w[id name]
    end

    def self.ransakable_associations(auth_object = nil)
        []
    end

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # 姓名を連結する
    def full_name
        self.last_name + " " + self.first_name
    end

    def full_name_kana
        self.last_name_kana + " " + self.first_name_kana
    end

    # 住所を結合させる
    def address
        self.prefecture_name &.+ self.address_city &.+ self.address_street
    end

    #デフォルト画像を登録する
    def default_image
        if !self.profile_picture.attached?
            self.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')), filename: 'photo.jpg')
        end
    end

end
