# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/person_description_identifier_contract'

RSpec.describe ::AcaEntities::Contracts::PersonDescriptionIdentifierContract, dbclean: :after_each do

  let(:input_params) do
    { is_full_time_student: false }
  end

  context 'with all parameters' do
    it 'should pass validation' do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end
end
