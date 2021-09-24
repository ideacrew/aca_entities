# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Transformers
        # Transformers implementation for mec check people payloads
        class PersonToRequest < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          GenderCode = { "male" => "M",
                         "female" => "F",
                         nil => "U" }.freeze

          namespace 'person' do
            rewrap 'verify_non_esi_mec_request', type: :hash do
              add_namespace 'non_esi_mec_request', 'verify_non_esi_mec_request.non_esi_mec_request', type: :hash do
                add_namespace 'non_esi_mec_individual_information', 'verify_non_esi_mec_request.verify_non_esi_mec_request.non_esi_mec_individual_information', type: :hash do # rubocop:disable Layout/LineLength
                  map 'ssn', 'person_ssn'
                  map 'dob', 'person_date_of_birth', memoize: true, function: lambda { |v|
                    if v.respond_to?(:strftime)
                      Date.strptime(v, "%Y-%m-%d")
                    else
                      Date.parse(v)
                    end
                  }
                  map 'gender', 'person_sex_code', function: ->(v) { GenderCode[v] }
                  add_key 'organization_code', function: lambda { |v|
                    v.resolve("person_date_of_birth").to_date + 18.years < Date.today ? "MEDC" : "CHIP"
                  }
                  add_key 'requested_insurance_period', value: lambda { |_v|
                    rip = Hash.new
                    rip['start_date'] = 7.days.ago
                    rip['end_date'] = Date.today
                    rip
                  }
                  add_namespace 'person_name', 'verify_non_esi_mec_request.verify_non_esi_mec_request.non_esi_mec_individual_information.person_name', type: :hash do # rubocop:disable Layout/LineLength
                    map 'first_name', 'first_name'
                    map 'middle_name', 'middle_name'
                    map 'last_name', 'last_name'
                    map 'name_sfx', 'name_suffix'
                  end
                end
              end
            end
          end

        end
      end
    end
  end
end
