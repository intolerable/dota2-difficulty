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

  def check_if_app_disabled!
    render "not_accepting" and return unless ENV["APPLICATION_ENABLED"] == "enabled"
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  alias_method :render_404, :not_found

  def make_chart(heroes)
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', '')
    data_table.new_column('number', '')
    heroes.each do |hero|
      data_table.add_row [hero.ceiling, {v: hero.floor, f: "#{hero.floor}, #{hero.name}"}]
    end
    GoogleVisualr::Interactive::ScatterChart.new data_table, height: 600, width: "100%", legend: "none"
  end

end
