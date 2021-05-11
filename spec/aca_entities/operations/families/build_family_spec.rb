# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/families/build_family'
require 'aca_entities/operations/transform_examples/mcr_to/cv_input'

RSpec.describe ::AcaEntities::Operations::Families::BuildFamily do
  describe 'When a valid json file passed' do
    let(:path) { Pathname.pwd.join('spec/support/transform_example_payloads/application.json') }
    let(:example_output_hash) { JSON.parse(File.read(Pathname.pwd.join("spec/support/transform_example_payloads/family_transform_result.json"))) }
    let(:klass) { ::AcaEntities::Operations::TransformExamples::McrTo::CvInput }
    let(:worker_mode) {:batch}

    it 'should pass transform hash' do
      result = described_class.new.call(input: path)

      expect(result).to be_a(Dry::Monads::Result::Success)
    end
  end
end
