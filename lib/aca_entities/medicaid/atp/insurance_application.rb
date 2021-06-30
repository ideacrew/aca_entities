# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplication
      class InsuranceApplication < Dry::Struct

        attribute :applicants, Types::Array.of(InsuranceApplicant).meta(omittable: false) 
        attribute :requesting_financial_assistance, Types::Bool.meta(omittable: false)
        attribute :requesting_medicaid, Types::Bool.meta(omittable: false)
        attribute :ssf_primary_contact, SsfPrimaryContact.meta(omittable: false)
        attribute :tax_return_access_indicator, Types::Bool.meta(omittable: false)
      end
    end
  end
end
