# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Operations::Yaml::Deserialize do
  # include RegistryDataSeed
  subject { described_class.new.call(input) }

  context 'When valid file IO passed' do
    let(:file_path) do
      Pathname.pwd.join('spec', 'support', 'seedfiles', 'async_api_example.yml')
    end
    let(:input) { { yaml: IO.read(file_path) } }

    it 'should return success with hash output' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to be_a Hash
    end

    it 'should return options hash' do
      components = subject.value!.keys

      expect(components).to include("channels")
      expect(components).to include("components")
      expect(components).to include("servers")
    end
  end
end