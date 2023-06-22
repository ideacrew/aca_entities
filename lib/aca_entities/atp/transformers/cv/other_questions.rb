# frozen_string_literal: true

require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class OtherQuestions < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'foster_care_indicator', 'foster_care.is_former_foster_care'
          map 'age_left_foster_care', 'foster_care.age_left_foster_care'
          map 'foster_care_state', 'foster_care.foster_care_us_state'
          map 'had_medicaid_during_foster_care_indicator', 'foster_care.had_medicaid_during_foster_care'

          map 'student_indicator', 'student.is_student'
          add_key 'student.student_kind', value: nil # default
          add_key 'student.student_school_kind', value: nil # default
          add_key 'student.student_status_end_on', value: nil # default

          map 'pergnancy.status_indicator', 'pregnancy_information.is_pregnant', function: ->(v) { v || false}
          map 'pergnancy.expected_baby_quantity', 'pregnancy_information.expected_children_count'
          add_key 'pregnancy_information.is_enrolled_on_medicaid', value: nil # default
          add_key 'pregnancy_information.is_post_partum_period', value: nil # default
          add_key 'pregnancy_information.pregnancy_due_on', value: nil # default
          map 'pergnancy.status_valid_date_range.end_date.date', 'pregnancy_information.pregnancy_end_on', function: lambda { |v|
            Date.parse(v) >= Date.today ? Date.parse(v) : nil
          }

          map 'incarcerations.incarceration_indicator', 'attestation.is_incarcerated'
          map 'blindness_or_disability_indicator', 'attestation.is_self_attested_disabled', memoize: true, visible: true, function: lambda { |v|
                                                                                                                                      v || false
                                                                                                                                    }
          add_key 'attestation.is_self_attested_blind', function: lambda { |v|
            v ? v.resolve('attestation.is_self_attested_disabled').item : false
          }
          map 'long_term_care_indicator', 'attestation.is_self_attested_long_term_care', function: ->(v) { v || false}
        end
      end
    end
  end
end
