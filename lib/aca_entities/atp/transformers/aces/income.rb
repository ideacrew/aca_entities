# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Income < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'employment_source_text'
          map 'amount', 'amount'
          add_key 'days_per_week'
          add_key 'hours_per_pay_period'
          map 'hours_per_week', 'hours_per_week'
          map 'kind', 'category_code'
          add_key 'description_text'
          add_key 'subject_to_federal_restrictions_indicator'
          add_key 'date'
          map 'end_on', 'earned_date_range.end_date.date'
          add_key 'earned_date_range.end_date.date_time'
          add_key 'earned_date_range.end_date.year'
          add_key 'earned_date_range.end_date.year_month'
          map 'start_on', 'earned_date_range.start_date.date'
          add_key 'earned_date_range.start_date.date_time'
          add_key 'earned_date_range.start_date.year'
          add_key 'earned_date_range.start_date.year_month'

          map 'frequency_kind', 'frequency.frequency_code'
          add_key 'payment_frequency'
          map 'employer_id', 'source_organization_reference.ref'
        end
      end
    end
  end
end