# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for AccountTransferRequest
      class AccountTransferRequest < Dry::Struct

        attribute :transfer_header,   TransferHeader.meta(omittable: false)
        attribute :sender,            Sender.meta(omittable: false)
        attribute :receiver,          Receiver.meta(omittable: false)

        attribute :physical_household do
          attribute :household_size_quantity,    Types::Integer.optional.meta(omittable: false)
          attribute :household_member_reference, Types::Array.of(Types::Integer).meta(omittable: false)
        end

        attribute :insurance_application, InsuranceApplication.meta(omittable: false)
        attribute :medicaid_household,    MedicaidHousehold.meta(omittable: false)
        attribute :person,                Applicant.meta(omittable: false)

      end
    end
  end
end
