# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for QualifyingLifeEventKind.
    class QualifyingLifeEventKindContract < ::Dry::Validation::Contract
      params do
        required(:start_on).filled(:date)
        optional(:end_on).maybe(:date)
        required(:title).filled(:string)
        optional(:tool_tip).maybe(:string)
        required(:pre_event_sep_in_days).filled(:integer)
        required(:is_self_attested).filled(:bool)
        required(:reason).filled(:string)
        required(:post_event_sep_in_days).filled(:integer)
        required(:market_kind).filled(:string)
        required(:effective_on_kinds).array(:string)
        optional(:ordinal_position).filled(:integer)
        optional(:_id).maybe(:string)
        optional(:coverage_start_on).maybe(:date)
        optional(:coverage_end_on).maybe(:date)
        required(:event_kind_label).filled(:string)
        required(:is_visible).filled(:bool)
        optional(:termination_on_kinds).maybe(:array)
        required(:date_options_available).filled(:bool)
        optional(:publish).maybe(:string)
        required(:qle_event_date_kind).maybe(:string)
        optional(:other_reason).maybe(:string)
        optional(:updated_by).maybe(:string)
        optional(:published_by).maybe(:string)
        optional(:created_by).maybe(:string)

        before(:value_coercer) do |result|
          result_hash = result.to_h
          other_params = {}
          other_params[:ordinal_position] = 0 if result_hash[:ordinal_position].nil?
          result_hash[:reason] = "" if result_hash[:reason] == 'Choose...'
          other_params[:reason] = result_hash[:other_reason].parameterize.underscore if result_hash[:reason] == 'other'
          other_params[:reason] = (other_params[:reason] ? other_params : result_hash)[:reason]
          other_params[:termination_on_kinds] = [] if result_hash[:market_kind].to_s == 'individual' || result_hash[:termination_on_kinds].nil?
          other_params[:published_by] = '' if result_hash[:publish] != 'Publish'
          other_params[:updated_by] = ''
          result_hash.merge(other_params)
        end
      end

      rule(:start_on) do
        if !values[:start_on].nil? && values[:start_on].is_a?(Date) && values[:start_on] < Date.today
          key.failure('Start on must be current or future date')
        end
      end

      rule(:end_on, :start_on) do
        unless values[:end_on].nil?
          key.failure('must be a date') unless values[:end_on].is_a?(Date)
          key.failure('End on must be after start on date') if values[:end_on].is_a?(Date) && values[:end_on] < values[:start_on]
        end
      end

      rule(:pre_event_sep_in_days) do
        key.failure('number of days should be more than 0') unless value >= 0
      end

      rule(:post_event_sep_in_days) do
        key.failure('number of days should be more than 0') unless value >= 0
      end

      rule(:market_kind) do
        key.failure("validators.qualifying_life_event_kind.market_kind") unless ['individual', 'shop'].include?(value)
      end

      rule(:effective_on_kinds) do
        key.failure('effective_on_kinds cannot be nil') if values[:effective_on_kinds].nil?
      end

      rule(:ordinal_position) do
        key.failure('position should be more than 1') unless value >= 0
      end

      rule(:coverage_start_on) do
        key.failure('Eligibility Start Date must be filled') if !values[:coverage_start_on].nil? && !values[:coverage_start_on].is_a?(Date)

        if values[:coverage_start_on].nil? && !values[:coverage_end_on].nil? && values[:coverage_end_on].is_a?(Date)
          key.failure("Eligibility Start Date must be filled")
        end
      end

      rule(:coverage_end_on) do
        key.failure('must be a date') if !values[:coverage_end_on].nil? && !values[:coverage_end_on].is_a?(Date)

        if !values[:coverage_start_on].nil? && values[:coverage_end_on].nil? && values[:coverage_start_on].is_a?(Date)
          key.failure("Eligibility End Date must be filled")
        end

        values_check = !values[:coverage_start_on].nil? && !values[:coverage_end_on].nil?
        dates_check = values[:coverage_start_on].is_a?(Date) && values[:coverage_end_on].is_a?(Date)

        if values_check && dates_check && (values[:coverage_end_on] <= values[:coverage_start_on])
          key.failure('Eligibility End Date must be after Eligibility Start Date')
        end
      end

      rule(:termination_on_kinds) do
        if !values[:termination_on_kinds].nil? && values[:termination_on_kinds].any? {|ele| !ele.is_a?(String)}
          key.failure("validators.qualifying_life_event_kind.termination_on_kind")
        end
      end
    end
  end
end
