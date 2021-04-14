# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/transforms/mcr_to/cv_input'

RSpec.describe ::AcaEntities::Operations::Transforms::Transform do
  describe 'with valid input file' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'application.json') }

    it 'should transform keys' do
      result = AcaEntities::Medicaid::Transforms::McrTo::CvInput.call(source_file, "test.json", {})

      expect(result).to eql(output)
    end
  end
end
