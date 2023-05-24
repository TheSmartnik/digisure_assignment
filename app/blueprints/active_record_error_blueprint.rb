class ActiveRecordErrorBlueprint < Blueprinter::Base
  field :error_message do |object|
    object.full_messages.join(". ")
  end
end
