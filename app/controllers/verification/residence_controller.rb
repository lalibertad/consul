class Verification::ResidenceController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_verified!
  before_action :verify_lock, only: [:new, :create]
  skip_authorization_check

  def new
    @residence = Verification::Residence.new
    @geozones = Geozone.all.order("LOWER(name)").where("geozone_id" => nil)
  end

  def create
    @residence = Verification::Residence.new(residence_params.merge(user: current_user))
    if @residence.save
      redirect_to_next_path#, notice: t('verification.residence.create.flash.success')
    else
      @geozones = Geozone.all.order("LOWER(name)").where("geozone_id" => nil)
      render :new
    end
  end

  private

    def residence_params
      params.require(:residence).permit(:postal_code, :terms_of_service, :profession, :hamlet_or_urbanization)
    end

    def redirect_to_next_path
      current_user.reload
      if current_user.level_three_verified?
        redirect_to account_path, notice: t('verification.sms.update.flash.level_three.success')
      else
        redirect_to new_letter_path, notice: t('verification.sms.update.flash.level_two.success')
      end
    end
end
