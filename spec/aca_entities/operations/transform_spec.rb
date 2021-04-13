# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/transforms/mcr_to/cv_input'

RSpec.describe ::Operations::Transform do
 
  describe 'with valid input file' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'sample.json') }

    it 'should transform the keys' do
      binding.pry
      result = Medicaid::Transforms::McrTo::CvInput.call(source_file, "test.json", {})
      expect(result).to eql(output)
    end
  end
end
