class User < ApplicationRecord
    has_secure_password

    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
    validates :email, email: {allow_blank: true}

    has_many :events, dependent: :destroy
    has_many :event_applicants, foreign_key: 'applicant_id', dependent: :destroy

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

end
