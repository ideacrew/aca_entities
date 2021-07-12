# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonIncome.
      class PersonIncomeContract < Dry::Validation::Contract

        params do

          optional(:employment_source_text).maybe(:string)
          optional(:amount).maybe(:float)
          optional(:days_per_week).maybe(:float)
          optional(:hours_per_pay_period).maybe(:float)
          optional(:hours_per_week).maybe(:float)
          optional(:category_code).maybe(:string)
          optional(:description_text).maybe(:string)
          optional(:subject_to_federal_restrictions_indicator).maybe(:bool)
          optional(:date).maybe(:hash)
          optional(:earned_date_range).maybe(:hash)
          optional(:frequency).maybe(:hash)
          optional(:payment_frequency).maybe(:hash)
          optional(:source_organization_reference).maybe(:hash)
        end
      end
    end
  end
end
