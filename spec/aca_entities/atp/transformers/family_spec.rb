# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/family'

RSpec.describe AcaEntities::Atp::Transformers::Cv::Family do
  context "VLP documents" do
    let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml")) }

    let(:document) do
      Nokogiri::XML(payload)
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    context 'DS2019 VLP document' do
      it 'should set vlp document with sevis id' do
        transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
        vlp_document = transformed[:family][:family_members][1][:person][:consumer_role][:vlp_documents][0]
        expect(vlp_document[:sevis_id]).to eq('1234567891')
        expect(vlp_document[:subject]).to eq('DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)')
      end
    end
  end
end
