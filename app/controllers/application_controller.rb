class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      password == ENV["CREDENTIALS_PASSWORD"] && username == ENV["CREDENTIALS_USERNAME"]
    end
  end

  def authenticate!
    redirect_to root_path unless authenticate
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  alias_method :render_404, :not_found

end
