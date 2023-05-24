class TransactionsController < ApplicationController
  def index
    transactions = current_user.transactions

    render json: TransactionBlueprint.render(transactions)
  end
end
