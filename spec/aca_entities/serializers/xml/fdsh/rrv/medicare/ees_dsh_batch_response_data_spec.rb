# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::EesDshBatchResponseData,
               "given a minimal medicare batch request" do

  let(:rrv_medicare_response) do
    AcaEntities::Fdsh::Rrv::Medicare::EesDshBatchResponseData.new(
      {
        IndividualResponses: [individual_response]
      }
    )
  end
  let(:individual_response) do
    {
      PersonSSNIdentification: "567856789",
      Insurances: [insurance],
      InsurancePolicy: {
        InsurancePolicyEffectiveDate: Date.new(2017, 1, 1),
        InsurancePolicyExpirationDate: Date.new(2017, 12, 31)
      }
    }
  end

  let(:insurance) do
    {
      InsuranceEffectiveDate: Date.new(2017, 1, 1),
      InsuranceEndDate: Date.new(2017, 12, 31)
    }
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::EesDshBatchResponseData.domain_to_mapper(
      rrv_medicare_response
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::Rrv::Medicare::Operations::ValidateMedicareResponsePayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
