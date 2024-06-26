# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # PersonBirthDate class
                #
                # @!attribute [rw] date
                #   @return [String] the person's birth date
                class PersonBirthDate
                  include HappyMapper

                  # XML tag for PersonBirthDate
                  tag 'PersonBirthDate'
                  namespace 'nc'

                  # XML mapping rule for date
                  # @return [String]
                  element :date, String, tag: "Date"

                  # This method maps domain objects to mapper objects
                  #
                  # @param person_birth_date [Date] the domain object
                  # @return [PersonBirthDate] the mapper object
                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.Date = response.date.strftime
                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      Date: date
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