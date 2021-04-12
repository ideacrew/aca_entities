# frozen_string_literal: true

require 'spec_helper'


RSpec.describe ::Operations::HashFunctions do

  describe 'with valid input file' do
    describe ".map_value" do
      it "returns a new hash with given proc applied to value" do
        input = { :boo => {:foo => 'BAR' }}
        output = {:boo => { :foo => 'bar' }}
        map_value = described_class.map_value(input,[:boo], Proc.new{|value| value.to_s.downcase})
        expect(map_value).to eql(output)
      end
    end

    describe ".add_key" do
      it "returns a new hash with new key value pair" do
        input = { :boo => {:foo => nil} }
        output = {:boo => { :foo => 'bar' }}
        map_value = described_class.add_key(input,[:boo, :foo], 'bar')
        expect(map_value).to eql(output)
      end
    end

    describe ".rename_nested_keys" do
      it "returns a new hash with symbolized keys" do
        input = {"a" => {"b" => { "c" => {"d" => "123"}}, "f" => {"d" => "456"}}}
        output = {"a" => {"b" => { "c" => {"e" => "123"}}, "f" => {"d" => "456"}}}
        map_value = described_class.rename_nested_keys(input,[{"d" => "e"}], ["a","b","c"])
        expect(map_value).to eql(output)
      end
    end
    #
    it { expect(described_class).not_to be_contain(:rename_nested_keys) }
    #
    # describe ".append_keys" do
    #   it "returns a new hash with stringified keys" do
    #     stringify_keys = described_class.t(:stringify_keys)
    #
    #     input = { foo: "bar" }.freeze
    #     output = { "foo" => "bar" }
    #
    #     expect(stringify_keys[input]).to eql(output)
    #   end
    # end
    #
    # describe ".rewrap_keys" do
    #   it "returns a new hash with symbolized keys" do
    #     stringify_keys = described_class.t(:deep_stringify_keys)
    #
    #     input = { foo: "bar", baz: [{ one: 1 }, "two"] }
    #     output = { "foo" => "bar", "baz" => [{ "one" => 1 }, "two"] }
    #
    #     expect(stringify_keys[input]).to eql(output)
    #   end
    # end
    #
    # it { expect(described_class).not_to be_contain(:stringify_keys!) }
    #
    # describe ".deep_rename_keys" do
    #   it "returns a new hash with given proc applied to values" do
    #     map_values = described_class.t(:map_values, ->(value) { value.strip })
    #
    #     input = { "foo" => " bar " }.freeze
    #     output = { "foo" => "bar" }
    #
    #     expect(map_values[input]).to eql(output)
    #   end
    # end
  end
end
