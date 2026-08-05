class Admin::EntrypointsController < ApplicationController
  def show
    if user_signed_in? && current_user.admin?
      redirect_to admin_dashboard_path
    elsif user_signed_in?
      redirect_to root_path, alert: "You need an admin account to access this area."
    end
  end
end
