class Organizations::RegistrationsController < Devise::RegistrationsController

  invisible_captcha only: [:create], honeypot: :address, scope: :user
  $message = ''

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
      if $message != ''
        flash.now[:alert] = $message
      end
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
        response = HTTParty.get("#{Rails.application.secrets.api_reniec}/consultadni/#{params[:user][:document_number]}")
        datos = JSON.parse(response.body)["resultado"]
        if datos.nil? || datos.empty?
          $message = 'DNI incorrecto, inválido en RENIEC'
        else
          if datos["FENAC"] != {}
            params[:user][:date_of_birth] = DateTime.strptime(datos["FENAC"] + "120000", "%Y%m%d%H%M%S")
          end
          if datos["SEXO"] != {}
            if datos["SEXO"] == "M"
              params[:user][:gender] = "Male"
            else
              params[:user][:gender] = "Female"
            end
          end
          nombres = datos["NOMBRES"].strip!
          appat = datos["APPAT"].strip!
          apmat = datos["APMAT"].strip!
          params[:user][:username] = "#{nombres}" + " " + "#{appat}" + " " + "#{apmat}"
          params[:user][:organization_attributes][:responsible_name] = "#{nombres}" + " " + "#{appat}" + " " + "#{apmat}"
        end
      rescue
        $message = 'Servicio RENIEC no disponible, vuelva a intentarlo más tarde'
      end
      params.require(:user).permit(:document_number, :document_type, :username, :email, :password, :phone_number, :password_confirmation, :terms_of_service, :date_of_birth, :gender,
                                   organization_attributes: [:name, :responsible_name])
    end

end
