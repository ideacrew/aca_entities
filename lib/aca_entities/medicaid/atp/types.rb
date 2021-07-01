# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Shared type definitions for Account Transfer Protocol.
      module Types
        include Dry::Types()

        TransferHeaderRecipientCode = String.enum("Exchange", "MedicaidCHIP")
      end
    end
  end
end