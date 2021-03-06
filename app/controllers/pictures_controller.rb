class PicturesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :confirm]

  before_action :set_picture, only: [:edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @pictures = Picture.where(user_id: params[:user_id]).order(updated_at: :desc)
    else
      @pictures = Picture.all.order(updated_at: :desc)
    end
  end

  def new
    if params[:back]
      @picture = Picture.new(pictures_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(pictures_params)
    @picture.user_id = current_user.id
    if @picture.save
      if params[:user_id]
        redirect_to user_pictures_path(user_id: params[:user_id]), notice: "画像を投稿しました。"
      else
        redirect_to pictures_path, notice: "画像を投稿しました。"
      end
      NoticeMailer.sendmail_picture(@picture).deliver
    else
      render 'new'
    end
  end

  def edit
    set_picture
    #@picture = Picture.find(params[:id])
  end

  def update
    set_picture
    #@picture = Picture.find(params[:id])
    if @picture.update(pictures_params)
      if params[:user_id]
        redirect_to user_pictures_path(user_id: params[:user_id]), notice: "投稿内容を更新しました。"
      else
        redirect_to pictures_path, notice: "投稿内容を更新しました。"
      end
    else
      render "edit"
    end
  end

  def destroy
    set_picture
    #@picture = Picture.find(params[:id])
    @picture.destroy
    if params[:user_id]
      redirect_to user_pictures_path(user_id: params[:user_id]), notice: "投稿を削除しました。"
    else
      redirect_to pictures_path, notice: "投稿を削除しました。"
    end
  end

  def confirm
    #binding.pry
    if params[:picture]
      @picture = Picture.new(pictures_params)
      render :new, user_id: params[:user_id] if @picture.invalid?
    else
      @picture = Picture.new
      render :new, user_id: params[:user_id]
    end
  end

  private
    def pictures_params
      params.require(:picture).permit(:title, :image, :comment, :image_cache, :remove_image)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end
end
