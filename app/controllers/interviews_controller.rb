class InterviewsController < ApplicationController
    def index
        @interviews = Interview.all
    end

    def show
        @interview = Interview.find(params[:id])
        @users = User.all
        # 申し込み者一覧を配列に格納する
        registrants = @users.find_all{|user| @interview.registrant_ids.include?(user.id)}
        # 配列に対してページネイトする
        @registrants = Kaminari.paginate_array(registrants).page(params[:page]).per(10)
    end
    
    def new
        @interview = Interview.new
    end
    
    def create
        @interview = current_user.interviews.new(interview_params)
        if @interview.save
            redirect_to interviews_url, notice: "「#{@interview.start}」を登録しました。"
        else
            render :new
        end
    end
    
    def edit
        @interview = Interview.find(params[:id])
    end
    
    def update
        interview = Interview.find(params[:id])
        interview.update!(interview_params)
        redirect_to interview_path, notice: "「#{interview.start}を編集しました」"
    end
    
    def destroy
        interview = Interview.find(params[:id])
        interview.destroy
        redirect_to interviews_url, notice: "「#{interview.start}」を削除しました。"
    end
    
    def apply
        @interview = Interview.find(params[:id])
        InterviewRegistrant.create(interview_id: @interview.id, registrant_id: current_user.id)
        # ApplyMailer.creation_email(current_user, @event).deliver_now
        flash[:notice] = '申し込みが完了しました。'
        redirect_to action: "show"
    end
    
    def cancel
        @interview = Interview.find(params[:id])
        interview_registrant = InterviewRegistrant.find_by(interview_id: @interview.id, registrant_id: current_user.id)
        if interview_registrant.destroy
            # CancelMailer.creation_email(User.find(params[:applicant_id]), @event).deliver_now
            flash[:notice] = 'キャンセルが完了しました。'
            redirect_to action: "show"
        else
            render :show
        end
    end
    private
    def interview_params
        params.require(:interview).permit(
            :start,
            :limit
        )
    end
end
