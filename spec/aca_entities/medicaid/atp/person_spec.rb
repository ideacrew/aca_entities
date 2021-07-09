# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_preferred_language'
require 'aca_entities/medicaid/atp/location_street'
require 'aca_entities/medicaid/atp/structured_address'
require 'aca_entities/medicaid/atp/full_telephone'
require 'aca_entities/medicaid/atp/contact_telephone_number'
require 'aca_entities/medicaid/atp/contact_mailing_address'
require 'aca_entities/medicaid/atp/organization_primary_contact_information'
require 'aca_entities/medicaid/atp/contact_information'
require 'aca_entities/medicaid/atp/person_contact_information_association'
require 'aca_entities/medicaid/atp/employer'
require 'aca_entities/medicaid/atp/association_begin_date'
require 'aca_entities/medicaid/atp/association_end_date'
require 'aca_entities/medicaid/atp/person_employment_association'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/income_date'
require 'aca_entities/medicaid/atp/income_earned_date_range'
require 'aca_entities/medicaid/atp/income_frequency'
require 'aca_entities/medicaid/atp/income_payment_frequency'
require 'aca_entities/medicaid/atp/income_source_organization_reference'
require 'aca_entities/medicaid/atp/person_income'
require 'aca_entities/medicaid/atp/person_reference'
require 'aca_entities/medicaid/atp/person_association'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/person_pregnancy_status'
require 'aca_entities/medicaid/atp/person_augmentation'
require 'aca_entities/medicaid/atp/tribal_augmentation'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/person_birth_date'
require 'aca_entities/medicaid/atp/person'

RSpec.describe ::AcaEntities::Medicaid::Atp::Person, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) do
      { id: 'a-person-id',
        person_name: person_name,
        ssn: "012345678",
        sex: "SEX" }
    end

    let(:optional_params) do
      { us_citizen_indicator: true,
        race: "RACE",
        ethnicity: ["eth1", "eth2"],
        birth_date: person_birth_date,
        person_augmentation: person_augmentation,
        tribal_augmentation: tribal_augmentation }
    end

    let(:person_name) do
      { given: 'first',
        middle: 'middle',
        sur: 'last',
        full: 'prefix first middle last suffix' }
    end

    let(:person_birth_date) do
      { date: Date.today - 50 }
    end

    let(:person_augmentation) do
      { us_veteran_indicator: false,
        married_indicator: true,
        pregnancy_status: pregnancy_status,
        preferred_languages: [english_language, spanish_language],
        incomes: [income],
        contacts: [contact_association],
        employments: [employment_association],
        persons: [person] }
    end

    let(:pregnancy_status) do
      { status_indicator: true,
        status_valid_date_range: date_range,
        expected_baby_quantity: 1 }
    end

    let(:date_range) do
      { end_date: end_date }
    end

    let(:english_language) do
      { language_name: "English" }
    end

    let(:spanish_language) do
      { language_name: "Spanish" }
    end

    let(:income) do
      { employment_source_text: "Acme",
        amount: 50_000.00,
        days_per_week: 5.0,
        hours_per_pay_period: 80.0,
        hours_per_week: 40.0,
        category_code: "Salary",
        description_text: "Robot",
        subject_to_federal_restrictions_indicator: false,
        date: income_date,
        earned_date_range: income_earned_date_range,
        frequency: income_frequency,
        payment_frequency: payment_frequency,
        source_organization_reference: source_organization_reference }
    end

    let(:income_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2021",
        year_month: "12/2021" }
    end

    let(:income_earned_date_range) do
      { start_date: start_date,
        end_date: end_date }
    end

    let(:start_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2020",
        year_month: "12/2020" }
    end

    let(:end_date) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2021",
        year_month: "12/2021" }
    end

    let(:income_frequency) do
      { frequency_code: "BiWeekly" }
    end

    let(:payment_frequency) do
      { frequency_code: "Weekly" }
    end

    let(:source_organization_reference) do
      { ref: "ref123" }
    end

    let(:contact_association) do
      { contact: contact,
        category_code: "Home" }
    end

    let(:contact) do
      { contact_email_id: "fake@test.com",
        mailing_address: structured_address,
        telephone_number: full_telephone }
    end

    let(:employment_association) do
      { begin_date: start_date,
        end_date: end_date,
        employer: employer }
    end

    let(:employer) do
      { id: "em123",
        category_text: "Acme",
        organization_primary_contact_information: employer_contact }
    end

    let(:employer_contact) do
      { email: "fake@test.com",
        mailing_address: mailing_address,
        telephone_number: contact_telephone }
    end

    let(:mailing_address) do
      { address: structured_address }
    end

    let(:structured_address) do
      { location_street: { street_full_text: "123 Easy Street" },
        address_secondary_unit_text: "address",
        location_city_name: "Wheaton",
        location_county_name: "Montgomery",
        location_county_code: "code",
        location_state_us_postal_service_code: "ME",
        location_postal_code: "01234" }
    end

    let(:contact_telephone) do
      { telephone: full_telephone }
    end

    let(:full_telephone) do
      { telephone_number_full_id: "1231231234",
        telephone_suffix_id: "0" }
    end

    let(:person) do
      { person: { ref: "pe123" },
        family_relationship_code: 0o1 }
    end

    let(:tribal_augmentation) do
      { recognized_tribe_indicator: true,
        american_indian_or_alaska_native_indicator: true,
        person_tribe_name: "Tribe Name",
        location_state_us_postal_service_code: "ME" }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:given is missing in Hash input/)
    end
  end
end
