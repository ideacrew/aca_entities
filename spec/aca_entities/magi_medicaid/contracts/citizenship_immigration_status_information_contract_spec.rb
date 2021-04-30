# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::CitizenshipImmigrationStatusInformationContract,  dbclean: :after_each do
  context 'valid params' do
    let(:all_params) { { citizen_status: 'us_citizen', is_resident_post_092296: true, is_lawful_presence_self_attested: false } }

    before do
      @result = subject.call(all_params)
    end

    it 'should return success' do
      expect(@result).to be_success
    end

    it 'should return all params' do
      expect(@result.to_h).to eq(all_params)
    end
  end

  context 'invalid params' do
    context 'bad value for citizen_status' do
      before do
        @result = subject.call({ citizen_status: 'test_status', is_resident_post_092296: true, is_lawful_presence_self_attested: false })
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        err_msg = /must be one of: us_citizen, naturalized_citizen, alien_lawfully_present/
        expect(@result.errors.to_h[:citizen_status].first).to match(err_msg)
      end
    end
  end
end
