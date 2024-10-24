# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Operations::Files::Read do
  context 'When invalid filename is passed' do
    let(:filename) { 'this/filename/is/invalid' }
    let(:params) { { filename: filename } }

    it 'should fail with error message' do
      expect(described_class.new.call(params).failure?).to be_truthy
      expect(
        described_class.new.call(params).failure.first
      ).to start_with 'No such file or directory'
    end
  end

  context 'When valid file Pathname is passed' do
    let(:pathname) do
      Pathname.pwd.join('spec', 'support', 'seedfiles', 'async_api_example.yml')
    end

    it 'should return success with file io' do
      result = described_class.new.call({ filename: pathname })

      expect(result.success?).to be_truthy
      expect(result.value!).to start_with '---'
    end
  end
end
