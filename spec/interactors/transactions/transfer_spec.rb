# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Transfer do
  describe '#call' do
    let(:user) { create :user }
    let(:recipient) { create :user }
    let(:form) { { recipient_email: recipient.email, quantity: 1000 } }

    subject(:command_result) do
      described_class.call(user: user, form: form)
    end

    before { allow(Transaction).to receive(:transaction).and_yield }

    context 'when params are valid' do
      before do
        user.transactions.create(operation_type: Transaction::DEPOSIT, quantity: 1000)
      end

      it 'makes transfer' do
        expect(command_result).to be_success
        expect(user.balance).to eq(0)
        expect(recipient.balance).to eq(1000)
      end
    end

    context 'when balance is insufficient' do
      it 'returnes error' do
        expect(command_result).to be_failure
        expect(command_result.error_message).to eq("Insufficient balance")
      end
    end

    context 'when email is wrong' do
      let(:form) { { recipient_email: "random@email.com", quantity: 1000 } }

      it 'returnes error' do
        expect(command_result).to be_failure
        expect(command_result.error_message).to eq("Recipient couldn't be found")
      end
    end
  end
end
