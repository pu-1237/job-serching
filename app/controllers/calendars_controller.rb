class CalendarsController < ApplicationController
    def index
        @user = current_user
        @works = Work.all
    end
    def show
        
    end

end
