# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for Primary
        class PrimaryContract < Dry::Validation::Contract
          params do
            required(:exchange_assigned_member_id).filled(:string)
            required(:member_name).filled(AcaEntities::PayNow::CareFirst::Contracts::MemberNameContract.params)
          end
        end
      end
    end
  end
end
