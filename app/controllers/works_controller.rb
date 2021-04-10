class WorksController < ApplicationController
  before_action :if_not_admin, only: [:new, :edit, :update, :create, :destroy]

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
    @work = Work.find(params[:id])
    WorkApplicant.create(work_id: @work.id, applicant_id: current_user.id)
    flash[:notice] = '申し込みが完了しました。'
    redirect_to action: "show"
  end

  def cancel
    @work = Work.find(params[:id])
    work_applicant = WorkApplicant.find_by(work_id: @work.id, applicant_id: current_user.id)
    work_applicant.destroy
    flash[:notice] = 'キャンセルが完了しました。'
    redirect_to action: "show"
  end

  private
  
  def work_params
    params.require(:work).permit(:title, :description, :wages, :work_at)
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

end