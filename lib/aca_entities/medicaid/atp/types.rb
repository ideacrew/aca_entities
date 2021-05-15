# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      module Types
        include Dry::Types()

        TransferHeaderRecipientCode = String.enum("Exchange", "MedicaidCHIP")
      end
    end
  end
end