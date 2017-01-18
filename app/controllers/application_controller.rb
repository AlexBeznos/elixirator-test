class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def not_authorized
    redirect_to root_path, alert: "You are not authorized to perform this action"
  end
end
