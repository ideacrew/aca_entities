# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/transform_examples/mcr_to/cv_input'

RSpec.describe ::AcaEntities::Operations::TransformExamples::McrTo::CvInput do
  describe 'with valid input file' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'application.json') }

    it 'should transform keys' do
      AcaEntities::Operations::TransformExamples::McrTo::CvInput.call(source_file) do |result|
        expect(result).to have_key(:family)
      end
    end
  end
end
