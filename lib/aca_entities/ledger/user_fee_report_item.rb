# frozen_string_literal: true

require 'date'

module AcaEntities
  module Ledger
    # Schema and validation rules for {AcaEntities::Ledger::Product}
    class UserFeeReportItem < Dry::Struct
      # include ::AcaEntities::Operations::Mongoid::ModelAdapter

      attribute? :sequence_value, Types::Integer.meta(omittable: true)
      attribute? :transaction_type, Types::Integer.meta(omittable: true)
      attribute :user_fee_item_kind, ::AcaEntities::Ledger::Types::UserFeeReportItemKind.meta(omittable: false)
      attribute :hios_id, Types::String.meta(omittable: false)
      attribute :customer_id, Types::String.meta(omittable: false)
      attribute :policy_subscriber_hbx_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_hbx_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_last_name, Types::String.meta(omittable: false)
      attribute :enrolled_member_first_name, Types::String.meta(omittable: false)
      attribute :exchange_assigned_policy_id, Types::String.meta(omittable: false)
      attribute :insurer_assigned_subscriber_id, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :insurer_policy_id, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :hbx_qhp_id, Types::String.meta(omittable: false)
      attribute :marketplace_segment_id, Types::String.meta(omittable: false)
      attribute :enrolled_member_billing_cycle_start_on, Types::Date.meta(omittable: false)
      attribute :enrolled_member_billing_cycle_end_on, Types::Date.meta(omittable: false)
      attribute :aptc_amount, Types::Decimal.meta(omittable: false)
      attribute :enrolled_member_premium_amount, Types::Decimal.meta(omittable: false)
      attribute :enrolled_member_user_fee_amount, Types::Decimal.meta(omittable: false)
      attribute :external_doc_reference, AcaEntities::Types::StringOrNil.meta(omittable: true)
      attribute :created_at, Types::DateTime.meta(omittable: false)
      attribute :updated_at, Types::DateTime.meta(omittable: false)

      # Populate calculated attributes before struct finished initialization
      def initialize(*args)
        params = args.first

        # Source: Preaudit IndividualPremiumEffectiveDate Column
        premium_start_on = extract_date_from_segment(params[:marketplace_segment_id])

        # Source: Preaudit IndividualPremiumEndDate Column
        premium_end_on = params[:enrolled_member_billing_cycle_end_on]

        policy_premium_amt = params[:enrolled_member_premium_amount].to_f
        member_premium_amt = calculate_premium(premium_start_on, premium_end_on, policy_premium_amt).to_d
        enrolled_member_user_fee_amount = calculate_user_fee(member_premium_amt).to_d
        args.first.merge!(
          { member_premium_amt: member_premium_amt, enrolled_member_user_fee_amount: enrolled_member_user_fee_amount }
        )

        super(args)
      end

      # TODO Add support for ACA list bill > 4 children no extra premium charge
      def calculate_user_fee(premium_amount, user_fee_factor = 0.03)
        currencyize(premium_amount * user_fee_factor)
      end

      # Returns premium cost for a date range.
      def calculate_premium(start_date, end_date, monthly_premium_amount)
        months = split_date_period_to_months(start_date, end_date)
        months.sum(0.0) { |month| month_of_year_premium(month[0], month[1], monthly_premium_amount) }
      end

      # Returns a premium for one full or partial month.  The premium value will prorate for partial month
      #   coverage.
      def month_of_year_premium(start_date, end_date, premium_amount)
        date_error = 'dates must fall within same month/year'
        raise ArgumentError, date_error unless start_date.month == end_date.month && start_date.year == end_date.year

        return currencyize(0.0) unless end_date.day - start_date.day > 0

        days_this_month = days_in_month(start_date.year, start_date.month)
        insured_days_count = end_date.day - start_date.day + 1
        return premium_amount if insured_days_count == days_this_month

        raw_premium = premium_amount / days_this_month * insured_days_count
        currencyize(raw_premium)
      end

      def find_preceding_month_record(hbx_member_id, hbx_policy_id, hbx_qhp_id, marketplace_segment_id)
        {
          hbx_member_id: hbx_member_id,
          hbx_policy_id: hbx_policy_id,
          hbx_qhp_id: hbx_qhp_id,
          marketplace_segment_id: marketplace_segment_id
        }
      end

      # Returns the current event type based on current and prior month flags.
      #   Type 1 records represent active coverage while Type 3 records are cancellations.
      #   No user fees are collected for cancelled coverage
      def user_fee_event_kind(current_month_kind = 0, prior_month_kind = 0)
        case [current_month_kind.to_i, prior_month_kind.to_i]
        when [1, 1]
          'active'
        when [3, 3]
          'term'
        when [1, 3]
          'reinstate'
        when [1, 0]
          'initial'
        when [3, 1]
          'current month term'
        when [0, 1]
          'current month drop term'
        when [3, 0]
          'current month new and term'
        end
      end

      # Returns the number of months between two dates
      def months_between_dates(start_date, end_date)
        (12 * (end_date.year - start_date.year) + end_date.month - start_date.month).abs + 1
      end

      # Returns a table of monthly begin/end date pairs covering period between two dates
      # @example Split a time period
      #   split_date_period_to_months(Date.new(2022,1,1), Date.new(2022,2,16)) #=> [[Sat, 01 Jan 2022, Mon, 31 Jan 2022], [Tue, 01 Feb 2022, Wed, 16 Feb 2022]]
      def split_date_period_to_months(begin_on, end_on)
        month_count = months_between_dates(begin_on, end_on)
        return [[begin_on, end_on]] if month_count == 1

        (0...month_count)
          .to_a
          .reduce([]) do |splits, offset|
            new_month_begin_on = Date.new(begin_on.year, begin_on.month, 1) >> offset
            new_month_end_on = Date.new(begin_on.year, begin_on.month, -1) >> offset

            splits << [[begin_on, new_month_begin_on].max, [end_on, new_month_end_on].min]
          end
      end

      # Returns number of days in a particular month and year
      # @example Return count of days in month
      #   days_in_month(2022, 2) #=> 29
      def days_in_month(year, month)
        Date.new(year, month, -1).day
      end

      def extract_date_from_segment(marketplace_segment_id)
        segment_date_part = marketplace_segment_id.split('-')[2]
        segment_year = segment_date_part[0..3].to_i
        segment_month = segment_date_part[4..5].to_i
        segment_day = segment_date_part[6..7].to_i
        Date.new(segment_year, segment_month, segment_day)
      end

      def currencyize(value = 0.0)
        BigDecimal(value.to_s).round(2).to_f
      end
    end
  end
end
