# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Transforms::HashFunctions do
  describe 'with valid input file' do
    describe '.map_value' do
      it 'returns a new hash with given proc applied to value with namespace' do
        input = { :boo => { :foo => 'BAR' } }
        output = { :boo => { :foo => 'bar' } }
        map_value = described_class.map_value(input, [:boo], proc {|value| value.to_s.downcase})
        expect(map_value).to eql(output)
      end

      it 'returns a new hash with given proc applied to value without namespace' do
        input = { :foo => 'BAR' }
        output = { :foo => 'bar' }
        map_value = described_class.map_value(input, [], proc {|value| value.to_s.downcase})
        expect(map_value).to eql(output)
      end
    end

    describe '.add_key' do
      it 'returns a new hash with new key value pair' do
        input = { :boo => { :foo => nil } }
        output = { :boo => { :foo => 'bar' } }
        map_value = described_class.add_key(input, [:boo, :foo], 'bar')
        expect(map_value).to eql(output)
      end
    end

    describe '.build_nested_hash' do
      it 'returns a new hash with new key value pair' do
        record = {}
        values = []
        data = { dob: '1969-03-01' }
        output = { :dob => '1969-03-01' }

        map_value = described_class.build_nested_hash(record, values, data)
        expect(map_value).to eql(output)
      end

      it 'returns a new hash with value as array of key value pair ' do
        record = {}
        values = [{ test: :array }]
        data = { dob: '1969-03-01' }
        output = { :test => [{ :dob => '1969-03-01' }] }

        map_value = described_class.build_nested_hash(record, values, data)
        expect(map_value).to eql(output)
      end

      it 'returns a new hash with no_key tag as top level key' do
        record = {}
        values = [{ :no_key => :hash }]
        data = { dob: '1969-03-01' }
        output = { :no_key => { :dob => '1969-03-01' } }

        map_value = described_class.build_nested_hash(record, values, data)
        expect(map_value).to eql(output)
      end
    end

    describe '.rename_nested_keys' do
      it 'returns a new hash with renamed key' do
        input =  { :d => '123' }
        output = { :a => { :b => { :c => { :e => '123' } } } }

        map_value = described_class.rename_nested_keys(input, [{ :d => :e }], [:a, :b, :c, :e])
        expect(map_value).to eql(output)
      end
    end

    describe '.rewrap_keys' do
      it 'returns a new hash with new namespaces' do
        input = { :boo => { :foo => 'bar' } }
        output = { :too => 'bar' }
        rewrap_keys = described_class.rewrap_keys(input, [:boo, :foo], [:boo, :too])
        expect(rewrap_keys).to eql(output)
      end
    end

    describe '.deep_rename_keys' do
      it 'returns a new hash with renamed keys' do
        input = { 'a' => { 'b' => { 'c' => { 'd' => '123' } }, 'f' => { 'd' => '456' } } }
        output = { 'a' => { 'b' => { 'c' => { 'e' => '123' } }, 'f' => { 'e' => '456' } } }
        map_value = described_class.deep_rename_keys(input, { 'd' => 'e' })
        expect(map_value).to eql(output)
      end
    end
  end
end
