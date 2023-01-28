# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class Form1095AUpstreamDetail
            include HappyMapper
            register_namespace 'airty20a', "urn:us:gov:treasury:irs:ext:aca:air:ty20a"

            namespace 'airty20a'
            tag 'Form1095AUpstreamDetail'
            attribute 'recordType', String
            attribute 'lineNum', String

            element :RecordSequenceNum, String, tag: 'RecordSequenceNum'
            element :TaxYr, String, tag: 'TaxYr'
            element :CorrectedInd, String, tag: 'CorrectedInd'
            element :CorrectedRecordSequenceNum, String, tag: 'CorrectedRecordSequenceNum'
            element :VoidInd, String, tag: 'VoidInd'
            element :VoidedRecordSequenceNum, String, tag: 'VoidedRecordSequenceNum'
            element :MarketplaceId, String, tag: 'MarketplaceId'
            has_one :Policy, Policy
            has_one :Recipient, Recipient
            has_one :RecipientSpouse, RecipientSpouse
            has_one :CoverageHouseholdGroup, CoverageHouseholdGroup
            has_one :RecipientPolicyInformation, RecipientPolicyInformation

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.recordType = ""
              mapper.lineNum = "0"
              mapper.RecordSequenceNum = request.RecordSequenceNum
              mapper.TaxYr = request.TaxYr
              mapper.CorrectedInd = request.CorrectedInd
              mapper.CorrectedRecordSequenceNum = request.CorrectedRecordSequenceNum if request.CorrectedRecordSequenceNum
              mapper.VoidInd = request.VoidInd
              mapper.VoidedRecordSequenceNum = request.VoidedRecordSequenceNum if request.VoidedRecordSequenceNum
              mapper.MarketplaceId = request.MarketplaceId
              mapper.Policy = Policy.domain_to_mapper(request.Policy) if request.Policy
              mapper.Recipient = Recipient.domain_to_mapper(request.Recipient) if request.Recipient
              mapper.RecipientSpouse = RecipientSpouse.domain_to_mapper(request.RecipientSpouse) if request.RecipientSpouse
              mapper.CoverageHouseholdGroup = CoverageHouseholdGroup.domain_to_mapper(request.CoverageHouseholdGrp) if request.CoverageHouseholdGrp
              if request.RecipientPolicyInformation
                mapper.RecipientPolicyInformation = RecipientPolicyInformation
                                                      .domain_to_mapper(request.RecipientPolicyInformation)
              end

              mapper
            end
          end
        end
      end
    end
  end
end
