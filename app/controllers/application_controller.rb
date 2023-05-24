class ApplicationController < ActionController::API
  def current_user
    token = ApiToken.find_by(token: request.headers["X-API-TOKEN"])
    return api_error("User not found") if token.blank?

    token.user
  end

  def api_error(object)
    render json: ApiErrorBlueprint.render(object), status: :unprocessable_entity
  end
end
