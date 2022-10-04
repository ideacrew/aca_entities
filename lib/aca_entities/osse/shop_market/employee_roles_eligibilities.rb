# frozen_string_literal: true

module AcaEntities
  module Osse
    module ShopMarket
      class EmployeeRolesEligibilities < Dry::Struct
        attribute? :id, Types::String.optional.meta(omittable: true)
        attribute :employee_role, EmployeeRole.required.meta(omittable: false)
        attribute :eligibility, AcaEntities::Eligibilities::Eligibility.required.meta(omittable: false)
        attribute :timestamps
      end
    end
  end
end
