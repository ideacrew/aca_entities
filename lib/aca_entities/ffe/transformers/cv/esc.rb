# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # Transform employer sponsored coverage
        class Esc < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'lcsopPremium', 'employee_cost', function: ->(v) { v || "0.0"} # default value
          map 'kind', 'kind'
          map 'status', 'status'
          map 'waitingPeriodIndicator', 'is_esi_waiting_period'
          map 'employerOffersMinValuePlan', 'is_esi_mec_met'
          add_key 'esi_covered', value: 'self' # default value
          add_key 'start_on', value: ->(_v) {Date.parse('2021-01-01')} # default value
          add_key 'end_on', value: ->(_v) {} # default value
          map 'lcsopPremiumFrequencyType', 'employee_cost_frequency', function: ->(v) {v.capitalize}

          map 'employer.name', 'employer.employer_name'
          add_key 'employer.employer_id', value: '123456789' # default value

          add_key 'employer_address.address_1', value: '21313312' # default value
          add_key 'employer_address.address_2', value: '' # default value
          add_key 'employer_address.address_3', value: '' # default value
          add_key 'employer_address.county', value: '' # default value
          add_key 'employer_address.country_name', value: '' # default value
          add_key 'employer_address.kind', value: 'work' # default value
          add_key 'employer_address.city', value: 'test' # default value
          add_key 'employer_address.state', value: 'ME' # default value
          add_key 'employer_address.zip', value: '04001' # default value

          map 'phone', 'phone', memoize: true, visible: false
          add_key 'employer_phone.kind'
          add_key 'employer_phone.country_code'
          add_key 'employer_phone.area_code', function: ->(v) {v.resolve("phone").item.to_s[0..2]}
          add_key 'employer_phone.number', function: ->(v) {v.resolve("phone").item.to_s[3..9]}
          add_key 'employer_phone.extension'
          add_key 'employer_phone.full_phone_number', function: ->(v) {v.resolve("phone").item.to_s}

        end
      end
    end
  end
end