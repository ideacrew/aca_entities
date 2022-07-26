# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::IrsGroup}
      class IrsGroupContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:irs_group_id).filled(:string)
          required(:assistance_year).filled(:integer, min_size?: 4, gt?: 2013)
          required(:members).array(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
