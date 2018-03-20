class Verification::ResidenceController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_verified!
  before_action :verify_lock, only: [:new, :create]
  before_action :load_geozones
  skip_authorization_check

  def new
    @residence = Verification::Residence.new
  end

  def create
    @residence = Verification::Residence.new(residence_params.merge(user: current_user))
    if @residence.save
      redirect_to_next_path#, notice: t('verification.residence.create.flash.success')
    else
      render :new
    end
  end

  private

    def residence_params
      params.require(:residence).permit(:terms_of_service, :profession, :hamlet_or_urbanization, :date_of_birth, :gender)
    end

    def redirect_to_next_path
      current_user.reload
      if current_user.level_three_verified?
        redirect_to account_path, notice: t('verification.sms.update.flash.level_three.success')
      else
        redirect_to new_letter_path, notice: t('verification.sms.update.flash.level_two.success')
      end
    end

    def load_geozones
      @district = Geozone.where(id: current_user.geozone_id).first
      @province = Geozone.where(id: @district.geozone_id).first
    end
end
