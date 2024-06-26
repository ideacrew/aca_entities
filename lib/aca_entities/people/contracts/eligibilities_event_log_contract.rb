# frozen_string_literal: true

module AcaEntities
  module People
    # contract for IVL Eligibilities EventLog
    class EligibilitiesEventLogContract < Dry::Validation::Contract

      params(AcaEntities::EventLogs::EventLogContract.schema) do
        # Fields specific to the resource model can be included in this section, as illustrated below.
        # required(:custom_person_field).filled(:string)
      end
    end
  end
end
