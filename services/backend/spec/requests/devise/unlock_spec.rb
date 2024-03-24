require "swagger_helper"

RSpec.describe "Unlock", type: :request do
  let(:Authorization) { nil }
  let(:user)          { create(:user) }

  after do |example|
    if response.body.present?
      example.metadata[:response][:content] = {
        "application/json" => {
          example: JSON.parse(response.body)
        }
      }
    end
  end

  path "/api/users/unlock" do
    post("Request unlock token") do
      description "Request a unlock token"
      consumes "application/json"
      produces "application/json"
      tags "Unlock"

      parameter name: :body_params, in: :body, schema: {
        "$ref" => "swagger/v1/schemas/unlock.json#/definitions/request_body"
      }

      response(422, "unprocessable entity") do
        let(:body_params) do
          { user: { email: user.email } }
        end

        run_test!
      end

      response(201, "created") do
        let(:body_params) do
          user.lock_access!
          { user: { email: user.email } }
        end

        run_test!
      end
    end

    get("Complete account unlock") do
      description "Complete account unlock"
      consumes "application/json"
      produces "application/json"
      tags "Unlock"

      parameter name: :unlock_token, in: :query

      response(200, "success") do
        let(:unlock_token) { user.send_unlock_instructions }

        run_test!
      end
    end
  end
end
