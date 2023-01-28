# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 contract Form109aUpstreamDetail
      class Form109aUpstreamDetail < Dry::Struct
        attribute :RecordSequenceNum,  AcaEntities::Types::String.meta(omittable: false)
        attribute :TaxYr,  AcaEntities::Types::String.meta(omittable: false)
        attribute :CorrectedInd,  AcaEntities::Types::String.meta(omittable: false)
        attribute :CorrectedRecordSequenceNum, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :VoidInd,  AcaEntities::Types::String.meta(omittable: false)
        attribute :VoidedRecordSequenceNum, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :MarketplaceId,  AcaEntities::Types::String.meta(omittable: false)
        attribute :Policy, AcaEntities::Fdsh::H41::Policy.meta(omittable: false)
        attribute :Recipient, AcaEntities::Fdsh::H41::Recipient.meta(omittable: false)
        attribute :RecipientSpouse, AcaEntities::Fdsh::H41::RecipientSpouse.optional.meta(omittable: true)
        attribute :CoverageHouseholdGrp, AcaEntities::Fdsh::H41::CoverageHouseholdGroup.meta(omittable: false)
        attribute :RecipientPolicyInformation, AcaEntities::Fdsh::H41::RecipientPolicyInformation.meta(omittable: false)
      end
    end
  end
end
