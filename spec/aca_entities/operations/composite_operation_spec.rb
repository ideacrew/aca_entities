# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::CompositeOperation do
  let(:operation_name) { :close_file }
  let(:operation) { { operation_name: operation_name } }
  let(:params) { { type: 'blue', name: 'fred' } }
  let(:instance_new_init) { { operation: operation } }
  let(:class_call_init) { params.merge(instance_new_init) }

  before do
    dummy_klass =
      Class.new do
        send(:include, Dry::Monads[:result, :do])
        send(:include, ::AcaEntities::Operations::CompositeOperation)

        def call(params)
          Success(params.merge({ operation_name: self.operation_name, parent: self.parent }))
        end
      end
    stub_const('Dummy::CompositeOperation', dummy_klass)
  end

  context 'Initialize the instance via the .call method' do
    context 'and the operation_name is omitted' do
      it 'raises and argument error' do
        expect { Dummy::CompositeOperation.call(params) }.to raise_error ArgumentError
      end
    end

    context 'and the operation_name and params are present' do
      subject { Dummy::CompositeOperation.call(class_call_init) }

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
        expect { Dummy::CompositeOperation.new.call(params) }.to raise_error ArgumentError
      end
    end

    context 'and the operation_name is present' do
      subject { Dummy::CompositeOperation.new(instance_new_init) }

      it 'has a operation_name and parent attributes' do
        expect(subject.operation_name).to eq operation_name
        expect(subject.parent).to be_nil
      end

      context 'and paramaters are passed to instance' do
        subject { Dummy::CompositeOperation.new(instance_new_init).call(params) }

        it 'monad should return success and passed params' do
          expect(subject.success?).to be_truthy
          expect(subject.value![:type]).to eq params[:type]
        end
      end
    end
  end

  context 'Given a parent Composite Operation' do
    before do
      composite_operation_klass =
        Class.new do
          send(:include, Dry::Monads[:result, :do])
          send(:include, ::AcaEntities::Operations::CompositeOperation)

          def call(params)
            Success(params.merge({ operation_name: self.operation_name, parent: self.parent }))
          end
        end
      stub_const('Dummy::CompositeOperation', composite_operation_klass)

      operation_klass =
        Class.new do
          send(:include, Dry::Monads[:result, :do])
          send(:include, ::AcaEntities::Operations::Operation)

          def call(params)
            Success(params.merge({ operation_name: self.operation_name, parent: self.parent }))
          end
        end
      stub_const('Dummy::Operation', operation_klass)
    end

    let(:director_operation_name) { { operation_name: :process_flow_director } }

    # let(:director_operation) { Dummy::CompositeOperation.new(name: director_operation_name) }

    let(:find_or_create_operation_name) { { operation_name: :find_or_create } }
    let(:find_operation) { Dummy::Operation.new(operation: find_or_create_operation_name) }

    let(:persist_operation_name) { { operation_name: :persist } }
    let(:persist_operation) { Dummy::Operation.new(operation: persist_operation_name) }

    let(:persist_operation_name) { { operation_name: :persist } }
    let(:persist_operation) { Dummy::Operation.new(operation: persist_operation_name) }

    subject { Dummy::CompositeOperation.new(operation: director_operation_name) }

    context 'and a child operation is added ' do
      let(:non_operation_failure) { 'expected Operation || CompositeOperation, got: Hash' }
      let(:duplicate_operation_failure) { 'duplicate child operation name: :find_or_create' }

      it 'should add a child operation' do
        subject.add_child_operation(find_operation)
        expect(subject.child_operations.include?(find_operation)).to be_truthy
      end

      it 'adding a duplicate child operation name should fail' do
        subject.add_child_operation(find_operation)
        expect(subject.add_child_operation(find_operation).failure?).to be_truthy
        expect(subject.add_child_operation(find_operation).failure).to eq duplicate_operation_failure
      end

      it 'adding a non-operation class should fail' do
        expect(subject.add_child_operation({ key: 'value' }).failure?).to be_truthy
        expect(subject.add_child_operation({ key: 'value' }).failure).to eq non_operation_failure
      end

      it 'should add a child composite operation' do
        subject.add_child_operation(find_operation)
        expect(subject.child_operations.include?(find_operation)).to be_truthy
      end
    end

    context 'and a child operation is removed' do
      it 'and the child operation is present' do
        op = subject.add_child_operation(find_operation)
        expect(op.child_operation_names.include?(find_operation.operation_name))
        expect(op.drop_child_operation(find_operation).child_operation_names).to eq []
      end

      it 'and the child operation is not present' do
        expect(subject.drop_child_operation(find_operation).child_operation_names).to eq []
      end
    end
  end
end
