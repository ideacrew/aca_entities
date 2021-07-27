# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class InitialVerificationRequestSet
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationRequestSet'
              namespace 'vlp'

              has_one :DHSID, DhsId
              element :FirstName, String, tag: 'FirstName', namespace: "vlp"
              element :MiddleName, String, tag: 'MiddleName', namespace: "vlp"
              element :LastName, String, tag: 'LastName', namespace: "vlp"
              element :DateOfBirth, Date, tag: 'DateOfBirth', namespace: "vlp"
              element :AKA, String, tag: 'AKA', namespace: "vlp"
              element :FiveYearBarApplicabilityIndicator, Boolean, tag: 'FiveYearBarApplicabilityIndicator', namespace: "vlp"
              element :RequestSponsorDataIndicator, Boolean, tag: 'RequestSponsorDataIndicator', namespace: "vlp"
              element :RequestGrantDateIndicator, Boolean, tag: 'RequestGrantDateIndicator', namespace: "vlp"
              element :RequesterCommentsForHub, String, tag: 'RequesterCommentsForHub', namespace: "vlp"
              element :SuspectedCounterfeitAlteredDocumentIndicator, Boolean, tag: 'SuspectedCounterfeitAlteredDocumentIndicator', namespace: "vlp"
              element :RequestCubanHaitianEntrantIndicator, Boolean, tag: 'RequestCubanHaitianEntrantIndicator', namespace: "vlp"
              element :DocumentBinaryAttachment, String, tag: 'DocumentBinaryAttachment', namespace: "vlp"
              element :CasePOCFullName, String, tag: 'CasePOCFullName', namespace: "vlp"
              element :CasePOCPhoneNumber, String, tag: 'CasePOCPhoneNumber', namespace: "vlp"
              element :CasePOCPhoneNumberExtension, String, tag: 'CasePOCPhoneNumberExtension', namespace: "vlp"

              def self.domain_to_mapper(initial_request_set)
                mapper = self.new

                mapper.DHSID = DhsId.domain_to_mapper(initial_request_set.DHSID)
                mapper.FirstName = initial_request_set.FirstName
                mapper.MiddleName = initial_request_set.MiddleName
                mapper.LastName = initial_request_set.LastName
                mapper.DateOfBirth = initial_request_set.DateOfBirth.strftime
                mapper.AKA = initial_request_set.AKA
                mapper.FiveYearBarApplicabilityIndicator = initial_request_set.FiveYearBarApplicabilityIndicator
                mapper.RequestSponsorDataIndicator = initial_request_set.RequestSponsorDataIndicator
                mapper.RequestGrantDateIndicator = initial_request_set.RequestGrantDateIndicator
                mapper.RequesterCommentsForHub = initial_request_set.RequesterCommentsForHub
                mapper.SuspectedCounterfeitAlteredDocumentIndicator = initial_request_set.SuspectedCounterfeitAlteredDocumentIndicator
                mapper.RequestCubanHaitianEntrantIndicator = initial_request_set.RequestCubanHaitianEntrantIndicator
                mapper.DocumentBinaryAttachment = initial_request_set.DocumentBinaryAttachment
                mapper.CasePOCFullName = initial_request_set.CasePOCFullName
                mapper.CasePOCPhoneNumber = initial_request_set.CasePOCPhoneNumber
                mapper.CasePOCPhoneNumberExtension = initial_request_set.CasePOCPhoneNumberExtension

                mapper
              end
            end
          end
        end
      end
    end
  end
end

