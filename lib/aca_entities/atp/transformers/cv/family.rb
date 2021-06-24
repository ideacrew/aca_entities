# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'people' do
            rewrap 'family_members' do
              namespace 'person_name' do
                rewrap '', { type: :array } do
                  map 'given', 'person.person_name.first_name'
                  map 'middle', 'person.person_name.middle_name'
                  map 'sur', 'person.person_name.last_name'
                  map 'full', 'person.person_name.full_name'
                end
              end

              map 'us_citizen_indicator', 'person.consumer_role.lawful_presence_determination.citizen_status'
              map 'living_indicator', 'person_demographics.is_homeless' # code to update
              map 'ssn', 'person_demographics.ssn'
              map 'sex', 'person_demographics.gender'
              add_key 'no_ssn'
              add_key 'date_of_death'
              add_key 'dob_check'
              add_key 'is_incarcerated'
              add_key 'tribal_id'
              add_key 'language_code'

              map 'race', 'person.race'
              map 'ethnicity', 'person.ethnicity'
            end
          end
        end
      end
    end
  end
end
