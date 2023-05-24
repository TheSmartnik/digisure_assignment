class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActionController::ParameterMissing, with: :parameter_missing_error

  private

  def current_user
    token = ApiToken.find_by(token: request.headers["X-API-TOKEN"])
    return api_error("User not found") if token.blank?

    token.user
  end

  def not_found_error(error)
    render json: { message: "Couldn't find #{error.model}"}, status: 404
  end

  def parameter_missing_error(error)
    api_error(error.message)
  end

  def api_error(object)
    render json: ApiErrorBlueprint.render(object), status: :unprocessable_entity
  end
end
