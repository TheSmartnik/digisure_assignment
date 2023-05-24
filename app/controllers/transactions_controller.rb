class TransactionsController < ApplicationController
  def index
    transactions = current_user.transactions.page(params[:page])

    render json: TransactionBlueprint.render(transactions)
  end

  def create
    result = Transactions::Create.call(user: current_user, transaction_params: transaction_params.to_unsafe_hash)

    if result.success?
      head :ok
    else
      api_error(result.error_message)
    end
  end

  def transaction_params
    @transaction_params ||= params.require(:transaction)
  end
end
