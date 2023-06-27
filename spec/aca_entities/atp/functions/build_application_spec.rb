# frozen_string_literal: true

require "spec_helper"
require "support/atp/inbound_build_application"
require "aca_entities/atp/transformers/cv/phone"
require "aca_entities/atp/transformers/cv/other_questions"
require "aca_entities/atp/transformers/cv/deduction"
require "aca_entities/atp/transformers/cv/income"
require "aca_entities/atp/transformers/cv/contact_info"
require "aca_entities/atp/functions/lawful_presence_determination_builder"
require "aca_entities/atp/functions/address_builder"
require "aca_entities/functions/age_on"
require "aca_entities/atp/functions/relationship_builder"

require "aca_entities/atp/functions/build_application"

RSpec.describe AcaEntities::Atp::Functions::BuildApplication do
  include_context "inbound_build_application"
  subject do
    described_class.new.call(context)
  end
  context "with valid xml containing applicant with other eligible coverage" do
    it "should return an array" do
      expect(subject).to be_a(Array)
    end
    it "should contain true for applicant with other eligible coverage" do
      result = subject.first
      expect(result[:applicants].first[:has_eligible_health_coverage]).to be_truthy
    end
    it "should contain nil for applicant without other eligible coverage" do
      result = subject.first
      expect(result[:applicants][1][:has_eligible_health_coverage]).to be nil
    end
  end

  context "with valid xml containing applicant with naturalized citizen status" do
    before do
      @result = subject.first
    end
    it "should return naturalized citizenship status for naturalized applicant" do
      expect(@result[:applicants].first[:citizenship_immigration_status_information][:citizen_status]).to eq("naturalized_citizen")
    end
    it "should return us citizen status for us citizen applicant" do
      expect(@result[:applicants][1][:citizenship_immigration_status_information][:citizen_status]).to eq("us_citizen")
    end
    it "should return not lawfully present status for applicant without citizenship status" do
      expect(@result[:applicants][2][:citizenship_immigration_status_information][:citizen_status]).to eq("not_lawfully_present_in_us")
    end
  end

  context "with valid xml containing pregnant applicant" do
    before do
      @result = subject.first
    end
    it "should return pregnancy status for pregnant applicant" do
      expect(@result[:applicants][1][:pregnancy_information][:is_pregnant]).to be_truthy
    end
    it "should return only pregnancy due date for pregnant applicant" do
      expect(@result[:applicants][1][:pregnancy_information][:pregnancy_due_on]).to eq(Date.today + 1)
      expect(@result[:applicants][1][:pregnancy_information][:pregnancy_end_on]).to be nil
    end
    it "should return only pregnancy end date for post partum applicant" do
      expect(@result[:applicants][2][:pregnancy_information][:pregnancy_end_on]).to eq(Date.today)
      expect(@result[:applicants][2][:pregnancy_information][:pregnancy_due_on]).to be nil
    end
    it "should return nil end date and due date for applicant without pregnancy status" do
      expect(@result[:applicants][0][:pregnancy_information][:pregnancy_end_on]).to be nil
      expect(@result[:applicants][0][:pregnancy_information][:pregnancy_due_on]).to be nil
    end
  end
end
