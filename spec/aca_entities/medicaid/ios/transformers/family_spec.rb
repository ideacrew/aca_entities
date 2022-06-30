# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/transformers/family'

RSpec.describe AcaEntities::Medicaid::Ios::Transformers::Family do
  describe 'When a valid json file passed' do

    let(:family) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_cv_payload.json")) } # should use more recent example payload

    before do
        described_class.call(family) { |record| @transform_result = record }
    end

    it 'should transform the payload according to instructions' do
        expect(@transform_result).to have_key(:SspdcRequest)
    end
  end
end