module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
      # Define custom handlers
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
      rescue_from ExceptionHandler::DecodeError, with: :four_zero_one

      rescue_from ActiveRecord::RecordNotFound do |e|
          json_response({ message: e.message }, :not_found)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({ message: e.message }, :unprocessable_entity)
      end
  end

  private

  # JSON response with message; Status code 422 - unprocessable_entity
  def four_twenty_two(e)
      json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with Status code 401 - Unauthorized
  def four_ninety_eight(e)
    render json: { message: e.message }, status: :invalid_token
  end

  # JSON response with Status code 401 - Unauthorized
  def four_zero_one(e)
    render json: { message: e.message }, status: :invalid_token
  end

   # JSON response with Status code 401 - Unauthorized
  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end
