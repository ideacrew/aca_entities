# frozen_string_literal: true

module AcaEntities
  module BenefitCatalogs
    class BenefitPackageReference < Dry::Struct

      attribute :title,                                       Types::String.optional.meta(omittable: false)
      attribute :elected_premium_credit_strategy,             Types::PremiumCreditStrategyKinds.optional.meta(omittable: false)
    end
  end
end