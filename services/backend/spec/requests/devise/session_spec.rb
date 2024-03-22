# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Authentication', type: :request do
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
  
  path '/api/users/sign_in' do
    post('Request session token') do
      description 'Request a JWT token'
      consumes 'application/json'
      produces 'application/json'
      tags 'Authentication'

      parameter name: :body_params, in: :body, schema: {
        '$ref' => 'swagger/v1/schemas/session.json#/definitions/request_body'
      }

      response(401, 'unauthorized') do
        schema '$ref' => 'swagger/v1/schemas/session.json#/definitions/failure'

        let(:body_params) do
          { user: { email: 'noone@example.com', password: 'bad password' } }
        end

        run_test!
      end

      response(201, 'created') do
        schema '$ref' => 'swagger/v1/schemas/session.json#/definitions/success'

        let(:body_params) do
          { user: { email: user.email, password: user.password } }
        end

        it 'returns the resource url in the location header' do
          expect(response.headers['Authorization']).to be
        end

        run_test!
      end
    end
  end

  path '/api/users/sign_out' do
    delete('Destroy session') do
      description 'Invalidate JWT Token'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      tags 'Authentication'

      response(204, 'no content') do
        run_test!
      end
    end
  end
end
