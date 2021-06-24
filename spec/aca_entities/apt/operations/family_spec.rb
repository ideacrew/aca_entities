# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'
require "aca_entities/atp/transformers/cv/family"
require "aca_entities/atp/operations/family"

RSpec.describe ::AcaEntities::Atp::Operations::Family, dbclean: :after_each do
  let(:xml_path) {Pathname.pwd.join('spec/support/atp_sample_payloads/sample.xml')}

  describe 'with valid xml' do
    before do
      @result = described_class.new(worker_mode: :single, path: xml_path).call
    end

    # it 'should return transformed hash' do
    # end
  end
end
