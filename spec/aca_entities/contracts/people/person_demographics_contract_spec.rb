# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::People::PersonDemographicsContract, dbclean: :after_each do

  let!(:required_params) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
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

    context 'for nil ssn params' do
      it 'should not have any errors' do
        result = subject.call(required_params.merge(ssn: nil))
        expect(result.errors.empty?).to be_truthy
      end
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :dob })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(dob: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be filled')
      end
    end
  end

  context 'alive_status' do
    let(:alive_status) do
      {
        alive_evidence: {
          key: :alive_evidence,
          title: 'Verification of being alive',
          aasm_state: 'verified',
          description: 'Evidence that a person is alive',
          received_at: DateTime.now,
          is_satisfied: true,
          verification_outstanding: false,
          update_reason: 'Verification of being alive',
          due_on: Date.today,
          external_service: 'SSA',
          updated_by: 'Enroll App',
          evidence_items: [
            id: '52854',
            key: :alive_evidence_item,
            title: 'Verification of being alive',
            description: 'Verification of being alive',
            subject_ref: URI('urn:subject:alive'),
            evidence_ref: URI('urn:evidence:alive')
          ],
          verification_histories: [
            action: 'Admin Hub Call',
            modifier: 'Admin Hub',
            update_reason: 'Verification of being alive',
            updated_by: 'Enroll App',
            is_satisfied: true,
            verification_outstanding: false,
            due_on: Date.today,
            aasm_state: 'verified'
          ],
          request_results: [
            result: 'Verification of being alive',
            source: 'SSA',
            source_transaction_id: '123456789',
            code: '200',
            code_description: 'Verification of being alive',
            raw_payload: "<xml>Verification of being alive</xml>".to_s,
            action: 'Admin Hub Call'
          ]
        },
        is_deceased: false,
        date_of_death: nil
      }
    end

    let(:person_demographics) do
      {
        ssn: "123456789",
        no_ssn: false,
        gender: 'male',
        dob: Date.today,
        is_incarcerated: false,
        alive_status: alive_status
      }
    end

    it 'returns success' do
      expect(subject.call(person_demographics).success?).to be_truthy
    end

    it 'returns results without any errors' do
      expect(subject.call(person_demographics).errors.empty?).to be_truthy
    end
  end
end
