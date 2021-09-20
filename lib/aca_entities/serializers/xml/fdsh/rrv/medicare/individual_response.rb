# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class IndividualResponse
              include HappyMapper

              tag 'IndividualResponse'

              element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification'
              has_many :Insurances, Insurance
              element :OrganizationResponseCode, String, tag: 'OrganizationResponseCode'
              element :OrganizationResponseCodeText, String, tag: 'OrganizationResponseCodeText'

              def self.domain_to_mapper(individual_response)
                mapper = self.new
                mapper.PersonSSNIdentification = individual_response.PersonSSNIdentification
                mapper.Insurances = individual_response.Insurances.collect do |response|
                  Insurance.domain_to_mapper(response)
                end
                mapper.OrganizationResponseCode = individual_response.OrganizationResponseCode
                mapper.OrganizationResponseCodeText = individual_response.OrganizationResponseCodeText

                mapper
              end
            end
          end
        end
      end
    end
  end
end
