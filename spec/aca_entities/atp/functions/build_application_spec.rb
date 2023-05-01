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
    it "should contain true for applicant with other eligible coverate" do
      result = subject.first
      expect(result[:applicants].first[:has_eligible_health_coverage]).to be_truthy
    end
    it "should contain nil for applicant without other eligible coverage" do
      result = subject.first
      expect(result[:applicants][1][:has_eligible_health_coverage]).to be nil
    end
  end
end
