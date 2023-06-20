# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::Operation do
  let(:operation_name) { :open_file }
  let(:operation) { { operation_name: operation_name } }
  let(:params) { { type: 'red', name: 'wilma' } }
  let(:instance_new_init) { { operation: operation } }
  let(:class_call_init) {  params.merge(instance_new_init) }

  before do
    dummy_klass =
      Class.new do
        send(:include, Dry::Monads[:result, :do])
        send(:include, ::AcaEntities::Operations::Operation)

        def call(params)
          Success(params.merge({ operation_name: self.operation_name, parent: self.parent }))
        end

      end
    stub_const('Dummy::Operation', dummy_klass)
  end

  context 'Initialize the instance via the .call method' do
    context 'and the operation_name is omitted' do
      it 'raises and argument error' do
        expect {Dummy::Operation.call(params)}.to raise_error ArgumentError
      end
    end

    context 'and the operation_name and params are present' do
      subject { Dummy::Operation.call(class_call_init) }

      it 'has a operation_name and parent attributes' do
        expect(subject.value![:operation_name]).to eq operation_name
        expect(subject.value![:parent]).to be_nil
      end

      it 'monad should return success and passed params' do
        expect(subject.success?).to be_truthy
        expect(subject.value![:type]).to eq params[:type]
      end
    end

  end

  context 'Initialize the instance via the #call method' do

    context 'and the operation_name is omitted' do
      it 'raises and argument error' do
        expect {Dummy::Operation.new.call(params)}.to raise_error ArgumentError
      end
    end

    context 'and the operation_name is present' do
      subject { Dummy::Operation.new(instance_new_init) }

      it 'has a operation_name and parent attributes' do
        expect(subject.operation_name).to eq operation_name
        expect(subject.parent).to be_nil
      end

      context 'and paramaters are passed to instance' do
        subject { Dummy::Operation.new(instance_new_init).call(params) }

        it 'monad should return success and passed params' do
          expect(subject.success?).to be_truthy
          expect(subject.value![:type]).to eq params[:type]
        end
      end
    end
  end
end
