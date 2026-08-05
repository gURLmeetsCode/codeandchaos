class Users::RegistrationsController < Devise::RegistrationsController
  before_action :block_public_signup, only: %i[new create]

  private

  def block_public_signup
    redirect_to new_user_session_path, alert: "Registration is closed."
  end
end
