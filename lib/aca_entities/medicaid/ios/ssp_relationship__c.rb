# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for SSP_Relationship__c
      class SSP_Relationship__c < Dry::Struct
        attribute :SSP_MemberRelatedTo__c, Types::String.optional.meta(omittable: true)
        attribute :SSP_Member__c, Types::String.optional.meta(omittable: true)
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :IntendToPursueLegalCustodyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsActingParentToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsCareTakerToggle__c, Types::String.optional.meta(omittable: true)
        attribute :RelationshipType__c, Types::String.meta(omittable: false) # RequiredValidator, Relationship Validator
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :SSP_Member__r, SSP_Member__r.optional.meta(omittable: true)
      end
    end
  end
end