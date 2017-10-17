class Organizations::RegistrationsController < Devise::RegistrationsController

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
      super do |user|
        # Removes unuseful "organization is invalid" error message
        user.errors.messages.delete(:organization)
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
      begin
        params[:user][:document_type] = "1"
        response = HTTParty.get("#{Rails.application.secrets.api_reniec}?numDni=#{params[:user][:document_number]}")
        if response.body != "null"
          datos = JSON.parse(response.body)
          params[:user][:date_of_birth] = DateTime.strptime(datos["FENAC"] + "120000", "%Y%m%d%H%M%S")
          if datos["SEXO"] == "M"
            params[:user][:gender] = "Male"
          else
            params[:user][:gender] = "Female"
          end
          nombres = datos["NOMBRES"]
          nombres.strip!
          appat = datos["APPAT"]
          appat.strip!
          apmat = datos["APMAT"]
          apmat.strip!
          params[:user][:username] = "#{nombres}" + " " + "#{appat}" + " " + "#{apmat}"
          params[:user][:organization_attributes][:responsible_name] = "#{nombres}" + " " + "#{appat}" + " " + "#{apmat}"
        end
      end
      params.require(:user).permit(:document_number, :document_type, :username, :email, :password, :phone_number, :password_confirmation, :terms_of_service, :date_of_birth, :gender,
                                   organization_attributes: [:name, :responsible_name])
    end

end
