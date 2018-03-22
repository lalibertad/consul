module ApiReniec

  private
    def get_information
      begin
        response = HTTParty.get("#{Rails.application.secrets.api_reniec}/consultadni/#{params[:user][:document_number]}")
        datos = JSON.parse(response.body)["resultado"]
        @message = JSON.parse(response.body)["message"]
        if datos.present?
          params[:user][:document_type] = "1"
          if datos["UBIGEO"].present? && datos["UBIGEO"].split("/").first != "LA LIBERTAD"
            return @message = t("devise_views.users.registrations.new.username_is_not_valid")
          end
          params[:user][:geozone_id] = geozone(datos["UBIGEO"].split("/").last).to_i if datos["UBIGEO"].present?
          params[:user][:date_of_birth] = DateTime.strptime(datos["FENAC"] + "120000", "%Y%m%d%H%M%S") if datos["FENAC"].present?
          params[:user][:username] = "#{datos["NOMBRES"]}" + " " + "#{datos["APPAT"]}" + " " + "#{datos["APMAT"]}"
          if datos["SEXO"].present?
            params[:user][:gender] = "Masculino" if datos["SEXO"] == "M"
            params[:user][:gender] = "Femenino" if datos["SEXO"] == "F"
          end
        end
      rescue
        @message = t("devise_views.users.registrations.new.service_is_not_available")
      end
      @message
    end

    def geozone ubigeo
      Geozone.select("id").where("lower(name) = ?", ubigeo.downcase).where.not(geozone_id: nil).first.id
    end
end
