# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Operations
    # This class takes AcaEntities::Contracts::People::PersonContract params as input and returns the AcaEntities::People::Person entity
    class CreatePerson
      include Dry::Monads[:result, :do]
      # @param [Hash] params The options to create the AcaEntities::People::Person instance
      # @option params [String] :hbx_id HBX-assigned unique identifier for this person
      # @option params [Hash] :person_name first_name last_name
      # @option params [Bool] :is_active
      # @option params [Hash] :person_demographics dob gender encrypted_ssn
      def call(params)
        values = yield validate_params(params)
        person = yield create_person(values)

        Success(person)
      end

      private

      def validate_params(params)
        result = ::AcaEntities::Contracts::People::PersonContract.new.call(params)

        if result.success?
          Success(result.to_h)
        else
          Failure(result.errors.to_h)
        end
      end

      def create_person(values)
        Success(::AcaEntities::People::Person.new(values))
      end
    end
  end
end
