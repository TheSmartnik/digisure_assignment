# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'api_token' do
    let(:user) { create :user }

    it 'creates token on first call' do
      expect { user.api_token }.to change { ApiToken.count }.by(1)
    end

    it 'reuses token on subsequent calls' do
      user.api_token

      expect { user.reload.api_token }.to_not change { ApiToken.count }
    end
  end
end
