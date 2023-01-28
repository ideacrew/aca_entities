# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class OtherCompletePersonName
            include HappyMapper
            register_namespace 'airty20a', "urn:us:gov:treasury:irs:ext:aca:air:ty20a"

            tag 'OtherCompletePersonName'
            namespace 'airty20a'

            element :PersonFirstNm, String, tag: 'PersonFirstNm'
            element :PersonMiddleNm, String, tag: 'PersonMiddleNm'
            element :PersonLastNm, String, tag: 'PersonLastNm'
            element :SuffixNm, String, tag: 'SuffixNm'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.PersonFirstNm = request.PersonFirstNm
              mapper.PersonMiddleNm = request.PersonMiddleNm if request.PersonMiddleNm
              mapper.PersonLastNm = request.PersonLastNm
              mapper.SuffixNm = request.SuffixNm if request.SuffixNm

              mapper
            end
          end
        end
      end
    end
  end
end
