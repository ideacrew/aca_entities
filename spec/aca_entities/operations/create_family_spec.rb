# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/families/sample_cv_family'

RSpec.describe ::AcaEntities::Operations::CreateFamily do
  include_context 'sample family cv'

  subject { described_class.new.call(input_params) }

  context 'valid params' do
    let(:input_params) { family_cv }

    it 'returns success' do
      expect(subject).to be_success
    end

    it 'returns an instance of AcaEntities::Families::Family' do
      expect(subject.success).to be_a(::AcaEntities::Families::Family)
    end
  end

  context 'invalid params' do
    let(:input_params) do
      family_cv.merge({ family_members: nil })
    end

    it 'returns failure' do
      expect(subject).to be_failure
    end

    it 'returns failure with error messages' do
      expect(subject.failure).to eq({ family_members: ['must be an array'] })
    end
  end
end
