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

  context "with valid xml containing pregnant and post partum applicant" do
    before do
      @result = subject.first
    end
    it "should return pregnancy status for pregnant applicant and nil post partum" do
      expect(@result[:applicants][1][:pregnancy_information][:is_pregnant]).to be_truthy
      expect(@result[:applicants][1][:pregnancy_information][:is_post_partum_period]).to be nil
    end
    it "should return post partum status for post partum applicant and not pregnant" do
      expect(@result[:applicants][2][:pregnancy_information][:is_pregnant]).to be_falsey
      expect(@result[:applicants][2][:pregnancy_information][:is_post_partum_period]).to be_truthy
    end
    it "should return nil post partum and false pregnancy status for other applicant" do
      expect(@result[:applicants][0][:pregnancy_information][:is_pregnant]).to be_falsey
      expect(@result[:applicants][0][:pregnancy_information][:is_post_partum_period]).to be nil
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

  context "with valid xml containing naturalization certificate document information" do
    before do
      @result = subject.first
    end
    it "should return naturalization certificate document information for naturalized applicant" do
      expect(@result[:applicants][0][:vlp_subject]).to eq("Naturalization Certificate")
      expect(@result[:applicants][0][:naturalization_number]).to eq(12_345)
      expect(@result[:applicants][0][:alien_number]).to eq(67_890)
    end
    it "should return nil naturalization certificate document information for other applicant" do
      expect(@result[:applicants][1][:vlp_subject]).to be nil
      expect(@result[:applicants][1][:naturalization_number]).to be nil
      expect(@result[:applicants][1][:alien_number]).to be nil
    end
  end

  context "ssf attestation" do
    before do
      @ssf_attestation = context.resolve("insurance_application.ssf_signer.ssf_attestation").item
      @result = subject.first
    end

    context "with valid xml containing non perjury indicator" do
      it "should map the non perjury indicator to application_submission_terms on the application" do
        expect(@result[:submission_terms]).to eq @ssf_attestation[:non_perjury_indicator]
      end
    end

    context "with valid xml containing medicaid obligations indicator" do
      it "should map the medicaid obligations indicator to medicaid_insurance_collection_terms on the application" do
        expect(@result[:medicaid_insurance_collection_terms]).to eq @ssf_attestation[:medicaid_obligations_indicator]
      end
    end

    context "with valid xml containing medicaid obligations indicator" do
      it "should map the information_changes_indicator indicator to report_change_terms on the application" do
        expect(@result[:report_change_terms]).to eq @ssf_attestation[:information_changes_indicator]
      end
    end

  end

  context "insurance application coverage renewal year quantity" do
    before do
      @coverage_year_quantity = context.resolve("insurance_application.coverage_renewal_year_quantity").item
      @result = subject.first
    end

    context "with valid xml containing coverage renewal year quantity" do
      it "should map the coverage_renewal_year_quantity to years_to_renew on the application" do
        expect(@result[:years_to_renew]).to eq @coverage_year_quantity
      end

      it "should set the medicaid_terms to true on the application when renewal year quantity is greater than 0" do
        expect(@result[:medicaid_terms]).to eq true
      end
    end
  end

  context "with valid xml containing applicant with absent parent or spouse code as Yes" do
    before do
      @result = subject.first
    end

    it "should return parent_living_out_of_home_terms on the application as true" do
      expect(@result[:parent_living_out_of_home_terms]).to eq true
    end
  end

  context "with valid xml containing applicant with an alimony and ira deduction" do
    before do
      @result = subject.first
    end

    it "should return correct alimony deduction type, frequency, and amount" do
      expect(@result[:applicants][0][:deductions].first[:kind]).to eq("alimony_paid")
      expect(@result[:applicants][0][:deductions].first[:frequency_kind]).to eq("monthly")
      expect(@result[:applicants][0][:deductions].first[:amount]).to eq(500)
    end

    it "should return correct ira deduction type, frequency, and amount" do
      expect(@result[:applicants][0][:deductions].last[:kind]).to eq("ira_deduction")
      expect(@result[:applicants][0][:deductions].last[:frequency_kind]).to eq("yearly")
      expect(@result[:applicants][0][:deductions].last[:amount]).to eq(100)
    end
  end
end
