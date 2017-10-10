class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :finish_signup, :do_finish_signup]

  invisible_captcha only: [:create], honeypot: :family_name, scope: :user

  def new
    super do |user|
      user.use_redeemable_code = true if params[:use_redeemable_code].present?
    end
  end

  def create
    build_resource(sign_up_params)
    if resource.valid?
      super
    else
      render :new
    end
  end

  def delete_form
    build_resource({})
  end

  def delete
    current_user.erase(erase_params[:erase_reason])
    sign_out
    redirect_to root_url, notice: t("devise.registrations.destroyed")
  end

  def success
  end

  def finish_signup
    current_user.registering_with_oauth = false
    current_user.email = current_user.oauth_email if current_user.email.blank?
    current_user.validate
  end

  def do_finish_signup
    current_user.registering_with_oauth = false
    if current_user.update(sign_up_params)
      current_user.send_oauth_confirmation_instructions
      sign_in_and_redirect current_user, event: :authentication
    else
      render :finish_signup
    end
  end

  def check_username
    if User.find_by username: params[:username]
      render json: {available: false, message: t("devise_views.users.registrations.new.username_is_not_available")}
    else
      render json: {available: true, message: t("devise_views.users.registrations.new.username_is_available")}
    end
  end

  private

    def sign_up_params
      params[:user].delete(:redeemable_code) if params[:user].present? && params[:user][:redeemable_code].blank?
      params[:user][:username] = check_document params[:user][:document_number]
      params.require(:user).permit(:document_number, :username, :email, :password,
                                   :password_confirmation, :terms_of_service, :locale,
                                   :redeemable_code)
    end

    def check_document(document)
      begin
        response = HTTParty.get("http://10.10.31.8/php/api/dni.php?numDni=#{document}")
        if response == "null"
          #render json: {available: false, message: t("devise_views.users.registrations.new.username_is_not_valid")}
          return nil
        end
        datos = JSON.parse(response.body)
        nombres = datos["NOMBRES"]
        nombres.strip!
        appat = datos["APPAT"]
        appat.strip!
        apmat = datos["APMAT"]
        apmat.strip!
        return "#{nombres}" + " " + "#{appat}" + " " + "#{apmat}"
      rescue
        #render json: {available: false, message: t("devise_views.users.registrations.new.service_is_not_available")}
        return nil
      end
    end

    def erase_params
      params.require(:user).permit(:erase_reason)
    end

    def after_inactive_sign_up_path_for(resource_or_scope)
      users_sign_up_success_path
    end

end
