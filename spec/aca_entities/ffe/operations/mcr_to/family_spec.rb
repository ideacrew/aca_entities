# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ffe/operations/mcr_to/family'
require 'aca_entities/ffe/transformers/mcr_to/family'

RSpec.describe ::AcaEntities::Ffe::Operations::McrTo::Family do
  describe 'When a valid json file passed' do
    let(:source_file) { Pathname.pwd.join("spec/support/transform_example_payloads/application.json") }

    it 'should pass transform hash' do
      ::AcaEntities::Ffe::Transformers::McrTo::Family.call(source_file, { transform_mode: :batch }) do |payload|
        record = ::AcaEntities::Ffe::Transformers::McrTo::Family.transform(payload)
        @result = described_class.new.call(record: record[:family])
      end
      expect(@result).to be_a(Dry::Monads::Result::Success)
    end
  end
end
