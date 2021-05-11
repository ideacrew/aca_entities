# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/operations/families/process_mcr_application'
require 'aca_entities/operations/transform_examples/mcr_to/cv_input'
require 'aca_entities/operations/families/build_family'

RSpec.describe ::AcaEntities::Operations::Families::ProcessMcrApplication do
  describe 'When a valid json file passed' do
    let(:path) { 'spec/support/transform_example_payloads/application.json' }
    let(:klass) { ::AcaEntities::Operations::TransformExamples::McrTo::CvInput }
    let(:worker_mode) {:batch}

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new(path: path, klass: klass, worker: worker_mode).call
      expect(result).to be_a(Dry::Monads::Result::Success)
    end
  end
end
