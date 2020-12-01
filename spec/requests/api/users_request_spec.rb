require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe 'POST /users' do
    let(:user_params) { { user: { name: 'dyson', email: 'dyson@example.com', password: '12345678', password_confirmation: '12345678' } } }
    it 'ユーザーが作成できること' do
      post api_users_path, params: user_params
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['user']).to include({
                                          'id' => be_present,
                                          'name' => 'dyson',
                                          'email' => 'dyson@example.com',
                                      })
    end

    let(:invalid_user_params) { { user: { name: 'dyson', email: 'dyson@example.com', password: '12345678', password_confirmation: '1234' } } }
    it 'ユーザーの作成に失敗すること' do
      post api_users_path, params: invalid_user_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['error']).to be_present
    end
  end
end
