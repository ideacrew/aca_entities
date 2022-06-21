# frozen_string_literal: true

module AcaEntities
  module Enrollments
    module Contracts
      # Schema and validation rules for the {AcaEntities::Enrollments::PremiumCredit} entity
      class MemberPremiumCreditContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :id unique key for this entity (optional)
        # @option opts [AcaEntities::Enrollments::Types::PremiumCreditKind] :kind the type of premium credit (required)
        # @option opts [String] :source_id reference to the authority granting this credit (optional)
        # @option opts [String] :value the credit amount or reference (required)
        # @option opts [AcaEntities::Contracts::TimeStampContract] :timestamps (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).maybe(:string)
          optional(:label).maybe(:string)
          required(:kind).filled(AcaEntities::Enrollments::Types::PremiumCreditKind)
          optional(:authority_determination).maybe(:any)

          required(:tax_household).filled(:tax_hh)
          required(:benchmark_plan_ref).filled(:tax_hh)

          required(:start_on).filled(:date)
          optional(:end_on).maybe(AcaEntities::Types::DateOrNil)

          required(:month_0).filled(:monthly_premium_credits)
          required(:month_1).filled(:monthly_premium_credits)
          required(:month_2).filled(:monthly_premium_credits)
          required(:month_3).filled(:monthly_premium_credits)
          required(:month_4).filled(:monthly_premium_credits)
          required(:month_5).filled(:monthly_premium_credits)
          required(:month_6).filled(:monthly_premium_credits)

          required(:month_7).filled(:monthly_premium_credits)
          required(:month_8).filled(:monthly_premium_credits)
          required(:month_9).filled(:monthly_premium_credits)
          required(:month_10).filled(:monthly_premium_credits)
          required(:month_11).filled(:monthly_premium_credits)
          required(:month_12).filled(:monthly_premium_credits)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

# TimePeriods::Months::012022

class MonthlyPremiumCreditContract < Contract
  params do
    required(:determined_value).filled(:string)
    required(:actual_value).filled(:string)
    required(:month).filled(TimePeriods::Months)
    optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
  end
end

class GroupPremiumCredit
  include Mongoid::Document
  belongs_to :family
  belongs_to :application

  field :kind, type: GroupPremiumCreditKinds
end

class MemberPremiumCredit
  include Mongoid::Document
  belongs_to :family
  belongs_to :application
end

class AptcPremiumCredit < GroupPremiumCredit
  include Mongoid::Document
end

class AptcMemberPremiumCredit < MemberPremiumCredit
end

class HbxEnrollmentMemberContract < Contract
  params { required(:family_member_id).filled(:string) }
end

# Questions/Gaps
# 1. HbxEnrollments are immutable.  How do we update

class Family
  include Mongoid::Document
  embeds_many :family_members

  has_many :aptc_applications
  has_many :group_premium_credits
end

class FamilyMember
  include Mongoid::Document

  belongs_to :family
  has_many :aptc_applicants
  has_many :applications, through: :applicant
end

class AptcApplication
  include Mongoid::Document

  belongs_to :family
  embeds_many :applicants
  has_many :family_members, through: :applicant
end

class AptcApplicant
  include Mongoid::Document
  embedded_in :aptc_application

  # belongs_to :family_member
  def self.family_member; end
end

class GroupPremiumCreditKinds
  aca_individual_market_kinds = %i[aptc].freeze
  aca_shop_market_kinds = %i[employer_contribution].freeze

  # Check marketplace config settings to determine credit kinds valid for this site
  aca_individual_market_kinds + aca_shop_market_kinds
end

family = Family.new
application = Application.new
application
  .applicants
  .reduce([]) do |applicant|
    tax_household.tax_household_member.build(
      is_ia_eligible: applicant.is_ia_eligible,
      family_member: applicant.family_member
    )
  end
