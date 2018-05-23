class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource except: [:new, :create]

  def index
    @users = User.by_username_email_or_document_number(params[:search]) if params[:search]
    @users = @users.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_admin_user_path, notice: t("admin.users.index.success")
    else
      render :new
    end
  end

  private
    def user_params
      params[:user][:document_type] = "1"
      params[:user][:password] = params[:user][:document_number]
      params[:user][:password_confirmation] = params[:user][:document_number]
      params[:user][:terms_of_service] = "1"
      params.require(:user).permit(:document_number, :document_type, :username, :email, :password, :phone_number,
                                   :password_confirmation, :terms_of_service)
    end

end
