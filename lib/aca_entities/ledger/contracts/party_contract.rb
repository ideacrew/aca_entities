# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Party}
      class PartyContract < Contract
        params do
          optional(:id).value(:string)
          optional(:party_role).value(AcaEntities::Ledger::Types::PartyRoleKind)
          optional(:party_role_relationship).value(AcaEntities::Ledger::Types::AllPartyRoleRelationshipKind)
          optional(:start_on).filled(:date)
          optional(:end_on).filled(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
