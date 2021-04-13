# frozen_string_literal: true

require 'spec_helper'
require 'transform/transformer'

RSpec.describe Transform::MapSerializer do
  describe 'dsl' do
    let(:foo) do
      Module.new do
        include Transform::Transformer
        namespace 'a' do
          map 'b', 'c'
        end
      end
    end

    describe 'with valid input block' do
      it 'should build dry container' do
        expect(foo.mapping_container._container.keys.empty?).to eq false
      end
    end

    let(:foo2) do
      Module.new do
        include Transform::Transformer
        namespace 'a' do
        end
      end
    end

    describe 'with invalid input block' do
      it 'should not build dry container' do
        expect(foo2.mapping_container._container.keys.empty?).to eq true
      end
    end
  end
end

RSpec.describe Transform::Map do
  describe 'with transform action' do
    let(:foo) {Transform::Map.new("a.b", "c", nil, :rename_nested_keys)}

    it 'should build dry transformer function' do
      expect(foo.transproc).not_to eq nil
    end
  end

  describe 'with transform action and proc' do
    let(:foo) {Transform::Map.new("a.b", "c", nil, :rename_nested_keys, proc: Proc.new{|v| v.downcase})}

    it 'should build dry transformer composite' do
      expect(foo.transproc.is_a?(Dry::Transformer::Composite)).to eq true
    end
  end

  describe 'without transform action' do
    let(:foo) {Transform::Map.new("a.b", "c", nil)}

    it 'should not build dry transformer function' do
      expect(foo.transproc).to eq nil
    end
  end
end