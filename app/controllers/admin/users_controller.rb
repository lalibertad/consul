class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource except: [:new, :create]

  def index
    @users = User.by_username_email_or_document_number(params[:search]) if params[:search]
    @users = @users.active.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_sql("select * from users where username is null and hidden_at is not null and validated is not true and email = '#{params[:user][:email]}' limit 1").first
    if @user.blank?
      @user = User.new(user_params)
      if @user.save
        redirect_to new_admin_user_path, notice: t("admin.users.index.success")
      else
        flash.now[:alert] = t("admin.organizations.index.error")
        render :new
      end
    else
      if @user.update(document_number: params[:user][:document_number], username: params[:user][:username],
                      phone_number: params[:user][:phone_number], hidden_at: nil, validated: nil)
        Mailer.waiting_user(@user, '', 1).deliver_later
        redirect_to new_admin_user_path, notice: t("admin.users.index.success")
      else
        flash.now[:alert] = t("admin.organizations.index.error")
        render :new
      end
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
