# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # PersonName class
                #
                # @!attribute [rw] PersonGivenName
                #   @return [String] the person's given name
                # @!attribute [rw] PersonMiddleName
                #   @return [String] the person's middle name
                # @!attribute [rw] PersonSurName
                #   @return [String] the person's surname
                # @!attribute [rw] PersonNameSuffixText
                #   @return [String] the person's name suffix
                class PersonName
                  include HappyMapper

                  # XML tag for PersonName
                  tag 'PersonName'
                  namespace 'nc'

                  # XML mapping rule for person_given_name
                  # @return [String]
                  element :person_given_name, String, tag: 'PersonGivenName'

                  # XML mapping rule for person_middle_name
                  # @return [String]
                  element :person_middle_name, String, tag: 'PersonMiddleName'

                  # XML mapping rule for person_sur_name
                  # @return [String]
                  element :person_sur_name, String, tag: 'PersonSurName'

                  # XML mapping rule for person_name_suffix_text
                  # @return [String]
                  element :person_name_suffix_text, String, tag: 'PersonNameSuffixText'

                  # This method maps domain objects to mapper objects
                  #
                  # @param person [Object] the domain object
                  # @return [PersonName] the mapper object
                  def self.domain_to_mapper(person)
                    mapper = self.new
                    mapper.PersonGivenName = person.PersonGivenName
                    mapper.PersonMiddleName = person.PersonMiddleName
                    mapper.PersonSurName = person.PersonSurName
                    mapper.PersonNameSuffixText = person.PersonNameSuffixText
                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      PersonGivenName: person_given_name,
                      PersonMiddleName: person_middle_name,
                      PersonSurName: person_sur_name,
                      PersonNameSuffixText: person_name_suffix_text
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
end