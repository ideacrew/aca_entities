# frozen_string_literal: true

require 'aca_entities/types'

module AcaEntities
  module Operations
    module DateTimeTransforms
      # Class to convert a Time object to a string in ISO8601 format
      class ConvertTimeToString
        include Dry::Monads[:do, :result]

        # Converts a Time object to a string in ISO8601 format
        #
        # @param params [Hash] the parameters containing the Time object
        # @option params [Time] :time the Time object to be converted
        # @return [Dry::Monads::Result::Success<String>, Dry::Monads::Result::Failure<String>] the result of the conversion
        def call(params)
          time        = yield validate(params)
          time_string = yield convert(time)

          Success(time_string)
        end

        private

        # Validates the input parameters
        #
        # @param params [Hash, nil] the parameters containing the Time object
        # @option params [Time] :time the Time object to be validated
        # @return [Dry::Monads::Result::Success<Time>, Dry::Monads::Result::Failure<String>] the result of the validation
        def validate(params)
          return Failure('Invalid input: params cannot be nil.') if params.nil?
          time = params[:time]

          if time.nil?
            Failure("Invalid input: #{params}. Time is required.")
          elsif !time.is_a?(Time)
            Failure("Invalid input: #{params}. Time must be a Time object.")
          else
            Success(time)
          end
        end

        # Converts the Time object to a string in ISO8601 format
        #
        # @param time [Time] the Time object to be converted
        # @return [Dry::Monads::Result::Success<String>] the result of the conversion
        def convert(time)
          Success(time.strftime(AcaEntities::Types::DATETIME_FORMAT_ISO8601))
        end
      end
    end
  end
end
