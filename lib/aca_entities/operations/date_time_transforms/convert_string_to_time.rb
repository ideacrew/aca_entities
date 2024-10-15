# frozen_string_literal: true

require 'aca_entities/types'

module AcaEntities
  module Operations
    module DateTimeTransforms
      # Class to convert a string to a Time object
      class ConvertStringToTime
        include Dry::Monads[:do, :result]

        # Converts a string to a Time object
        #
        # @param params [Hash] the input parameters containing the string
        # @option params [String] :time_string the string to be converted to Time
        # @return [Dry::Monads::Result::Success<Time>, Dry::Monads::Result::Failure<String>] the result of the conversion
        def call(params)
          time_string = yield validate(params)
          time        = yield convert(time_string)

          Success(time)
        end

        private

        # Validates the input parameters
        #
        # @param params [Hash] the input parameters
        # @option params [String] :time_string the string to be validated
        # @return [Dry::Monads::Result::Success<String>, Dry::Monads::Result::Failure<String>] the result of the validation
        def validate(params)
          return Failure('Invalid input: params cannot be nil.') if params.nil?
          time_string = params[:time_string]

          if time_string.nil?
            Failure("Invalid input: #{params}. Time string is required.")
          elsif !time_string.is_a?(String)
            Failure("Invalid input: #{params}. Time string must be a String.")
          else
            Success(time_string)
          end
        end

        # Converts the validated time string to a Time object
        #
        # @param time_string [String] the validated time string
        # @return [Dry::Monads::Result::Success<Time>, Dry::Monads::Result::Failure<String>] the result of the conversion
        def convert(time_string)
          Success(Time.strptime(time_string, AcaEntities::Types::DATETIME_FORMAT_ISO8601))
        rescue ArgumentError => e
          Failure(
            "Invalid time format: #{e.message} with time input: #{time_string}. Time string must match the format #{
              AcaEntities::Types::DATETIME_FORMAT_ISO8601
            }."
          )
        end
      end
    end
  end
end
