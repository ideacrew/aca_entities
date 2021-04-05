# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for PregnancyInformation.
      class PregnancyInformationContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          required(:is_applying_coverage).filled(:bool)
          required(:is_pregnant).filled(:bool)
          optional(:is_enrolled_on_medicaid).maybe(:bool)
          optional(:is_post_partum_period).maybe(:bool)
          optional(:expected_children_count).maybe(:integer)
          optional(:pregnancy_due_on).maybe(:date)
          optional(:pregnancy_end_on).maybe(:date)
        end

        rule(:is_post_partum_period) do
          key.failure(text: 'must be filled if the applicant is not pregnant.') if check_if_blank?(value) && values[:is_pregnant] == false
        end

        rule(:pregnancy_end_on) do
          if check_if_blank?(value) && values[:is_pregnant] == false && values[:is_post_partum_period]
            key.failure(text: 'must be filled if the applicant is not pregnant and is in post partum period.')
          end
        end

        rule(:is_enrolled_on_medicaid) do
          if check_if_blank?(value) && values[:is_applying_coverage] && values[:is_pregnant] == false && values[:is_post_partum_period]
            key.failure(text: 'must be filled if the applicant is not applying for coverage, not pregnant and is in post partum period.')
          end
        end

        rule(:expected_children_count) do
          key.failure(text: 'must be filled if the applicant is pregnant.') if check_if_blank?(value) && values[:is_pregnant]
        end

        rule(:pregnancy_due_on) do
          key.failure(text: 'must be filled if the applicant is pregnant.') if check_if_blank?(value) && values[:is_pregnant]
        end
      end
    end
  end
end