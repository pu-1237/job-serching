class UserImagesController < ApplicationController

  before_action do
    @user = current_user
  end

  def index
    @images = @user.images.order(:id)
  end

  def show
    redirect_to action: "efit"
  end

  def new
    @image = @user.images.build
  end

  def edit
    @image = @user.images.find(params[:id])
  end

  def create
    @image = @user.images.build(image_params)
    if @image.save
      redirect_to [@user, :images], notice: "画像を登録しました"
    else
      render "new"
    end
  end

  def update
    @image = @user.images.build(image_params)
    @image.assign_attributes(image_params)
    if @image.save
      redirect_to [@user, :images], notice: "画像を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @imager = @entry.images.find(params[:id])
    @image.destroy
    redirect_to [@user, :images], notice: "画像を更新しました"
  end

  private
  
  def image_params
    params.require(:image).permit(
      :new_data,
      :alt_text
    )
  end
end
