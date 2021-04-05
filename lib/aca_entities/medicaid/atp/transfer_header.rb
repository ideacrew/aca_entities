# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TransferHeader information
      class TransferHeader < Dry::Struct
        attribute :transfer_id,            Types::String
        attribute :transfer_date,          Types::DateTime
        attribute :number_of_referrals,    Types::Integer
        attribute :recipient_code,         Types::String
        attribute :medicaid_chip_state,    Types::String.optional.meta(omittable: true)
      end
    end
  end
end
