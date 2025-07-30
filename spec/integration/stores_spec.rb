require 'swagger_helper'

RSpec.describe 'Stores', type: :request do
  path '/api/v1/stores' do
    get 'List all stores' do
      tags 'Stores'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, required: true

      response '200', 'stores listed' do
        let(:user) { User.create!(name: "Test User", email: "test@example.com", password: "password") }
        let(:Authorization) do
          token = JWT.encode({ user_id: user.id }, Rails.application.credentials.jwt_secret)
          "Bearer #{token}"
        end

        before { Store.create!(name: "Test Store") }

        run_test!
      end
    end
  end
end
