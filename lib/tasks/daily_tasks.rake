namespace :daily_tasks do
  desc "Authenticate users and notify by email"
  task verify_users: :environment do
    puts("verificando usuarios")
    User.find_by_sql('select * from users where username is null and hidden_at is not null and validated is not true').each do |user|
      success, message = get_information user
      case success
        when 1
          user.validated = true
          unless user.save
            message = user.errors.messages
            success = 2
          end
        when 0
          user.validated = true
          user.save
        else
          message = "Servicio RENIEC sigue sin dar respuestas"
      end
      Mailer.waiting_user(user, message, success).deliver_later
    end
  end

  private
    def get_information(user)
      begin
        response = HTTParty.get("#{Rails.application.secrets.api_reniec}/consultani/#{user.document_number}")
        @status = JSON.parse(response.body)["status"].to_i
        @notice = JSON.parse(response.body)["message"]
        if @status == 1
          datos = JSON.parse(response.body)["resultado"]
          if datos.present?
            user.document_type = "1"
            user.username = "#{datos["NOMBRES"]}" + " " + "#{datos["APPAT"]}" + " " + "#{datos["APMAT"]}"
            if datos["UBIGEO"].present? && datos["UBIGEO"].split("/").first != "LA LIBERTAD"
              return 0, "No reside en esta región, actualiza tu residencia en RENIEC"
            end
            begin
              user.geozone_id = (Geozone.select("id").where("lower(unaccent(name)) = ?", (datos["UBIGEO"].split("/").last).downcase)
                                   .where.not(geozone_id: nil).first.id).to_i if datos["UBIGEO"].present?
            rescue
              @notice = "Su distrito no fue encontrado, contacte con el administrador"
            end
            user.date_of_birth = DateTime.strptime(datos["FENAC"] + "120000", "%Y%m%d%H%M%S") if datos["FENAC"].present?
            if datos["SEXO"].present?
              user.gender = "Masculino" if datos["SEXO"] == "M"
              user.gender = "Femenino" if datos["SEXO"] == "F"
            end
          end
        end
        return @status, "RENIEC: " + @notice
      rescue
        return 2, "Servicio RENIEC no disponible, su DNI será validado lo antes posible, lo estaremos notificando"
      end
    end
end
