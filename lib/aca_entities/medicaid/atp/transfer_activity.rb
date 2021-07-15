# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for Transfer Activity information
      class TransferActivity < Dry::Struct
        attribute :transfer_id,            ActivityIdentification.meta(omittable: false)
        attribute :transfer_date,          ActivityDate.optional.meta(omittable: true)
        attribute :number_of_referrals,    Types::Integer
        attribute :recipient_code,         ::AcaEntities::Medicaid::Atp::Types::TransferHeaderRecipientCode.meta(omittable: false)
        attribute :state_code,             Types::String.optional.meta(omittable: true)
      end
    end
  end
end
