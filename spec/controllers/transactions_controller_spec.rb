# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  let(:user) { create :user }

  describe '#index' do
    before do
      create_list :transaction, 2, user: user
      create :transaction, user: user, operation_type: Transaction::TRANSFER_SENT
    end

    specify do
      get :index
      expect(response).to be_successful

      json = JSON.parse(response.body)
      expect(json.count).to eq(3)
    end
  end

  describe '#create' do
    let!(:user) { create :user }

    context 'when params are valid' do
      specify do
        post :create, params: { transaction: { operation_type: 'deposit', quantity: 1000 }}
        expect(response).to be_successful

        expect(user.reload.balance).to eq(1000)
      end
    end

    context 'when params are invalid' do
      specify do
        post :create, params: { transaction: { operation_type: 'deposit', amount: 1000 }}
        expect(response.status).to eq(422)

        json = JSON.parse(response.body)
        expect(json['error_message']).to eq('quantity is missing')
      end
    end
  end
end
