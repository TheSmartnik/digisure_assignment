class Transactions::Create
  include Interactor

  delegate :transaction_params, :user, to: :context

  def call
    validation_result = validation_class.call(transaction_params.except('operation_type'))
    context.fail!(error_message: format_validation_errors(validation_result)) if validation_result.failure?

    command_result = command_class.call(user: user, form: validation_result)
    context.fail!(error_message: command_result.error_message) if command_result.failure?
  end

  private

  def format_validation_errors(result)
    result.errors.messages.map { |error| "#{error.path.first} #{error.text}" }.join
  end

  def validation_class
    Transactions.const_get("#{operation_type}Contract").new
  rescue NameError
    context.fail!(error_message: "Invalid operation type")
  end

  def command_class
    Transactions.const_get(operation_type)
  rescue NameError
    context.fail!(error_message: "Invalid operation type")
  end

  def operation_type
    @operation_type ||= transaction_params['operation_type'].classify
  end
end
