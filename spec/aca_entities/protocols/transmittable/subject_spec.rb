# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Subject do
  # Dummy::Entity is a dummy class that includes the Transmittable::Subject mixin
  before :each do
    # rubocop:disable Lint/ConstantDefinitionInBlock
    module Types
      include Dry.Types()
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock

    dummy_entity_klass = Class.new(Dry::Struct) do
      attribute :entity_id, Types::String.meta(omittable: true)
      attribute :entity_name, Types::Symbol.meta(omittable: false)
      attribute :entity_title, Types::String.meta(omittable: true)
      attribute :entity_description, Types::String.meta(omittable: true)
      attributes_from AcaEntities::Protocols::Transmittable::Subject
    end
    stub_const('Dummy::Entity', dummy_entity_klass)
  end

  context 'Calling the subject entity with valid params' do
    let(:entity_id) { 'entity_12345' }
    let(:entity_name) { :subject_entity }
    let(:entity_title) { entity_name.to_s }
    let(:entity_description) { 'Description for Subject Entity' }

    let(:entity_params) do
      {
        entity_id: entity_id,
        entity_name: entity_name,
        entity_title: entity_title,
        entity_description: entity_description
      }
    end

    subject { Dummy::Entity }

    it 'should pass validation' do
      expect(subject.new(entity_params)).to be_a subject
      expect(subject.new(entity_params).to_h).to eq entity_params
    end

    context 'and with transactions' do
      subject { Dummy::Entity }

      let(:transaction_id) { 'transaction_12345' }
      let(:transaction_name) { :verification_transaction }
      let(:transaction_title) { transaction_name.to_s }
      let(:transaction_process_status) { { initial_state_key: :draft, status: :draft } }
      let(:transaction_started_at) { DateTime.now }
      let(:transaction_errors) { [] }

      let(:transaction) do
        {
          id: transaction_id,
          name: transaction_name,
          title: transaction_title,
          process_status: transaction_process_status,
          started_at: transaction_started_at,
          errors: transaction_errors
        }
      end
      let(:transactions) { [transaction] }

      let(:all_params) { entity_params.merge(transactions: transactions) }

      it 'should pass validation' do
        expect(subject.new(all_params)).to be_a subject
        expect(subject.new(all_params).to_h).to eq all_params
      end
    end
  end
end