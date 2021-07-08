# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Insurance Applicant Incarceration
      class Incarceration < Dry::Struct
        attribute :metadata, Types::String.meta(omittable:true)
        attribute :role_reference, IncarcerationDate.optional.meta(omittable: true)
        attribute :incarceration_indicator, Types::Bool.optional.meta(omittable: true)

      end
    end
  end
end
