# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for Member
        class MemberContract < Dry::Validation::Contract
          params do
            required(:exchange_assigned_member_id).filled(:string)
            required(:member_name).filled(Contracts::MemberNameContract.params)
            required(:birth_date).filled(:string)
            required(:sex).filled(Types::SexofIndividualTerminologyType)
            optional(:ssn).maybe(:string)
            required(:relationship).filled(Types::PaynowMemberRelationshipCode)
            required(:is_subscriber).filled(:bool)
          end
        end
      end
    end
  end
end


