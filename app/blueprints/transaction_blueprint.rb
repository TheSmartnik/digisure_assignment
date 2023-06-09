class TransactionBlueprint < Blueprinter::Base
  fields :quantity, :data, :operation_type, :created_at

  field :operation_description do |object|
    Transaction::INCOMING_OPERATIONS.include?(object.operation_type.to_sym) ? 'incoming' : 'outgoing'
  end
end
