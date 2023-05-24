class Transactions::Deposit
  include Interactor

  delegate :user, :form, to: :context

  def call
    user.transactions.create(operation_type: Transaction::DEPOSIT, quantity: form[:quantity])
  end
end
