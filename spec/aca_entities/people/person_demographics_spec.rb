# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonDemographics, dbclean: :after_each do

  let!(:input_params) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(input_params.reject { |k, _v| k == :dob }) }.to raise_error(Dry::Struct::Error, /:dob is missing/)
    end
  end

  describe 'alive_status' do
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

    let(:params) do
      input_params.merge(alive_status: alive_status)
    end

    it 'initializes' do
      expect(described_class.new(params)).to be_a described_class
    end

    it 'does not raise errors' do
      expect { described_class.new(params) }.not_to raise_error
    end
  end
end
