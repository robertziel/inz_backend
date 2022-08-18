require 'spec_helper'

describe Auth::SignUpAPI do
  let(:user_attrs) do
    attributes_for(:user, password: 'password', password_confirmation: 'password')
  end

  describe 'POST sign_up' do
    subject do
      post '/api/auth/sign_up', params: user_attrs
    end

    it 'creates new user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it 'returns success true' do
      subject
      json = response_body_to_json
      expect(json[:success]).to be true
    end

    context 'when password does NOT match confirmation' do
      before do
        user_attrs[:password_confirmation] = 'wrong_password_confirmation'
      end

      it 'returns success false' do
        subject
        json = response_body_to_json
        expect(json[:success]).to be false
      end
    end
  end
end
