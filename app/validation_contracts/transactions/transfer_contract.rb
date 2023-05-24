class Transactions::TransferContract < Dry::Validation::Contract
  params do
    required(:recipient_email).filled(:string)
    required(:quantity).filled(:integer)
  end
end
