# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    module Contracts
      # Schema and validation rules for the {AcaEntities::PremiumCredits::Member} entity
      class MemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :id unique identifier (optional)
        # @option opts [AcaEntities::PremiumCredits::Types::MemberKind] :kind the type of premium credit (required)
        # @option opts [String] :value the credit amount or reference (required)
        # @option opts [Date] :start_on  (required)
        # @option opts [Date] :end_on  (optional)
        # @option opts [AcaEntities::Contracts::Families::FamilyMemberReferenceContract] :family_member_reference  (required)
        # @option opts [AcaEntities::Contracts::TimeStampContract] :timestamps (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation

        params do
          optional(:id).maybe(:string)
          required(:kind).filled(AcaEntities::PremiumCredits::Types::MemberKind)
          required(:value).filled(:string)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
