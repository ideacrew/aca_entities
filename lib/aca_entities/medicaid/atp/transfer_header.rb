# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TransferHeader information
      class TransferHeader < Dry::Struct
        attribute :transfer_id,            Types::String
        attribute :transfer_date,          Types::DateTime
        attribute :number_of_referrals,    Types::Integer
        attribute :recipient_code,         ::AcaEntities::Medicaid::Atp::Types::TransferHeaderRecipientCode
        attribute :state_code,             Types::String.optional.meta(omittable: true)
      end
    end
  end
end
