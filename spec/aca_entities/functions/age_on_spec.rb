# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Functions::AgeOn do
  describe 'with valid input' do
    it 'should exec proc' do
      on_date = Date.today
      hash = { dob: on_date.prev_year(50) }
      map_value = described_class.new(on_date: on_date)

      expect(map_value.call(hash[:dob])).to eq(50)
    end
  end

  describe 'with invalid input' do
    it 'should exec proc' do
      on_date = '2020,1,1'
      hash = { dob: '1980,1,1' }
      map_value = described_class.new(on_date: on_date)

      expect { map_value.call(hash[:dob]) }.to raise_error
    end
  end
end
