# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ssa::H3::SSACompositeRequest,
               "given a minimal Primary Response object" do

  let(:ssa_verification_request) do
    AcaEntities::Fdsh::Ssa::H3::SSACompositeRequest.new(
      {
        SSACompositeIndividualRequests: [ssa_composite_individual_request]
      }
    )
  end
  let(:ssa_composite_individual_request) do
    {
      Person: {
        PersonSSNIdentification: "567856789",
        PersonName: {
          PersonGivenName: "AGivenName",
          PersonMiddleName: "middlename",
          PersonSurName: "A Sur Name"
        },
        PersonBirthDate: {
          Date: Date.new(2017, 1, 1)
        }
      },
      RequestCitizenshipVerificationIndicator: true,
      RequestIncarcerationVerificationIndicator: true,
      RequestTitleIIMonthlyIncomeVerificationIndicator: false,
      RequestTitleIIAnnualIncomeVerificationIndicator: false,
      RequestQuartersOfCoverageVerificationIndicator: false
    }
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Ssa::H3::SSACompositeRequest.domain_to_mapper(
      ssa_verification_request
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::Ssa::H3::Operations::ValidateSsaH3PayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
