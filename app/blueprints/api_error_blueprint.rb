class ApiErrorBlueprint < Blueprinter::Base
  field :error_message do |object|
    if object.respond_to?(:full_messages)
      object&.full_messages&.join(". ")
    else
      object
    end
  end
end
