class AuthController < ApplicationController
  def create
    user = User.find_by!(email: user_attributes[:email])

    if user.authenticate(user_attributes[:password])
      render json: UserBlueprint.render(user, view: :with_api_token)
    else
      not_found_error(user)
    end
  end

  def user_attributes
    params.require(:user).permit(:email, :password)
  end
end
