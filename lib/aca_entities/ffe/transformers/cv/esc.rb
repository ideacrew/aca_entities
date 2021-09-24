# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # Transform employer sponsored coverage
        class Esc < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'lcsopPremium', 'employee_cost', memoize: true, visible: false
          map 'employeeSelfOnlyOfferAmount', 'employee_cost', memoize: true, visible: false
          map 'kind', 'kind', memoize: true, visible: true
          map 'status', 'status'
          map 'waitingPeriodIndicator', 'is_esi_waiting_period', memoize: true, visible: false
          add_key 'is_esi_waiting_period', function: lambda { |v|
                                                       v.resolve("is_esi_waiting_period")&.item || false if v.present?
                                                     }
          map 'employerOffersMinValuePlan', 'is_esi_mec_met', memoize: true, visible: false
          add_key 'is_esi_mec_met', function: lambda { |v|
                                                v.resolve("is_esi_mec_met").item == "YES" if v.present?
                                              }
          map 'hraType', 'hra_type', function: ->(v) {Ffe::Types::HraTypeMapping[v.to_sym]}
          add_key 'esi_covered', function: lambda { |v|
                                             kind = v.resolve("kind").item
                                             kind == 'employer_sponsored_insurance' ? 'self' : nil
                                           }                                         # default value
          map 'startDate', 'startDate', memoize: true, visible: false
          map 'endDate', 'endDate', memoize: true, visible: false
          add_key 'start_on', function: lambda { |v|
                                          v.resolve('startDate').item || Date.parse('2021-01-01')
                                        }                                      # default value
          add_key 'end_on', function: lambda { |v|
                                        v.resolve('endDate').item ? v.resolve('v').item : nil
                                      }                                    # default value
          map 'lcsopPremiumFrequencyType', 'employee_cost_frequency', memoize: true, visible: false
          map 'employeeSelfOnlyOfferFrequencyType', 'employee_cost_frequency', memoize: true, visible: false

          map 'employer.name', 'employer.employer_name'
          map 'employer.employerIdentificationNumber', 'employer.employer_id'

          map 'phone', 'phone', memoize: true, visible: false
          add_key 'employer.employer_phone.kind', value: 'work'
          add_key 'employer.employer_phone.country_code'
          add_key 'employer.employer_phone.area_code', function: ->(v) {v.resolve("phone").item.to_s[0..2]}
          add_key 'employer.employer_phone.number', function: ->(v) {v.resolve("phone").item.to_s[3..9]}
          add_key 'employer.employer_phone.extension'
          add_key 'employer.employer_phone.primary', value: true
          add_key 'employer.employer_phone.full_phone_number', function: ->(v) {v.resolve("phone").item.to_s}

          add_key 'employee_cost', function: ->(v) { v.resolve('employee_cost')&.item || "0.0"}
          add_key 'employee_cost_frequency', function: lambda { |v|
                                                         Ffe::Types::FREQUENCY_KINDS[v.resolve('employee_cost_frequency')&.item&.upcase || "MONTHLY"]
                                                       }
        end
      end
    end
  end
end