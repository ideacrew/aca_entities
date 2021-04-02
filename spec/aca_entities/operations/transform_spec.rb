# frozen_string_literal: true

require 'spec_helper'


RSpec.describe ::Operations::Transform do
 
  describe 'with valid input file' do

    let(:source_file) { Pathname.pwd.join('spec', 'support', 'sample.json') }

    it 'should transform the keys' do
      # binding.pry
      Medicaid::Transforms::IapTo::MitcInput.call(source_file, "test.json", {})

    end
  end
end
