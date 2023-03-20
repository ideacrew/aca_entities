# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::CompositeOperation do

  let(:operation_name) { :close_file }
  let(:operation) { { operation_name: operation_name } }
  let(:params) { { type: 'blue', name: 'fred'} }
  let(:instance_new_init) { { operation: operation } }
  let(:class_call_init) {  params.merge(instance_new_init) }

  before do
    dummy_klass =
      Class.new do
        send(:include, Dry::Monads[:result, :do])
        send(:include, ::AcaEntities::Operations::CompositeOperation)

        def call(params)
          Success(params.merge({operation_name: self.operation_name, parent: self.parent}))
        end

      end
    stub_const('Dummy::CompositeOperation', dummy_klass)
  end

  context 'Initialize the instance via the .call method' do
    context 'and the operation_name is omitted' do
      it 'raises and argument error' do
        expect{Dummy::CompositeOperation.call(params)}.to raise_error ArgumentError
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
        expect{Dummy::CompositeOperation.new.call(params)}.to raise_error ArgumentError
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

  context 'Creating complex operations' do 

    let(:sub_operation_name) { :sub_close_file }

    let(:sub_class_new_init) { { operation: { operation_name: sub_operation_name } }}

    before do
      simple_klass =
        Class.new do
          send(:include, Dry::Monads[:result, :do])
          send(:include, ::AcaEntities::Operations::Operation)

          def call(params)
            Success(params.merge({operation_name: self.operation_name, parent: self.parent}))
          end

        end
      stub_const('Dummy::SimpleOperation', simple_klass)

      dummy_klass =
        Class.new do
          send(:include, Dry::Monads[:result, :do])
          send(:include, ::AcaEntities::Operations::CompositeOperation)

          def initialize(args)
            super(args)
            self.add_sub_operation(Dummy::SimpleOperation.new({ operation: { operation_name: :sub_operation_name } }))
          end

          def call(params)
            Success(params.merge({operation_name: self.operation_name, parent: self.parent}))
          end
  
        end
      stub_const('Dummy::ComplexOperation', dummy_klass)
    end
  
    let(:sub_complex) { Dummy::ComplexOperation } 

    context 'Given sub_operations' do 
      subject { Dummy::ComplexOperation.call(class_call_init) }

      it 'monad should return success and passed params' do
        expect(subject.success?).to be_truthy
        expect(subject.value![:type]).to eq params[:type]
      end
  end

  end


  # class CompositeTask < Task
#   def initialize(name)
#     super(name)
#     @sub_tasks = []
#   end

#   def add_sub_task(task)
#     @sub_tasks << task
#     task.parent = self
#   end

#   def remove_sub_task(task)
#     @sub_tasks.delete(task)
#     task.parent = nil
#   end

#   def get_time_required
#     @sub_tasks.inject(0.0) {|time, task| time += task.get_time_required}
#   end
# end

#   it 'has an id attribute with _id value' do
#     expect(subject.id).not_to be_nil
#     expect(subject.to_hash[:id]).not_to be_nil
#     expect(subject.id).to eq subject.to_hash[:id]
#   end

#   it 'validates attributes using a corresponding AcaEntities validation contract if it exists' do
#     expect(described_class.validation_contract_class_name).not_to be_nil
#     expect(subject.validate_domain_attributes.to_h[:errors]).to be_empty if described_class.validation_contract_class
#   end

#   it 'returns records from associated collections' do
#     subject = described_class.new(valid_params)
#     expect(subject.save).to be_truthy
#     expect(subject.to_deep_hash).not_to be_nil
#   end

end