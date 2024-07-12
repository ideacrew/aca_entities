# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::NoticeOptions do

  describe 'with valid arguments' do
    let(:input_params) do
      { send_eligibility_notices: true, send_open_enrollment_notices: false, paper_notification: false }
    end

    before do
      notice_options = AcaEntities::MagiMedicaid::Contracts::NoticeOptionsContract.new.call(input_params).to_h
      @result = described_class.new(notice_options)
    end

    it 'should return NoticeOptions entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of NoticeOptions' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end
end
