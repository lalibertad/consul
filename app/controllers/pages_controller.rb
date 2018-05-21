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
    send_file(
      "#{Rails.root}/public/docs/formato_ficha_tecnica.docx",
      filename: "formato_ficha_tecnica.docx",
      type: "application/doc"
    )
  end

  def download_file
    send_file(
      "#{Rails.root}/public/docs/formato_ficha_inscripcion.docx",
      filename: "formato_ficha_inscripcion.docx",
      type: "application/doc"
    )
  end

end
