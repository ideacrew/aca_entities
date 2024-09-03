# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/vlp_document'

RSpec.describe AcaEntities::Atp, "given an payload with vlp_document hash" do
  context "when a person has Naturalization Number vlp document" do
    let(:payload) do
      { :same_name_indicator => nil,
        :category_text => nil,
        :category_code => "Naturalization Certificate",
        :expiration_date => nil,
        :document_numbers => [],
        :document_person_ids => [{ :identification_id => "2468013579", :identification_category_text => "Naturalization Certificate Number",
                                   :identification_jurisdiction => nil }],
        :naturalization_number => "2468013579",
        :naturalization_certificate_number => "2468013579",
        :naturalization_certificate => nil }
    end

    it 'should transform vlp document with naturalization number' do
      transformed = ::AcaEntities::Atp::Transformers::Cv::VlpDocument.transform(payload)
      expect(transformed[:naturalization_number]).to eq('2468013579')
    end
  end
end
