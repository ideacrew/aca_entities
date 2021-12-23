# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Mongoid::EntityAdapter do
  let(:dummy_class) do
    Class.new do
      include ::AcaEntities::Operations::Mongoid::EntityAdapter

      def hash_map_value
        { favorite_foods: { fruit: 'apple', vegetable: 'asparagus' } }
      end

      def flat_hash_value
        { fruit: 'apple', vegetable: 'asparagus', category: :favorite_foods }
      end
    end
  end

  subject { dummy_class.new }

  describe '.to_map_hash' do
    let(:key) { :category }
    it 'should transform the hash map to a flat hash' do
      expect(subject.to_map_hash(subject.flat_hash_value, key)).to eq subject
           .hash_map_value
    end
  end
end
