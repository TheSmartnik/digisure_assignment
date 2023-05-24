class ApplicationController < ActionController::API
  def current_user
    User.first
  end

  def api_error(object)
    render json: ApiErrorBlueprint.render(object), status: :unprocessable_entity
  end
end
