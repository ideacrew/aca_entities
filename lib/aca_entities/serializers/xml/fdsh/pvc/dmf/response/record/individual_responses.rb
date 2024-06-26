# frozen_string_literal: true

# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/Response/individual_response'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # IndividualResponses class
                #
                # @!attribute [rw] IndividualResponses
                #   @return [Array<IndividualResponse>] an array of IndividualResponse objects
                class IndividualResponses
                  include HappyMapper

                  register_namespace 'exch', 'http://pvcdmfresp.ee.sim.dsh.cms.hhs.gov/exchange/1.0"'

                  # XML tag for IndividualResponses
                  tag 'Response'
                  namespace 'exch'

                  # XML mapping rule for IndividualResponses
                  # @return [Array<IndividualResponse>]
                  has_many :individual_responses, IndividualResponse

                  # This method maps domain objects to mapper objects
                  #
                  # @param Response [Object] the domain object
                  # @return [IndividualResponses] the mapper object
                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.IndividualResponses = response.IndividualResponses.collect do |individual_response|
                      IndividualResponse.domain_to_mapper(individual_response)
                    end

                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      IndividualResponses: individual_responses.map(&:to_hash)
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
