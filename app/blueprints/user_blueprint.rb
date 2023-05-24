class UserBlueprint < Blueprinter::Base
  fields :email

  view :with_auth_token do
    field :auth_token do
      '12134'
    end
  end
end
