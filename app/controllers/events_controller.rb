class EventsController < ApplicationController
  before_action :require_admin, only: [:new, :edit, :update, :create, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @user = @event.user
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    redirect_to events_path, notice: "「#{event.title}を編集しました」"
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
        redirect_to events_url, notice: "「#{@event.title}」を投稿しました。"
    else
      render :new
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_path, notice: "「#{event.title}」を削除しました。"
  end

  def apply
    @event = Event.find(params[:id])
    EventApplicant.create(event_id: @event.id, applicant_id: current_user.id)
    flash[:notice] = '申し込みが完了しました。'
    redirect_to action: "show"
  end

  def cancel
    @event = Event.find(params[:id])
    event_applicant = EventApplicant.find_by(event_id: @event.id, applicant_id: current_user.id)
    event_applicant.destroy
    flash[:notice] = 'キャンセルが完了しました。'
    redirect_to action: "show"
  end

  private
  
  def event_params
    params.require(:event).permit(:title, :description, :wages, :start, :end)
  end

end