class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :complete_profile, only: :show

  def show
    @profile = profile
  end

  def new
    redirect_to(profile_path) and return if profile.present?
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to(profile_path, notice: 'Thanks! Your profile has successfully been saved')
    else
      flash.alert = 'Please fill in the required fields'
      render(:new)
    end
  end

  private

  def complete_profile
    redirect_to(new_profile_path, notice: 'Please complete your profile') if profile.blank?
  end

  def profile_params
    params.require(:profile).permit(:date_of_birth, :profession, :greeting, :bio, :mobile_number, :favorite_cuisine)
  end

  def profile
    current_user.profile
  end
end
