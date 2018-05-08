module ApiReniec

  private
    def get_information
      begin
        response = HTTParty.get("#{Rails.application.secrets.api_reniec}/consultadni/#{params[:user][:document_number]}")
        @status = JSON.parse(response.body)["status"].to_i
        @notice = JSON.parse(response.body)["message"]
        if @status == 1
          datos = JSON.parse(response.body)["resultado"]
          if datos.present?
            params[:user][:document_type] = "1"
            params[:user][:username] = "#{datos["NOMBRES"]}" + " " + "#{datos["APPAT"]}" + " " + "#{datos["APMAT"]}"
            if datos["UBIGEO"].present? && datos["UBIGEO"].split("/").first != "LA LIBERTAD"
              return 0, t("devise_views.users.registrations.new.username_is_not_valid")
            end
            begin
              params[:user][:geozone_id] = geozone(datos["UBIGEO"].split("/").last).to_i if datos["UBIGEO"].present?
            rescue
              @notice = t("devise_views.users.registrations.new.geozone_unavailable")
            end
            params[:user][:date_of_birth] = DateTime.strptime(datos["FENAC"] + "120000", "%Y%m%d%H%M%S") if datos["FENAC"].present?
            if datos["SEXO"].present?
              params[:user][:gender] = "Masculino" if datos["SEXO"] == "M"
              params[:user][:gender] = "Femenino" if datos["SEXO"] == "F"
            end
          end
        end
        return @status, "RENIEC: " + @notice
      rescue
        return 2, t("devise_views.users.registrations.new.service_is_not_available")
      end
    end

    def geozone ubigeo
      Geozone.select("id").where("lower(unaccent(name)) = ?", ubigeo.downcase).where.not(geozone_id: nil).first.id
    end
end
