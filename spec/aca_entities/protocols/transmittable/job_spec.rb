# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Job, type: :model do

  before :each do
    DatabaseCleaner.clean
    let(:transmission_base_klass) { Transmittable::Transmission }
    let(:transaction_base_klass) { Dry::Struct }

    dummy_transmission_klass =
      Class.new(super_class: Transmittable::Transmission) do
        # action here
      end
    # dummy_transmission_klass.instance_eval { class_inheritable_accessor :transmission_base_klass }
    stub_const('Dummy::Transmission', dummy_transmission_klass)

    dummy_transaction_subject_klass =
      Class.new(super_class: Dry::Struct) do
        include 'Transmittable::Subject'

        attribute :type, Types::String.meta(omittable: false)
        attribute :message_text, Types::String.meta(omittable: false)
      end
    # dummy_transmission_klass.instance_eval { class_inheritable_accessor :transaction_base_klass }
    stub_const('Dummy::Transaction', dummy_transaction_subject_klass)
  end

  context 'Given defined Transmission and Transaction Subject classes' do
    let(:message_1) { Dummy::Transaction.new }
    let(:transmissions) { [] }

    let(:account) { { id: "123abc" }}
    let(:title) { 'Chum Check Service' }
    let(:name) { 'chum_verification' }
    let(:description) { 'Returns information on ' }
    let(:started_at) { DateTime.now }

    context 'A Job is initialized' do
      it 'should have a uniquejob_id'
      it 'should have a started_at value'

      context 'and a Time to Live (TTL) value is provided' do
        let(:time_to_live) { 1 }

        context 'and the Job is expired' do
        end
      end
    end
  end
end
