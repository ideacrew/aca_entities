# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/mitc/types'
require 'aca_entities/magi_medicaid/mitc/deprived_child'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::DeprivedChild do
  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new({ qualify_as_deprived_child: 'Y' })).to be_a ::AcaEntities::MagiMedicaid::Mitc::DeprivedChild
    end

    it 'should not raise error' do
      expect { described_class.new({ qualify_as_deprived_child: 'Y' }) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
