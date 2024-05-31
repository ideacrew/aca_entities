# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
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

              # XML mapping rule for PersonGivenName
              # @return [String]
              element :PersonGivenName, String, tag: 'PersonGivenName'

              # XML mapping rule for PersonMiddleName
              # @return [String]
              element :PersonMiddleName, String, tag: 'PersonMiddleName'

              # XML mapping rule for PersonSurName
              # @return [String]
              element :PersonSurName, String, tag: 'PersonSurName'

              # XML mapping rule for PersonNameSuffixText
              # @return [String]
              element :PersonNameSuffixText, String, tag: 'PersonNameSuffixText'

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
            end
          end
        end
      end
    end
  end
end