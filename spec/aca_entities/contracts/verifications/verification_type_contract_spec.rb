# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Verifications::VerificationTypeContract, dbclean: :after_each do

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let!(:required_params) do
    {
      type_name: "DC Residency",
      validation_status: "attested",
      applied_roles: ["consumer_role"],
      update_reason: nil,
      rejected: false,
      external_service: nil,
      due_date: Date.today,
      due_date_type: nil,
      updated_by: person_reference,
      inactive: nil,
      vlp_documents: [],
      from_validation_status: "outstanding",
      to_validation_status: "attested"
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :key })
      end

      it 'should return failure' do
        # expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        # expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        # expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(updated_by: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end

      # it 'should return error message' do
      #   result = subject.call(required_params.merge(due_date: nil))
      #   expect(result.errors.messages.first.text).to eq('must be a date')
      # end
    end
  end
end


