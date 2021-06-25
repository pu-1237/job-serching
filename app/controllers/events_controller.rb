class EventsController < ApplicationController
  before_action :require_admin, only: [:new, :edit, :update, :create, :destroy, :manager, :cancel]

  def index
    @events = Event.all
  end

  def date
    @events = []
    Event.all.each do |event|
      if event.start.year == params[:year] && event.star.month == params[:month] && event.start.day == params[:day]
          @events << event
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    @users = User.all
    # 申し込み者一覧を配列に格納する
    applicants = @users.find_all{|user| @event.applicant_ids.include?(user.id)}
    # 配列に対してページネイトする
    @applicants = Kaminari.paginate_array(applicants).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
        redirect_to manager_events_url, notice: "「#{@event.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    redirect_to event_path, notice: "「#{event.title}を編集しました」"
  end



  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to manager_events_url, notice: "「#{event.title}」を削除しました。"
  end

  def apply
    @event = Event.find(params[:id])
    EventApplicant.create(event_id: @event.id, applicant_id: current_user.id)
    ApplyMailer.creation_email(current_user, @event).deliver_now
    flash[:notice] = '申し込みが完了しました。'
    redirect_to action: "show"
  end

  def cancel
    @event = Event.find(params[:id])
    event_applicant = EventApplicant.find_by(event_id: @event.id, applicant_id: params[:applicant_id])
    if event_applicant.destroy
      CancelMailer.creation_email(User.find(params[:applicant_id]), @event).deliver_now
      flash[:notice] = 'キャンセルが完了しました。'
      redirect_to action: "show"
    else
      render :show
    end
  end
  def cancel_request
    @event = Event.find(params[:id])
    event_applicant = EventApplicant.find_by(event_id: @event.id, applicant_id: current_user.id)
    if event_applicant.update(request: true)
      RequestMailer.creation_email(current_user, @event).deliver_now
      flash[:notice] = 'キャンセルリクエストが完了しました。'
      redirect_to action: "show"
    else
      render :show
    end
  end 

  def manager
    @q = Event.all.ransack(params[:q])
    @events = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def entries
    # current_userの申し込んだイベントを配列に格納する
    events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
    # 配列に対してページネイトする
    @events = Kaminari.paginate_array(events).page(params[:page]).per(5)
  end

  def punch_in
    @event = Event.find(params[:id])
    EventApplicant.find_by(event_id: @event.id, applicant_id: current_user.id).update(attendance: true)
    render :show
  end

  # 給与明細
  def payments
    @events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
  end

  # 月ごとの給与明細
  def list
    # current_userの申し込んだイベントを配列に格納する
    events = Event.all.find_all{ |event| current_user.event_applicants.map(&:event_id).include?(event.id) }
    @events = events.find_all{ |event| event.start.year.to_s == params[:year] && sprintf('%02d', event.start.month)== params[:month] }
  end
  private
  
  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :wages,
      :start,
      :end,
      :deadline,
      :limit,
      event_applicants_attributes: [
                        :id,
                        :event_id,
                        :applicant_id,
                        :request,
                        :attendance,
                        :begin,
                        :finish]
      )
  end
end