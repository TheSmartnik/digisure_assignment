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
end
