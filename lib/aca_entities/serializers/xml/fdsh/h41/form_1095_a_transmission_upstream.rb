# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class Form1095ATransmissionUpstream
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'
            register_namespace 'irs', 'urn:us:gov:treasury:irs:common'
            register_namespace 'batchreq', 'urn:us:gov:treasury:irs:msg:form1095atransmissionupstreammessage'
            register_namespace 'xsi', 'http://www.w3.org/2001/XMLSchema-instance'

            tag 'Form1095ATransmissionUpstream'
            namespace 'batchreq'

            has_many :Form1095AUpstreamDetails, Form1095AUpstreamDetail

            def self.domain_to_mapper(request)
              mapper = self.new

              mapper.Form1095AUpstreamDetails = request.Form1095AUpstreamDetail.collect do |details|
                Form1095AUpstreamDetail.domain_to_mapper(details)
              end

              mapper
            end
          end
        end
      end
    end
  end
end
