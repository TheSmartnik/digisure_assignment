# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe '#create' do
    let(:email) { 'valid@email.com' }
    let(:attributes) do
      { email: email, password: '123456' }
    end

    subject(:create_request) do
      post :create, params: { user: attributes }
    end

    it 'creates user' do
      expect { create_request  }.to change { User.count }.by(1)
      expect(response).to be_successful

      json = JSON.parse(response.body)
      expect(json['email']).to be_present
      expect(json['auth_token']).to be_present
    end

    context 'when email is invalid' do
      let(:email) { 'invalid@emailcom' }

      it 'raises error' do
        expect { create_request }.to_not change { User.count }
        expect(response.status).to eq(422)

        json = JSON.parse(response.body)
        expect(json['error_message']).to eq("Email is invalid")
      end
    end

    context 'when user aleady exists' do
      before { create :user, email: email }

      it 'raises error' do
        create_request
        expect(response.status).to eq(422)

        json = JSON.parse(response.body)
        expect(json['error_message']).to eq("Email has already been taken")
      end
    end
  end

  describe '#show' do
    let(:user) { create :user }

    before { create_list :transaction, 2, user: user }

    specify do
      get :show
      expect(response).to be_successful

      json = JSON.parse(response.body)
      expect(json['email']).to be_present
      expect(json['balance']).to eq(200)
      expect(json['auth_token']).to be_blank
    end
  end
end
