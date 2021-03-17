# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/transformers/request_mapper'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Transformers::RequestMapper do
  context 'valid params' do
    let(:input_params) do
      [{ 'user_name' => 'Jane',
         'city' => 'NYC',
         'street' => 'Street 1',
         'zipcode' => '123' }]
    end

    let(:output_params) do
      { :'User Name' => "Jane",
        :address => { :city => "NYC",
                      :street => "Street 1",
                      :zipcode => "123" } }
    end

    it 'should return the expected params' do
      expect(subject.call(input_params)).to eq([output_params])
    end
  end
end
