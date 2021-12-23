# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Mongoid::ModelAdapter do
  let(:dummy_class) do
    Class.new do
      include ::AcaEntities::Operations::Mongoid::ModelAdapter

      def hash_map_value
        { favorite_foods: { fruit: 'apple', vegetable: 'asparagus' } }
      end

      def flat_hash_value
        { fruit: 'apple', vegetable: 'asparagus', category: :favorite_foods }
      end
    end
  end

  subject { dummy_class.new }

  describe '.to_flat_hash' do
    let(:key) { :category }
    it 'should transform the hash map to a flat hash' do
      expect(subject.to_flat_hash(subject.hash_map_value, key)).to eq subject
           .flat_hash_value
    end
  end
end
