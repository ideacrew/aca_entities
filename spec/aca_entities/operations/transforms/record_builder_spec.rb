# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Transforms::RecordBuilder do
  let(:define_class) { described_class.new(root: 'a.b', type: :array)}

  describe 'with valid input file' do
    describe '.append' do
      it 'returns a new hash with given proc applied to value' do
        # identifier = 'foo'
        # data = { :a => { :b => { :c => { :foo => { :d => 'ccr' } } } } }
        # output = { :boo => { :foo => 'bar' } }

        # map_value = define_class.append(identifier, data)
        # expect(map_value).to eql(output)
      end
    end
  end
end
