class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end


  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :company, :position])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :phone_number, :name, :surname])
  end
end
