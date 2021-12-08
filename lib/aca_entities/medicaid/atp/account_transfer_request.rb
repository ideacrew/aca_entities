# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for AccountTransferRequest
      class AccountTransferRequest < Dry::Struct
        attribute :version,            Types::String.optional.meta(omittable: true)
        attribute :transfer_header,    TransferHeader.meta(omittable: false)
        attribute :senders,            Types::Array.of(Sender).meta(omittable: false)
        attribute :receivers,          Types::Array.of(Receiver).meta(omittable: false)
        attribute :insurance_application,     InsuranceApplication.meta(omittable: false)
        attribute :assister,                Assister.optional.meta(omittable: true)
        attribute :authorized_representative, AuthorizedRepresentative.optional.meta(omittable: true)
        attribute :medicaid_households,       Types::Array.of(MedicaidHousehold).optional.meta(omittable: true)
        attribute :people,                    Types::Array.of(Person).meta(omittable: false)
        attribute :tax_returns,               Types::Array.of(TaxReturn).optional.meta(omittable: true)
        attribute :physical_households, Types::Array do
          attribute :household_size_quantity,    Types::Integer.meta(omittable: false)
          attribute :household_member_references, Types::Array.of(HouseholdMemberReference).meta(omittable: false)
        end
        attribute :verification_metadata,     Types::Array.of(VerificationMetadata).meta(omittable: true)
      end
    end
  end
end