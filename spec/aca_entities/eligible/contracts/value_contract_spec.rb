# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligible::ValueContract do
  let(:required_params) do
    {
      title: 'childcare subsidy contribution',
      key: :contribution_grant,
      description: 'contribution value'
    }
  end

  let(:error_message) { { key: ['is missing'] } }

  let(:result) { double(success?: true) }

  context 'Given invalid required parameters' do
    context 'sending with missing parameters should fail validation with :errors' do
      let(:invalid_params) { required_params.except(:key) }
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end
  end

  context 'Given valid required parameters' do
    context 'with a required only' do
      it 'should pass validation' do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end
