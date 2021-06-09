# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::BenchmarkPremiumContract,  dbclean: :after_each do
  let(:input_params) do
    { health_only_lcsp_premiums: [{ member_identifier: '95', monthly_premium: 310.50 },
                                  { member_identifier: '96', monthly_premium: 310.60 }],
      health_only_slcsp_premiums: [{ member_identifier: '95', monthly_premium: 320.50 },
                                   { member_identifier: '96', monthly_premium: 320.60 }] }
  end

  context 'valid params' do
    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'no params' do
      it 'should return failure' do
        expect(subject.call({}).errors.to_h).to eq({ health_only_lcsp_premiums: ['is missing'],
                                                     health_only_slcsp_premiums: ['is missing'] })
      end
    end

    context 'invalid value for monthly_premium' do
      let(:bad_params) { input_params.merge({ health_only_lcsp_premiums: 'Test' }) }

      it 'should return failure' do
        expect(subject.call(bad_params).errors.to_h).to eq({ health_only_lcsp_premiums: ['must be an array'] })
      end
    end
  end
end
