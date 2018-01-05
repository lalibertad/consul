class Admin::SiteCustomization::VideosController < Admin::SiteCustomization::BaseController

  def update
    if params[:site_customization_video].nil?
      redirect_to admin_site_customization_images_path
      return
    end
    @video = SiteCustomization::Video.find(params[:id])
    if @video.update(video_params)
      redirect_to admin_site_customization_images_path, notice: t('admin.site_customization.videos.update.notice')
    else
      flash.now[:error] = t('admin.site_customization.videos.update.error')
      redirect_to admin_site_customization_images_path
    end
  end

  def destroy
    @video.video = nil
    if @video.save
      redirect_to admin_site_customization_images_path, notice: t('admin.site_customization.videos.destroy.notice')
    else
      redirect_to admin_site_customization_images_path, notice: t('admin.site_customization.videos.destroy.error')
    end
  end

  private

    def video_params
      params.require(:site_customization_video).permit(
        :video
      )
    end
end
