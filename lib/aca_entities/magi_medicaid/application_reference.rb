# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for ApplictionReference.
    class ApplictionReference < Dry::Struct

      # hbx_id of the FinancialAssistanceApplication.
      attribute :hbx_id, Types::String
    end
  end
end
