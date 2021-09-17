# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            # Happymapper implementation for the root object of an response.
            class EesDshBatchResponseData
              include HappyMapper

              tag 'EESDSHBatchResponseData'

              has_one :IndividualResponses, IndividualResponses

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IndividualResponses = IndividualResponses.domain_to_mapper(request)
                mapper
              end
            end
          end
        end
      end
    end
  end
end
