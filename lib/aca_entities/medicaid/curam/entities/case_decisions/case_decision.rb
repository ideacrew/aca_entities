# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module CaseDecisions
        # entity for CaseDecision
        class CaseDecision < Dry::Struct

          attribute :ids,  					 Types::Array.of(Curam::Identifiers::Id).optional.meta(omittable: true)
          attribute :product_delivery_case_id, Curam::Identifiers::IdReference.optional.meta(omittable: true)
          attribute :person, 		             Curam::People::Person.meta(omittable: false)
          attribute :amount,                   Types::Decimal.meta(omittable: false)
          attribute :nominee_delivery_method,  Types::String.meta(omittable: false)
          attribute :frequency,                Types::EvidenceIncomeFrequencyKind.meta(omittable: false)
          attribute :start_date,               Types::Date.meta(omittable: false)
          attribute :end_date,                 Types::Date.meta(omittable: false)
          attribute :product_name,             Types::String.meta(omittable: false)
          attribute :product_kind,             Types::String.meta(omittable: false)
          attribute :product_id,               Types::String.meta(omittable: false)
          attribute :version_number,           Types::String.optional.meta(omittable: true)
          attribute :determination_datetime,   Types::DateTime.meta(omittable: false)
          attribute :last_updated_at,          Types::DateTime.meta(omittable: false)
        end
      end
    end
  end
end
