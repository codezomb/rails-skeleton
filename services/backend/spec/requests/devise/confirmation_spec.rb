# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Password Reset', type: :request do
  let(:Authorization) { nil }
  let(:user)          { create(:user) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:content] = {
        'application/json' => {
          example: JSON.parse(response.body)
        }
      }
    end
  end

  path '/api/users/confirmation' do
    post('Request confirmation token') do
      description 'Request a confirmation token'
      consumes 'application/json'
      produces 'application/json'
      tags 'Email Confirmation'

      parameter name: :body_params, in: :body, schema: {
        '$ref' => 'swagger/v1/schemas/confirmation.json#/definitions/request_body'
      }

      response(422, 'unprocessable entity') do
        let(:body_params) do
          user.update(confirmed_at: Time.now)
          { user: { email: user.email } }
        end

        run_test!
      end

      response(201, 'created') do
        let(:body_params) do
          { user: { email: user.email } }
        end

        run_test!
      end
    end

    get('Complete account confirmation') do
      description 'Complete account confirmation'
      consumes 'application/json'
      produces 'application/json'
      tags 'Email Confirmation'

      parameter name: :confirmation_token, in: :query

      response(200, 'success') do
        let(:confirmation_token) { user.confirmation_token }

        run_test!
      end
    end
  end
end
