class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :resolve_layout

  private

  def resolve_layout
    if devise_controller? && !account_settings_page?
      "auth"
    else
      "application"
    end
  end

  def account_settings_page?
    controller_name == "registrations" && action_name.in?(%w[edit update])
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_dashboard_path : root_path
  end
end
