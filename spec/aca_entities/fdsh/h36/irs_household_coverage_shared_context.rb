# frozen_string_literal: true

RSpec.shared_context 'irs_group_coverage_shared_context' do
  let(:individual_exchange) do
    {
      HealthExchangeId: "02.ME*.SBE.001.001",
      IrsHouseholdGroup: irs_household_group
    }
  end

  let(:irs_household_group) do
    {
      IrsGroupIdentificationNumber: "123456789012345",
      TaxHouseholds: [tax_household],
      InsurancePolicies: [insurance_policy]
    }
  end

  let(:tax_household) do
    {
      TaxHouseholdCoverages: [tax_household_coverage]
    }
  end

  let(:insurance_policy) do
    {
      InsuranceCoverages: [insurance_coverage]
    }
  end

  let(:insurance_coverage) do
    {
      ApplicableCoverageMonthNum: Date.today.month.to_s,
      QHPPolicyNum: "1000109",
      QHPIssuerEIN: "989898989",
      IssuerNm: "ANTHEM",
      PolicyCoverageStartDt: Date.new(Date.today.year, 1, 1),
      PolicyCoverageEndDt: Date.new(Date.today.year, 12, 31),
      TotalQHPMonthlyPremiumAmt: 256.34,
      APTCPaymentAmt: 101.43,
      CoveredIndividuals: [covered_individual]
    }
  end

  let(:covered_individual) do
    {
      InsuredPerson: insured_person,
      CoverageStartDt: Date.new(Date.today.year, 1, 1),
      CoverageEndDt: Date.new(Date.today.year, 12, 31)
    }
  end

  let(:insured_person) do
    {
      CompletePersonName: complete_person_name,
      SSN: ssn,
      BirthDt: dob
    }
  end

  let(:tax_household_coverage) do
    {
      ApplicableCoverageMonthNum: Date.today.month.to_s,
      Household: household
    }
  end

  let(:other_relevant_adult) do
    {
      CompletePersonName: complete_person_name,
      SSN: ssn,
      BirthDt: dob,
      PersonAddressGroup: address_group
    }
  end

  let(:household) do
    {
      PrimaryGroup: primary_group,
      SpouseGroup: spouse_group,
      DependentGroups: [dependent_group],
      AssociatedPolicies: [associated_policy]
    }
  end

  let(:associated_policy) do
    {
      QHPPolicyNum: "1000109",
      QHPIssuerEIN: "989898989",
      SLCSPAdjMonthlyPremiumAmt: 233.33,
      HouseholdAPTCAmt: 101.43,
      TotalHsldMonthlyPremiumAmt: 256.34
    }
  end

  let(:primary_group) do
    {
      Primary: {
        CompletePersonName: complete_person_name,
        SSN: ssn,
        BirthDt: dob,
        PersonAddressGroup: address_group
      }
    }
  end

  let(:spouse_group) do
    {
      Spouse: {
        CompletePersonName: complete_person_name,
        SSN: ssn,
        BirthDt: dob
      }
    }
  end

  let(:dependent_group) do
    {
      DependentPerson: {
        CompletePersonName: complete_person_name,
        SSN: ssn,
        BirthDt: dob
      }
    }
  end

  let(:address_group) do
    {
      UsAddressGroup: us_address_group
    }
  end

  let(:us_address_group) do
    {
      AddressLine1Txt: "123 newyork ave",
      CityNm: "New York",
      USStateCd: "ME",
      USZIPCd: "22005"
    }
  end

  let(:ssn) do
    "123456789"
  end

  let(:dob) do
    Date.new(1974, 1, 1)
  end

  let(:complete_person_name) do
    {
      PersonFirstName: "test",
      PersonLastName: "payload",
      PersonMiddleName: "data"
    }
  end
end