class UserBlueprint < Blueprinter::Base
  fields :email, :balance

  view :with_api_token do
    field :api_token do |object|
      object.api_token.token
    end
  end
end
