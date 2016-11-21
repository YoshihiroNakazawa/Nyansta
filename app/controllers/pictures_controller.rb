class PicturesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
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
    if @picture.save
      redirect_to pictures_path, notice: "画像を投稿しました。"
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
      redirect_to pictures_path, notice: "投稿内容を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    set_picture
    #@picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice: "投稿を削除しました。"
  end

  def confirm
    @picture = Picture.new(pictures_params)
    render :new if @picture.invalid?
  end

  private
    def pictures_params
      params.require(:picture).permit(:title, :image, :comment, :image_cash, :remove_image)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end
end
