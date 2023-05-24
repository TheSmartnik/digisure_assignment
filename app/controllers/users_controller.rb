class UsersController < ApplicationController
  def create
    user = User.create(user_attributes)

    if user.persisted?
      render json: UserBlueprint.render(user, view: :with_auth_token)
    else
      render json: ActiveRecordErrorBlueprint.render(user.errors), status: :unprocessable_entity
    end
  end

  private

  def user_attributes
    params.require(:user).permit(:email, :password)
  end
end
