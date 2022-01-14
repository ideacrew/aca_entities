# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Mongoid::ModelAdapter do
  let(:dummy_class) do
    Class.new { include ::AcaEntities::Operations::Mongoid::ModelAdapter }
  end

  subject { dummy_class.new }

  let(:hash_map_value) do
    { favorite_foods: { fruit: 'apple', vegetable: 'asparagus' } }
  end

  let(:flat_hash_value) do
    { fruit: 'apple', vegetable: 'asparagus', category: :favorite_foods }
  end

  describe '.to_attribute_hash' do
    let(:key) { :category }
    it 'should transform the hash map to a flat hash' do
      expect(
        subject.to_attribute_hash(hash_map_value, key)
      ).to eq flat_hash_value
    end
  end
end
