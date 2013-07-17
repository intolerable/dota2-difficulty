class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  alias_method :render_404, :not_found

end
