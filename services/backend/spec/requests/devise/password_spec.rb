# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Password Reset', type: :request do
  let(:Authorization) { nil }
  let(:user)          { create(:user, :confirmed) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:content] = {
        'application/json' => {
          example: JSON.parse(response.body)
        }
      }
    end
  end

  path '/api/users/password' do
    put('Set a new password for the user') do
      description 'Set the users password'
      consumes 'application/json'
      produces 'application/json'
      tags 'Password Reset'

      parameter name: :body_params, in: :body, schema: {
        '$ref' => 'swagger/v1/schemas/password.json#/definitions/update_body'
      }

      response(204, 'no content') do
        let(:reset_password_token) { user.send(:set_reset_password_token) }
        let(:body_params) do
          {
            user: {
              reset_password_token:  reset_password_token,
              password_confirmation: 'MyP@ssw0rd',
              password:              'MyP@ssw0rd',
              email:                 user.email
            }
          }
        end

        run_test!
      end
    end
    
    post('Request password reset token') do
      description 'Request a password reset token'
      consumes 'application/json'
      produces 'application/json'
      tags 'Password Reset'

      parameter name: :body_params, in: :body, schema: {
        '$ref' => 'swagger/v1/schemas/password.json#/definitions/request_body'
      }

      response(201, 'created') do
        let(:body_params) do
          { user: { email: user.email } }
        end

        run_test!
      end
    end
  end
end
