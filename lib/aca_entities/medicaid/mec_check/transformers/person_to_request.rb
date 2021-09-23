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
            rewrap 'non_esi_mec_request', type: :hash do
              namespace 'person' do
                rewrap 'non_esi_mec_individual_information', type: :hash do
                  namespace 'person_name' do
                    rewrap 'person_name', type: :hash do
                      map 'first_name', 'first_name'
                      map 'middle_name', 'middle_name'
                      map 'last_name', 'last_name'
                      map 'name_sfx', 'name_suffix'
                    end
                  end
                  map "person_demographics.ssn", "person_ssn", function: lambda { |v|
                    v.to_s
                  }
                  map 'person_demographics.dob', 'person_date_of_birth', memoize: true, function: lambda { |v|
                    if v.respond_to?(:strftime)
                      Date.strptime(v, "%Y-%m-%d")
                    else
                      Date.parse(v)
                    end
                  }
                  add_key 'organization_code', function: lambda { |v|
                    dob = Date.parse(v.resolve("person_date_of_birth").to_s)
                    now = Time.now.utc.to_date
                    age = now.year - dob.year - ((now.month > dob.month || (now.month == dob && now.day >= dob.day)) ? 0 : 1)
                    age > 18 ? "MEDC" : "CHIP"
                  }
                  map 'person_demographics.gender', 'person_sex_code', function: ->(v) { GenderCode[v] }
                  add_key 'requested_insurance_period', value: lambda { |_v|
                    rip = {}
                    rip[:start_date] = (Time.now - 604_800).to_date
                    rip[:end_date] = Date.today
                    rip
                  }
                end
              end
            end
          end

        end
      end
    end
  end
end
