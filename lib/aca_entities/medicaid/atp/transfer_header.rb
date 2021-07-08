# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TransferHeader information
      class TransferHeader < Dry::Struct
        attribute :transfer_activity,            TransferActivity.meta(omittable: false)
      end
    end
  end
end
