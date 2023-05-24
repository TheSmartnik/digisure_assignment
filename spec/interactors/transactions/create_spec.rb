# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Create do
  let(:user) { create :user }

  context 'when params are correct' do
    let(:transaction_params) do
      { 'quantity' => 1000, 'operation_type' => 'deposit' }
    end

    it 'calls approriate classes' do
      expect(Transactions::DepositContract).to receive(:new).and_call_original
      expect(Transactions::Deposit).to receive(:call).and_call_original

      result = described_class.call(user: user, transaction_params: transaction_params)
      expect(result).to be_success
    end
  end

  context 'when form are invalid' do
    let(:transaction_params) do
      { 'amount' => 1000, 'operation_type' => 'deposit' }
    end

    it 'calls approriate classes' do
      expect(Transactions::DepositContract).to receive(:new).and_call_original
      expect(Transactions::Deposit).to_not receive(:call).and_call_original

      result = described_class.call(user: user, transaction_params: transaction_params)
      expect(result).to be_failure
    end
  end

  context 'when command params are invalid' do
    let(:transaction_params) do
      { 'amount' => 1000, 'operation_type' => 'transfer', recipient_email: 'random@email.com' }
    end

    it 'calls approriate classes' do
      result = described_class.call(user: user, transaction_params: transaction_params)
      expect(result).to be_failure
    end
  end
end
