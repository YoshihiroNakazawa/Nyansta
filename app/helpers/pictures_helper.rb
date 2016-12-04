module PicturesHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      #confirm_pictures_path
      if params[:user_id]
        pictures_path(user_id: params[:user_id])
      else
        pictures_path()
      end
    elsif action_name == 'edit'
      if params[:user_id]
        picture_path(user_id: params[:user_id])
      else
        picture_path
      end
    end
  end
end
