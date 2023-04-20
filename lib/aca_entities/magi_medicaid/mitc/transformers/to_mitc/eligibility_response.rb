# frozen_string_literal: true

require 'bigdecimal'

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Mitc
      module Transformers
        module ToMitc
          # rubocop:disable Style/Lambda
          # This transformer is used for Transform the keys of the MitcEligibilityResponsePayload to match with MitcEligibilityReponse
          # This class is PRIVATE and cannot be called from outside except from operation:
          # MitcService::AddMitcDeterminationToApplication
          class EligibilityResponse < ::AcaEntities::Operations::Transforms::Transform
            include ::AcaEntities::Operations::Transforms::Transformer

            map 'Determination Date', 'determination_date'

            namespace 'Applicants' do
              rewrap 'applicants', type: :array do
                rewrap '', type: :hash do
                  map 'Person ID', 'person_id'

                  namespace 'Medicaid Household' do
                    rewrap 'medicaid_household', type: :hash do

                      map 'People', 'People', memoize: true, visible: false
                      add_key 'people', function: ->(v) { v.resolve('People').item }

                      map 'MAGI', 'magi_income', function: ->(value) { BigDecimal(((value || 0) / 12).to_s) }
                      map 'MAGI as Percentage of FPL', 'magi_as_percentage_of_fpl'
                      map 'Size', 'size'
                    end
                  end

                  map 'Medicaid Eligible', 'is_medicaid_eligible'
                  map 'CHIP Eligible', 'is_chip_eligible'

                  map 'Ineligibility Reason', 'Ineligibility Reason', memoize: true, visible: false
                  add_key 'medicaid_ineligibility_reasons', function: ->(v) { v.resolve('Ineligibility Reason').item }

                  map 'Non-MAGI Referral', 'is_eligible_for_non_magi_reasons'

                  map 'CHIP Ineligibility Reason', 'CHIP Ineligibility Reason', memoize: true, visible: false
                  add_key 'chip_ineligibility_reasons', function: ->(v) { v.resolve('CHIP Ineligibility Reason').item }

                  map 'Category', 'medicaid_category'
                  map 'Category Threshold', 'medicaid_category_threshold'
                  map 'CHIP Category', 'chip_category'
                  map 'CHIP Category Threshold', 'chip_category_threshold'

                  map 'Determinations', 'Determinations', memoize_record: true
                  add_key 'determinations', function: ->(v) {
                    # TODO: Fix the key name issue. Name should be 'Determinations' and not 'Applicants.no_key.Determinations'
                    input_determinations = v.resolve('Applicants.no_key.Determinations').item
                    category_determinations = []
                    input_determinations.each do |key, value|
                      category_determinations << {
                        category: key,
                        indicator_code: value[:Indicator],
                        ineligibility_code: value[:'Ineligibility Code'],
                        ineligibility_reason: value[:'Ineligibility Reason']
                      }
                    end
                    category_determinations
                  }

                  # TODO: Enhance below once we have response payload with valid Other Outputs
                  namespace 'Other Outputs' do
                    rewrap 'other_output', type: :hash do
                      namespace 'Qualified Children List' do
                        rewrap 'qualified_children_list', type: :array do
                          # rubocop:disable Lint/EmptyBlock
                          rewrap '', type: :hash do
                          end
                          # rubocop:enable Lint/EmptyBlock
                        end
                      end
                    end
                  end

                end
              end
            end
          end
          # rubocop:enable Style/Lambda
        end
      end
    end
  end
end
