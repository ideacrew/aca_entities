# frozen_string_literal: true

module AcaEntities
  module EventLogs
    class PersonEventLogContract < Dry::Validation::Contract

      params(EventLogContract.schema) do
        required(:custom_person_field).filled(:string)
      end
    end
  end
end
