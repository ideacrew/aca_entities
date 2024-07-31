# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples/aca_entities/fdsh/json_operations/request_magi_medicaid_application'

RSpec.describe AcaEntities::Fdsh::NonEsi::Rj31::Operations::NonEsiMecJsonRequest do
  include_context 'request magi medicaid application'

  subject do
    described_class.new.call(application)
  end

  it "is successful" do
    expect(subject.success?).to be_truthy
  end

  context "when applicant doesn't have an ssn" do
    let(:encrypted_ssn_2) { nil }

    it "is successful" do
      expect(subject.success?).to be_truthy
    end
  end

  context "when no applicants on the application have non_esi_evidence" do
    let(:non_esi_evidence) { nil }

    it "is failure" do
      expect(subject.failure?).to be_truthy
    end
  end
end
