# frozen_string_literal: true

module AcaEntities
  module Ledger
    # Container class for {AcaEntities::Ledger::UserFeeReportItem} with summary
    #   accumulator values
    class UserFeeReport < Dry::Struct
      # @!attribute [r] id
      # A unique identifier -- typically system-assigned -- for a
      #   User Fee report instance
      # @return [String]
      attribute? :id, Types::String.optional.meta(omittable: true)

      # @!attribute [r] hios_id
      # A CMS-assigned unique identifier for the insurer subject of
      #   this report
      # @return [String]
      attribute :hios_id, Types::Coercible::String.meta(omittable: false)

      # @!attribute [r] user_fee_rate
      # Rate of the premium_amount_total the SBM charges the Insurer
      # @return [Float]
      attribute :user_fee_rate, Types::Float.meta(omittable: false)

      # @!attribute [r] billing_cycle_date
      # Calendar month period covered by this report
      # @return [String]
      attribute :billing_cycle_date, Types::Date.meta(omittable: false)

      # @!attribute [r] premium_amount_total
      # Premiums in dollars for this billing cycle
      # @return [Decimal]
      attribute :premium_amount_total, Types::Decimal.meta(omittable: false)

      # @!attribute [r] fee_amount_total
      # User Fees in dollars for this billing cycle
      # @return [Decimal]
      attribute :user_fee_amount_total, Types::Decimal.meta(omittable: false)

      # @!attribute [r] adjustment_amount_total
      # Adjustments to billed User Fees in dollars for preceding billing cycles
      # @return [Decimal]
      attribute :adjustment_amount_total, Types::Decimal.meta(omittable: false)

      # @!attribute [r] user_fee_amount_due
      # Adjustments to billed User Fees in dollars for preceding billing cycles
      # @return [Decimal]
      attribute :user_fee_amount_due, Types::Decimal.meta(omittable: false)

      # @!attribute [r] user_fee_report_items
      # {CustomerAccount}[CustomerAccounts] lines itemizing the billed amounts and adjustments
      # @return [DateTime]
      # attribute :user_fee_report_items, Types::Array.of(UserFeeReportItems).meta(omittable: true)

      # @!attribute [r] report_timestamp
      # The moment when this report was generated
      # @return [DateTime]
      attribute? :report_timestamp, Types::DateTime.meta(omittable: true)

      def billing_cycle_month
        billing_cycle_date.strftime('%m')
      end

      def billing_cycle_year
        billing_cycle_year.strftime('%Y')
      end
    end
  end
end
