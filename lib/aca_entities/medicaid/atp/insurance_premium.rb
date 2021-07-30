# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Insurance Premium
      class InsurancePremium < Dry::Struct

        attribute :amount,            Types::Float.optional.meta(omittable: true)
        attribute :aptc_amount,       Types::Float.optional.meta(omittable: true)
        attribute :subscriber_amount, Types::Float.optional.meta(omittable: true)
      end
    end
  end
end
