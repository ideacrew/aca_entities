# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class EesDshBatchRequestData
              include HappyMapper

              tag 'EESDSHBatchRequestData'

              has_one :IndividualRequests, IndividualRequests

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.IndividualRequests = IndividualRequests.domain_to_mapper(request)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
