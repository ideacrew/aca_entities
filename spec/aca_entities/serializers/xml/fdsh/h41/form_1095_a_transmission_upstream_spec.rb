# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::H41::Form1095ATransmissionUpstream,
               "given a minimal h41 batch request" do

  let(:insurance_policy) do
    {
      MarketPlacePolicyNum: "12345",
      PolicyIssuerNm: "Anthem",
      PolicyStartDt: Date.new(Date.today.year, 1, 1),
      PolicyTerminationDt: Date.new(Date.today.year, 12, 31)
    }
  end

  let(:person_name) do
    {
      PersonFirstNm: "John",
      PersonLastNm: "Legend"
    }
  end

  let(:address) do
    {
      AddressLine1Txt: "TEST",
      CityNm: "Maine",
      USStateCd: "ME",
      USZIPCd: "20007"
    }
  end

  let(:recipient) do
    {
      OtherCompletePersonName: person_name,
      BirthDt: Date.new(1988, 1, 1),
      UsAddressGroup: address
    }
  end

  let(:recipient_spouse) do
    {
      OtherCompletePersonName: person_name
    }
  end

  let(:covered_individual) do
    {
      InsuredPerson: { OtherCompletePersonName:  person_name },
      CoverageStartDt: Date.new(Date.today.year, 1, 1),
      CoverageEndDt: Date.new(Date.today.year, 12, 31)
    }
  end

  let(:coverage_household_group) do
    {
      CoveredIndividuals: [covered_individual]
    }
  end

  let(:premium_information) do
    {
      MonthlyPremiumAmt: 23.45,
      MonthlyPremiumSLCSPAmt: 65.60,
      MonthlyAdvancedPTCAmt: 12.50
    }
  end

  let(:annual_premium_totals) do
    {
      AnnualPremiumAmt: 75.00,
      AnnualPremiumSLCSPAmt: 98.00,
      AnnualAdvancedPTCAmt: 45.43
    }
  end

  let(:policy_premium_information) do
    {
      JanPremiumInformation: premium_information,
      FebPremiumInformation: premium_information,
      MarPremiumInformation: premium_information,
      AprPremiumInformation: premium_information,
      MayPremiumInformation: premium_information,
      JunPremiumInformation: premium_information,
      JulPremiumInformation: premium_information,
      AugPremiumInformation: premium_information,
      SepPremiumInformation: premium_information,
      OctPremiumInformation: premium_information,
      NovPremiumInformation: premium_information,
      DecPremiumInformation: premium_information,
      AnnualPolicyTotalAmounts: annual_premium_totals
    }
  end

  let(:form_1095a_upstream_detail) do
    {
      RecordSequenceNum: "567856789",
      TaxYr: "2022",
      CorrectedInd: "0",
      VoidInd: "0",
      MarketplaceId: "02.ME*.SBE.001.001",
      Policy: insurance_policy,
      Recipient: recipient,
      RecipientSpouse: recipient_spouse,
      CoverageHouseholdGrp: coverage_household_group,
      RecipientPolicyInformation: policy_premium_information
    }
  end

  let(:insurance) do
    {
      InsuranceEffectiveDate: Date.new(2017, 1, 1),
      InsuranceEndDate: Date.new(2017, 12, 31)
    }
  end

  let(:form_1095a_transmission_upstream_request) do
    AcaEntities::Fdsh::H41::Form1095ATransmissionUpstream.new(
      {
        Form1095AUpstreamDetail: [form_1095a_upstream_detail]
      }
    )
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::H41::Form1095ATransmissionUpstream.domain_to_mapper(
      form_1095a_transmission_upstream_request
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::H41::Operations::ValidateH41RequestPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
