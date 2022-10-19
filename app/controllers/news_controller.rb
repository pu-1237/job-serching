class NewsController < ApplicationController
    before_action :require_admin, only: [:new, :edit, :update, :create, :destroy]
    def index
        @q = News.all.ransack(params[:q])
        @q.sorts = 'id desc' # デフォルトのソート順を追加
        @news = @q.result(distinct: true).page(params[:page]).per(5)
    end
    
    def show
        @news = News.find(params[:id])
    end
    
    def new
        @news = News.new
    end
    
    def create
        @news = News.new(news_params)
    
        if @news.save
            redirect_to news_index_path, notice: "ニュース「#{@news.title}」を登録しました。"
        else
            render :new
        end
    end
    
    def edit
        @news = News.find(params[:id])
    end
    
    def update
        @news = News.find(params[:id])
    
        if @news.update(news_params)
            redirect_to news_path(@news), notice: "ニュース「#{@news.title}」を更新しました。"
        else
            render :edit
        end
    end
    
    def destroy
        @news= News.find(params[:id])
        @news.destroy
        redirect_to :action => 'index', notice: "ニュース「#{@news.title}」を削除しました。"
    
    end
    private

    def news_params
        params.require(:news).permit(
        :title,
        :text
        )
    end
    
    def use_before_action?
        false
    end
end
