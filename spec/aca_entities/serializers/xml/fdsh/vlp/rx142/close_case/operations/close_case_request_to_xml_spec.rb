# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Serializers::Xml::Fdsh::Vlp::Rx142::CloseCase::Operations::CloseCaseRequestToXml, dbclean: :after_each do

  context 'with valid arguments' do
    let(:close_case_request) do
      {
        CaseNumber: 'jas15he4k1Du1HD'
      }
    end

    let(:close_case_request_entity) do
      AcaEntities::Fdsh::Vlp::Rx142::CloseCase::CloseCaseRequest.call(close_case_request)
    end

    subject do
      described_class.new.call(close_case_request_entity)
    end

    it "is successful" do
      expect(subject.success?).to be_truthy
    end
  end

  context 'with an invalid CaseNumber' do
    let(:close_case_request) do
      {
        CaseNumber: '12345'
      }
    end

    let(:close_case_request_entity) do
      AcaEntities::Fdsh::Vlp::Rx142::CloseCase::CloseCaseRequest.call(close_case_request)
    end

    subject do
      described_class.new.call(close_case_request_entity)
    end

    it "is not successful" do
      expect(subject.success?).to be_falsey
    end
  end
end
