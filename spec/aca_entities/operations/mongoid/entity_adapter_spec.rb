# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Mongoid::EntityAdapter do
  let(:dummy_class) do
    Class.new do
      include ::AcaEntities::Operations::Mongoid::EntityAdapter

      def has_attribute?(key)
        attributes.keys.include? key
      end

      def attributes
        { fruit: 'apple', vegetable: 'asparagus', category: :favorite_foods }
      end
    end
  end

  subject { dummy_class.new }

  let(:hash_map_value) do
    { favorite_foods: { fruit: 'apple', vegetable: 'asparagus' } }
  end

  describe '.to_entity_map_hash' do
    context 'hash includes key' do
      let(:key) { :category }

      it 'should transform the hash map to a flat hash' do
        expect(subject.to_entity_map_hash(key)).to eq hash_map_value
      end
    end

    context 'hash does not include key' do
      let(:key) { :bogus_key }

      it 'should raise an error' do
        expect { subject.to_entity_map_hash(key) }.to raise_error ArgumentError
      end
    end
  end
end
