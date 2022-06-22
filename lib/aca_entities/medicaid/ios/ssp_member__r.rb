# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for ios SSP_Member__r
      class SSPMemberR < Dry::Struct
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end