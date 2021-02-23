# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/iap/mitc/transformers/request_mapper'

RSpec.describe ::AcaEntities::Iap::Mitc::Transformers::RequestMapper do
  let(:required_params) do
  end

  context 'valid params' do
    let(:input_params) do
      [{'user_name' => 'Jane',
        'city' => 'NYC',
        'street' => 'Street 1',
        'zipcode' => '123'}]
    end

    it 'should return the expected params' do
      expect(subject.(input_params)).to eq([{:'User Name'=>"Jane", :address=>{:city=>"NYC", :street=>"Street 1", :zipcode=>"123"}}])
    end
  end
end
