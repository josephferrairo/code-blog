class ProfilesController < ApplicationController
  before_action :find_profile, only: [:edit, :update, :show]
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @profile.user != current_user
      flash[:alert] = "This is not you!"
    elsif @profile.user = current_user
      @profile.update_attributes(profile_params)
      flash[:notice] = "Successfully updated your profile!"
      redirect_to profile_path(@profile)
    else
      flash[:alert] = "Error updating profile!"
      render :edit
    end
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:biography, :text_editor, :web_browser, :terminal)
  end
end
