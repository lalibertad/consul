class Organizations::RegistrationsController < Devise::RegistrationsController
  include ApiReniec

  invisible_captcha only: [:create], honeypot: :address, scope: :user

  def new
    super do |user|
      user.build_organization
    end
  end

  def success
  end

  def create
    build_resource(sign_up_params)
    if resource.valid?
      success, message = get_information
      if success == 1
        super
      else
        if success == 2
          resource.document_type = "1"
          resource.hidden_at = Time.current
          if resource.save
            flash.now[:alert] = message
          else
            flash.now[:alert] = "Error al guardar. Contacte al administrador"
          end
        else
          flash.now[:alert] = message
        end
        render :new
      end
    else
      render :new
    end
  end

  protected

    def after_inactive_sign_up_path_for(resource)
      organizations_sign_up_success_path
    end

  private

    def sign_up_params
      params.require(:user).permit(:document_number, :document_type, :username, :email, :password, :phone_number,
                                   :password_confirmation, :terms_of_service, :date_of_birth, :gender, :geozone_id,
                                   organization_attributes: [:name, :responsible_name])
    end

end
