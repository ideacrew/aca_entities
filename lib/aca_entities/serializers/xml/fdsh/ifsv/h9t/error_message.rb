# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class ErrorMessage
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'

              tag 'ErrorMessage'
              namespace 'ext'

              has_one :ErrorMessageDetail, ErrorMessageDetail

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ErrorMessageDetail = ErrorMessageDetail.domain_to_mapper(response.ErrorMessageDetail)

                mapper
              end
            end
          end
        end
      end
    end
  end
end