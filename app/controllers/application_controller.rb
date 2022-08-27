class ApplicationController < ActionController::Base
  include JsonWebToken
  protect_from_forgery with: :null_session
  before_action :authenticate_request
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
