# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for AccountTransferRequest
      class AccountTransferRequest < Dry::Struct

        attribute :transfer_header,    TransferHeader.meta(omittable: false)
        attribute :senders,            Types::Array.of(Sender).meta(omittable: false)
        attribute :receivers,          Types::Array.of(Receiver).meta(omittable: false)

        attribute :physical_households, Types::Array do
          attribute :household_size_quantity,    Types::Integer.optional.meta(omittable: false)
          attribute :household_member_reference, Types::Array.of(Types::Integer).meta(omittable: false)
        end

        attribute :insurance_application, InsuranceApplication.meta(omittable: false)
        attribute :medicaid_households,   Types::Array.of(MedicaidHousehold).meta(omittable: false) #MedicaidHousehold.meta(omittable: false)
        attribute :people,                Types::Array.of(Person).meta(omittable: false) #Applicant.meta(omittable: false)

      end
    end
  end
end
