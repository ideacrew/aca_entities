# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::NoticeOptionsContract, dbclean: :around_each do

  let(:all_params) do
    { send_eligibility_notices: true, send_open_enrollment_notices: false, paper_notification: false }
  end

  let(:invalid_params) do
    { send_eligibility_notices: 'some-elig-notice', send_open_enrollment_notices: false, paper_notification: false }
  end

  context 'with invalid params' do
    it 'should fail validation' do
      result = subject.call(invalid_params)
      expect(result).to be_failure
      expect(result.errors.to_h).to eq({ :send_eligibility_notices => ['must be boolean'] })
    end
  end

  context 'valid parameters' do
    it 'should pass validation' do
      result = subject.call(all_params)
      expect(result).to be_success
    end
  end
end
