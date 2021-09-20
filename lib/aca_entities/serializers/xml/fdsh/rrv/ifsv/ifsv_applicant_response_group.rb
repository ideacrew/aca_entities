# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Response.
            class IfsvApplicantResponseGroup
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVApplicantResponseGrp'

              element :RequestId, String, tag: 'RequestId', namespace: 'irs'
              element :AggregateHouseholdIncomeAmt, Float, tag: 'AggregateHouseholdIncomeAmt', namespace: 'irs'
              has_many :IFSVApplicantVerifications, IfsvApplicantVerification
              has_many :IFSVDependentVerifications, IfsvDependentVerification
              has_many :ErrorMessageDetails, ErrorMessageDetail

              def self.domain_to_mapper(response_group)
                mapper = self.new
                mapper.RequestId = response_group.RequestId
                mapper.AggregateHouseholdIncomeAmt = response_group.AggregateHouseholdIncomeAmt

                mapper.IFSVApplicantVerifications = response_group.IFSVApplicantVerifications.collect do |applicant|
                  IfsvApplicantVerification.domain_to_mapper(applicant)
                end

                mapper.IFSVDependentVerifications = response_group.IFSVDependentVerifications.collect do |applicant|
                  IfsvApplicantVerification.domain_to_mapper(applicant)
                end

                mapper.ErrorMessageDetails = response_group.ErrorMessageDetails.collect do |error_message|
                  ErrorMessageDetail.domain_to_mapper(error_message)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end
