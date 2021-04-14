# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/transforms/mcr_to/cv_input'

RSpec.describe ::AcaEntities::Medicaid::Transforms::McrTo::CvInput do
  describe 'When a valid json file passed' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'application.json') }

    it 'should transform the payload according to instructions' do
      result = AcaEntities::Medicaid::Transforms::McrTo::CvInput.call(source_file, "test.json", {})

      expect(result).to eql(output)
    end
  end
end