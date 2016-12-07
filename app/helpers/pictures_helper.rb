module PicturesHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      if params[:user_id]
        #pictures_path(user_id: params[:user_id])
        confirm_pictures_path(user_id: params[:user_id])
      else
        #pictures_path()
        confirm_pictures_path()
      end
    elsif action_name == 'edit'
      if params[:user_id]
        picture_path(user_id: params[:user_id])
      else
        picture_path
      end
    end
  end

  def check_param_new_picture_path
    if params[:user_id]
      new_picture_path(user_id: params[:user_id])
    else
      new_picture_path()
    end
  end

  def check_param_pictures_path
    if params[:user_id]
      pictures_path(user_id: params[:user_id])
    else
      pictures_path()
    end
  end
end
