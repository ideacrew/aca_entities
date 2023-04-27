# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Operations
    # This class takes AcaEntities::Contracts::Families::FamilyContract params as input and returns the AcaEntities::Families::Family entity
    class CreateFamily
      include Dry::Monads[:result, :do]
      # @param [Hash] opts The options to create the AcaEntities::Families::Family instance
      # @option opts [Array<FamilyMember>] :family_members All current and past members of this family
      # @option opts [Array<Household>] :households Physical households over time with family_member composition
      # @option opts [Array<TaxHouseholdGroup>] :tax_household_groups Physical tax_household_groups over time with eligibility determinations
      # @option opts [String] :hbx_id HBX-assigned unique identifier for this family
      # @option opts [String] :irs_group_id
      # @option opts [Array] :foreign_keys
      # @option opts [Integer] :renewal_consent_through_year
      # @option opts [Date] :min_verification_due_date
      # @option opts [Array<AcaEntities::MagiMedicaid::Application>] :magi_medicaid_applications All financial assistance applications
      # @option opts [Array<Document>] :documents List of documents associated with Family
      # @option opts [Array<SpecialEnrollmentPeriod>] :special_enrollment_periods
      # @option opts [Array<BrokerAccount>] :broker_accounts
      # @option opts [Array<GeneralAgencyAccount>] :general_agency_accounts
      # @option opts [Array<AcaEntities::Groups::IrsGroup>] :irs_groups
      # @option opts [Array<PaymentTransaction>] :payment_transactions
      # @option opts [PersonReference] :updated_by
      # @option opts [TimeStamp] :timestamp
      # @option opts [Bool] :documents_needed
      # @return [Dry::Monads::Result]
      def call(params)
        values = yield validate_params(params)
        family = yield create_family(values)

        Success(family)
      end

      private

      def validate_params(params)
        result = ::AcaEntities::Contracts::Families::FamilyContract.new.call(params)

        if result.success?
          Success(result.to_h)
        else
          Failure(result.errors.to_h)
        end
      end

      def create_family(values)
        Success(::AcaEntities::Families::Family.new(values))
      end
    end
  end
end
