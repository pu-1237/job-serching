class TopsController < ApplicationController
    skip_before_action :login_required
    def index
        @news = News.all
    end
    def business

    end
end
