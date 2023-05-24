class Transactions::Transfer
  include Interactor

  delegate :user, :form, to: :context

  def call
    context.fail!(error_message: "Recipient couldn't be found") if recipient.blank?

    create_transfer!
  end

  private

  def create_transfer!
    Transaction.transaction(isolation: :serializable) do
      context.fail!(error_message: "Insufficient balance") if user.balance < form[:quantity]

      user.transactions.create!(operation_type: Transaction::TRANSFER_SENT, quantity: form[:quantity])
      recipient.transactions.create!(operation_type: Transaction::TRANSFER_RECEIVED, quantity: form[:quantity])
    end
  rescue ActiveRecord::ActiveRecordError => e
    context.fail!(error_message: e)
  end

  def recipient
    @recipient ||= User.find_by(email: form[:recipient_email])
  end
end
