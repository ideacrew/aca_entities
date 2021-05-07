# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module MagiMedicaid
    module Mitc
      module Transformers
        module ToMitc
          # This transformer is used for Transform the keys of the MitcEligibilityResponsePayload to match with MitcEligibilityReponse
          # This class is PRIVATE and cannot be called from outside except from operation:
          # MitcService::AddMitcDeterminationToApplication
          class EligibilityReponse < ::AcaEntities::Operations::Transforms::Transform
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

                      map 'MAGI', 'magi_income'
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


                end
              end
            end
          end
        end
      end
    end
  end
end
