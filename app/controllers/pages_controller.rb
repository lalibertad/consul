class PagesController < ApplicationController
  skip_authorization_check

  def show
    @custom_page = SiteCustomization::Page.published.find_by(slug: params[:id])

    if @custom_page.present?
      render action: :custom_page
    else
      render action: params[:id]
    end
  rescue ActionView::MissingTemplate
    head 404
  end

  def more
    @log = Log.new
    @log.user_id = current_user.id
    @log.citizen_id = params[:id]
    if @log.save
      @user = User.find(params[:id])
      @zone = @user.geozone
      @response = {estado: 1, citizen: @user, zone: @zone}
    else
      @response = { estado: 0 }
    end
    render :json => @response
  end

  def download
    if params[:da] == "outline"
      send_file(
        "#{Rails.root}/public/docs/directrices_ejercicio_propuesta.pdf",
        filename: "directrices_ejercicio_propuesta.pdf",
        type: "application/pdf"
      )
    else
      send_file(
        "#{Rails.root}/public/docs/formulario_propuestas_ciudadanas.pdf",
        filename: "formulario_propuestas_ciudadanas.pdf",
        type: "application/pdf"
      )
    end

  end

end
