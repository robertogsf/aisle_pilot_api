require 'swagger_helper'

RSpec.describe 'Auth', type: :request do
  path '/api/v1/register' do
    post 'Register a new user' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        required: %w[name email password],
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '201', 'user registered' do
        let(:user) do
          {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:user) do
          {
            email: 'invalid-email',
            password: 'short',
            password_confirmation: 'mismatch'
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/login' do
    post 'Login a user' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        required: %w[email password],
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'login successful' do
        let!(:user) do
          User.create!(
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end

        let(:credentials) do
          {
            email: user.email,
            password: 'password123'
          }
        end

        run_test!
      end

      response '401', 'invalid credentials' do
        let(:credentials) do
          {
            email: 'foo',
            password: 'bar'
          }
        end

        run_test!
      end
    end
  end
end
