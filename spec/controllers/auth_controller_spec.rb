# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthController do
  let(:password) { '1234567' }

  let(:user) { create :user, password: password }

  specify do
    post :create, params: { user: { password: password, email: user.email } }
    expect(response).to be_successful
  end

  context 'when password is incorrect' do
    specify do
      post :create, params: { user: { password: '123', email: user.email } }
      expect(response.status).to eq(404)
    end
  end

  context 'when email is incorrect' do
    specify do
      post :create, params: { user: { password: '123', email: 'user@email.com' } }
      expect(response.status).to eq(404)
    end
  end
end
