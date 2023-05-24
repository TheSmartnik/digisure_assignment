class UsersController < ApplicationController
  def create
    user = User.create(user_attributes)

    if user.persisted?
      render json: UserBlueprint.render(user, view: :with_auth_token)
    else
      api_error(user.errors)
    end
  end

  def show
    render json: UserBlueprint.render(current_user)
  end

  private

  def user_attributes
    params.require(:user).permit(:email, :password)
  end
end
