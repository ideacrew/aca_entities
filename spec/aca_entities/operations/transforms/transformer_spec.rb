# frozen_string_literal: true

require 'spec_helper'
require 'transform/transformer'

RSpec.describe AcaEntities::Operations::Transforms::MapSerializer do
  describe 'dsl' do
    let(:foo) do
      Module.new do
        include AcaEntities::Operations::Transforms::Transformer
        namespace 'a' do
          map 'b', 'c'
        end
      end
    end

    let(:foo2) do
      Module.new do
        include AcaEntities::Operations::Transforms::Transformer
        namespace 'a'
      end
    end

    describe 'with valid input block' do
      it 'should build dry container' do
        expect(foo.mapping_container._container.keys.empty?).to eq false
      end
    end

    describe 'with invalid input block' do
      it 'should not build dry container' do
        expect {foo2.mapping_container}.to raise_error 'no block given'
      end
    end
  end

  describe '.add_key' do
    let(:foo) {AcaEntities::Operations::Transforms::MapSerializer.new('a.b')}

    describe 'with valid input block' do
      it 'should build dry transformer function' do
        result = foo.add_key('c', 1)
        expect(result.transproc.is_a?(Dry::Transformer::Function)).to eq true
      end
    end

    describe 'with invalid input' do
      it 'should not build dry transformer function' do
        expect {foo.add_key('')}.to raise_error 'arg1 should not be empty string or an integer'
      end
    end
  end

  describe '.rewrap' do
    let(:foo) {AcaEntities::Operations::Transforms::MapSerializer.new('a.b')}

    describe 'with valid input block' do
      it 'should build dry transformer function' do
        blk = proc {map 'r', 's'}
        result = foo.rewrap('c', &blk)
        expect(result.is_a?(Hash)).to eq true
        expect(result.values.first.transproc.is_a?(Dry::Transformer::Function)).to eq true
      end
    end

    describe 'with invalid input' do
      it 'should not build dry transformer function' do
        expect {foo.rewrap('c')}.to raise_error 'no block given'
      end
    end
  end

  describe '.add_namespace' do
    let(:foo) {AcaEntities::Operations::Transforms::MapSerializer.new('a.b')}

    describe 'with valid input block' do
      it 'should build dry transformer function' do
        result = foo.add_namespace('b', 'd', type: :array)
        expect(result.is_a?(Hash)).to eq true
        expect(result.values.first.transproc.is_a?(Dry::Transformer::Function)).to eq true
      end
    end

    describe 'with invalid input' do
      it 'should not build dry transformer function' do
        expect {foo.add_namespace('b', 'd')}.to raise_error 'expected arg3 not be empty'
      end
    end
  end

  describe '.namespace' do
    let(:foo) {AcaEntities::Operations::Transforms::MapSerializer.new('a.b')}

    describe 'with valid input block' do
      it 'should build dry transformer function' do
        blk = proc {map 'r', 's'}
        result = foo.namespace('b', &blk)
        expect(result.is_a?(Hash)).to eq true
        expect(result.values.first.transproc.is_a?(Dry::Transformer::Function)).to eq true
      end
    end

    describe 'with invalid input' do
      it 'should not build dry transformer function' do
        expect {foo.namespace('b', 'd')}.to raise_error 'no block given'
      end
    end
  end
end

RSpec.describe AcaEntities::Operations::Transforms::Transformer::ClassMethods do
  let(:dummy_class) {Class.new {extend AcaEntities::Operations::Transforms::Transformer::ClassMethods}}

  describe '.namespace' do
    describe 'with valid input block' do
      it 'should build dry transformer function' do
        blk = proc {map 'b', 'b1'}

        result = dummy_class.namespace('a', &blk)
        expect(result.is_a?(Hash)).to eq true
        expect(result.values.first.transproc.is_a?(Dry::Transformer::Function)).to eq true
      end
    end

    describe 'with invalid input' do
      it 'should not build dry transformer function' do
        expect {dummy_class.namespace('b', 'd')}.to raise_error 'no block given'
      end
    end
  end
end

RSpec.describe AcaEntities::Operations::Transforms::Map do
  describe 'with transform action' do
    let(:foo) {AcaEntities::Operations::Transforms::Map.new('a.b', 'c', nil, :rename_nested_keys)}

    it 'should build dry transformer function' do
      expect(foo.transproc.is_a?(Dry::Transformer::Function)).to eq true
    end
  end

  describe 'with transform action and proc' do
    let(:foo) {AcaEntities::Operations::Transforms::Map.new('a.b', 'c', nil, :rename_nested_keys, proc: proc {|v| v.downcase})}

    it 'should build dry transformer composite' do
      expect(foo.transproc.is_a?(Dry::Transformer::Composite)).to eq true
    end
  end

  describe 'without transform action' do
    let(:foo) {AcaEntities::Operations::Transforms::Map.new('a.b', 'c', nil)}

    it 'should not build dry transformer function' do
      expect(foo.transproc).to eq nil
    end
  end
end