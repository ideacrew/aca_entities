# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::EesDshBatchRequestData,
               "given a minimal medicare batch request" do

  let(:rrv_medicare_request) do
    AcaEntities::Fdsh::Rrv::Medicare::EesDshBatchRequestData.new(
      {
        IndividualRequests: [individual_request]
      }
    )
  end
  let(:individual_request) do
    {
      Applicant: {
        PersonSSNIdentification: "567856789",
        PersonName: {
          PersonGivenName: "AGivenName",
          PersonMiddleName: "middlename",
          PersonSurName: "A Sur Name"
        },
        PersonBirthDate: Date.new(2017, 1, 1)
      },
      InsurancePolicy: {
        InsurancePolicyEffectiveDate: Date.new(2017, 1, 1),
        InsurancePolicyExpirationDate: Date.new(2017, 12, 31)
      }
    }
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::EesDshBatchRequestData.domain_to_mapper(
      rrv_medicare_request
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::Operations::ValidateMedicareRequestPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
