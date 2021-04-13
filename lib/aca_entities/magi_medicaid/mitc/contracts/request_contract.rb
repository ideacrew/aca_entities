# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Configuration values and shared rules and macros for {AcaEntities::MagiMedicaid} validation contracts
        class RequestContract < Dry::Validation::Contract
          include AcaEntities::AppHelper

          rule(:people).each do |index:|
            if key? && value

              if check_if_present?(value[:person_id]) && !Types::PersonIdRange.include?(value[:person_id])
                key([:people, index, :person_id]).failure('must be between 1 and 100')
              end

              if value[:had_prior_insurance] == 'Y' && check_if_blank?(value[:prior_insurance_end_date])
                key([:people, index, :prior_insurance_end_date]).failure('cannot be blank when had_prior_insurance is Y')
              end

              if value[:is_pregnant] == 'Y'
                if check_if_blank?(value[:children_expected_count])
                  key([:people, index, :children_expected_count]).failure('cannot be blank when is_pregnant is Y')
                end

                if check_if_blank?(value[:is_in_post_partum_period])
                  key([:people, index, :is_in_post_partum_period]).failure('cannot be blank when is_pregnant is Y')
                end
              end

              if value[:is_in_former_foster_care] == 'Y'
                if check_if_blank?(value[:had_medicaid_during_foster_care])
                  key([:people, index, :had_medicaid_during_foster_care]).failure('cannot be blank when is_in_former_foster_care is Y')
                end

                if check_if_blank?(value[:age_left_foster_care])
                  key([:people, index, :age_left_foster_care]).failure('cannot be blank when is_in_former_foster_care is Y')
                end

                if check_if_blank?(value[:foster_care_us_state])
                  key([:people, index, :foster_care_us_state]).failure('cannot be blank when is_in_former_foster_care is Y')
                end
              end

              if value[:is_lawful_presence_self_attested] == 'Y'
                if check_if_blank?(value[:immigration_status])
                  key([:people, index, :immigration_status]).failure('cannot be blank when is_lawful_presence_self_attested is Y')
                end

                if check_if_blank?(value[:is_amerasian])
                  key([:people, index, :is_amerasian]).failure('cannot be blank when is_lawful_presence_self_attested is Y')
                end

                if check_if_blank?(value[:has_forty_title_ii_work_quarters])
                  key([:people, index, :has_forty_title_ii_work_quarters]).failure('cannot be blank when is_lawful_presence_self_attested is Y')
                end

                if check_if_blank?(value[:five_year_bar_applies])
                  key([:people, index, :five_year_bar_applies]).failure('cannot be blank when is_lawful_presence_self_attested is Y')
                end

                if value[:five_year_bar_applies] == 'Y' && check_if_blank?(value[:is_five_year_bar_met])
                  key([:people, index, :is_five_year_bar_met]).failure('cannot be blank when both is_lawful_presence_self_attested and five_year_bar_applies are Y')
                end
              end

              if value[:is_eligible_for_refugee_medical_assistance] == 'Y'
                if check_if_blank?(value[:refugee_medical_assistance_start_date])
                  key([:people, index, :refugee_medical_assistance_start_date]).failure('cannot be blank when is_eligible_for_refugee_medical_assistance is Y')
                end

                if check_if_blank?(value[:seven_year_limit_start_date])
                  key([:people, index, :seven_year_limit_start_date]).failure('cannot be blank when is_eligible_for_refugee_medical_assistance is Y')
                end
              end
              
            end # key? && value
          end # people rule
        end
      end
    end
  end
end