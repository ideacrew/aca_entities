# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for ios SSP_Member__r
      class SSP_Member__r < Dry::Struct
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end