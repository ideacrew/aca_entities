# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # Transform person Medicaid
        class Medicaid < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          # ["medicaidDeniedDate",
          #  "medicaidDeniedIndicator",
          #  "enrolledInHealthCoverageIndicator",
          #  "insuranceCoverage",
          #  "informationChangeSinceMedicaidEndedIndicator",
          #  "medicaidEndIndicator",
          #  "coveredDependentChildIndicator",
          #  "medicaidDeniedDueToImmigrationIndicator",
          #  "unpaidBillIndicator",
          #  "medicaidEndDate",
          #  "immigrationStatusFiveYearIndicator",
          #  "immigrationStatusChangeSinceDeniedIndicator"]

          map 'medicaidDeniedIndicator', 'medicaidDeniedIndicator', memoize: true, visible: false
          add_key 'medicaid_and_chip.not_eligible_in_last_90_days', function: lambda { |v|
                                                                                if v.nil? || v.resolve('medicaidDeniedIndicator').item.nil?
                                                                                  return false
                                                                                end
                                                                                v.resolve('medicaidDeniedIndicator').item
                                                                              }
          map 'medicaidDeniedDate', 'medicaid_and_chip.denied_on'
          map 'informationChangeSinceMedicaidEndedIndicator', 'informationChangeSinceMedicaidEndedIndicator', memoize: true, visible: false
          map 'medicaidEndIndicator', 'medicaidEndIndicator', memoize: true, visible: false
          map 'medicaidEndDate', 'medicaid_and_chip.medicaid_or_chip_coverage_end_date', memoize: true, visible: true
          map 'informationChangeSinceMedicaidEndedIndicator', 'medicaid_and_chip.hh_income_or_size_changed'

          add_key 'medicaid_and_chip.ended_as_change_in_eligibility', function: lambda { |v|
                                                                                  return false if v.nil?
                                                                                  ((v.resolve('informationChangeSinceMedicaidEndedIndicator').item &&
                                                                                    v.resolve('medicaidEndIndicator').item) || false)

                                                                                }

          map 'medicaidDeniedDueToImmigrationIndicator', 'medicaidDeniedDueToImmigrationIndicator', memoize: true, visible: false
          map 'immigrationStatusFiveYearIndicator', 'immigrationStatusFiveYearIndicator', memoize: true, visible: false
          add_key 'medicaid_and_chip.ineligible_due_to_immigration_in_last_5_years', function: lambda { |v|
            return false if v.nil?
            return false unless v.resolve("medicaidDeniedDueToImmigrationIndicator").item
            v.resolve("medicaidDeniedDueToImmigrationIndicator").item
          }
          map 'immigrationStatusChangeSinceDeniedIndicator', 'medicaid_and_chip.immigration_status_changed_since_ineligibility'

        end
      end
    end
  end
end