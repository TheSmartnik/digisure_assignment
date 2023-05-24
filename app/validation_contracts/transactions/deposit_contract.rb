class Transactions::DepositContract < Dry::Validation::Contract
  params do
    required(:quantity).filled(:integer)
  end
end
