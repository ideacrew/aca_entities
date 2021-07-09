# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ffe/operations/process_mcr_application'
require 'aca_entities/ffe/operations/mcr_to/family'
require 'aca_entities/ffe/transformers/mcr_to/family'

RSpec.describe ::AcaEntities::Ffe::Operations::ProcessMcrApplication do
  describe 'When a valid json file passed' do
    let(:path) { 'spec/support/transform_example_payloads/application.json' }
    let(:klass) { ::AcaEntities::Ffe::Transformers::McrTo::Family }
    let(:worker_mode) {:batch}

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new(path: path, klass: klass, worker: worker_mode).call
      expect(result).to be_a(Dry::Monads::Result::Success)
    end
  end
end
