class WorksController < ApplicationController

    def index
      @works = Work.all
    end
  
    def show
      @work = Work.find(params[:id])
      @user = @work.user
    end
  
    def new
      @work = Work.new
    end
  
    def edit
      @work = Work.find(params[:id])
    end
  
    def update
      work = Work.find(params[:id])
      work.update!(work_params)
      redirect_to works_path, notice: "「#{work.title}を編集しました」"
    end
  
    def create
      @work = current_user.works.new(work_params)
      if @work.save
          redirect_to works_url, notice: "「#{@work.title}」を投稿しました。"
      else
        render :new
      end
    end
  
    def destroy
      work = Work.find(params[:id])
      work.destroy
      redirect_to works_path, notice: "「#{work.title}」を削除しました。"
    end
  
    def apply
      WorkAppicate.create(work_id: @work.id, applicate_id: ciurrent_user.id)
      flash[:notice] = '申し込みが完了しました。'
      redirect_to action: "show"
    end
  
    def cancel
      work_applicate = WorkAppicate.find_by(work_g_id: @work.id, applicate_id: current_user.id)
      work_applicate.destroy
      flash[:notice] = 'キャンセルが完了しました。'
      redirect_to action: "show"
    end
  
    private
    
    def work_params
      params.require(:work).permit(:title, :description, :wages, :work_at)
    end
  
  end

  create_table :work_applicants do |t|
    t.references :work, foreign_key: true
    t.references :applicants, foreign_key: {to_table: :users}

    belongs_to :user
    has_many :work_applicants, dependent: :destroy
    has_many :applicants, through: :work_applicants, dependent: :destroy

    validates :title, :description, :wages, :work_at, presence: true

    resources :works do
        member do
          get 'apply'
          get 'cansel'
        end
      end

    <% if @user.id != current_user.id %>
        <% if @post.applicate_ids.include?(current_user.id) %>
            <%= link_to "申し込みをキャンセルする", cancel_work_path(@work.id), data: { confirm: "こちらの投稿の申し込みをキャンセルしますか？" } %>
        <% else %>
            <%= link_to "申し込む", apply_work_path(@work.id), data: { confirm: "こちらの投稿に申し込みますか？" } %>
        <% end %>
    <% end %>

    def up
        execute 'DELETE FROM works;'
        add_reference :works, :user, null: false, index: true
      end
      def down
        remove_reference :works, :user, index: true
      end
    end

    has_secure_password
    
    has_many :works
    has_many :work_applicants, foreign_key: "application_id", dependent: :destroy

    validates :name, presence: true
    validates :email, email: {allow_blank: true}

    belongs_to :user
    has_many :work_applicants, dependent: :destroy
    has_many :applicants, through: :work_applicants, dependent: :destroy

    validates :title, :description, :wages, :work_at, presence: true
    
    belong_to :applicant, class_name: 'User', foreign_key: 'applicant_id'
    validates_uniqueness_of :work_id, scope: :applicant_id

