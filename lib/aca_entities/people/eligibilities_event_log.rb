# frozen_string_literal: true

module AcaEntities
  module People
    # Entity for IVL Eligibilities Event Log
    class EligibilitiesEventLog < Dry::Struct
      include EventLog
    end
  end
end
