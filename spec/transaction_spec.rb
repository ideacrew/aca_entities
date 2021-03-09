# frozen_string_literal: true

require "../aca_entities/lib/aca_entities/transaction"

RSpec.describe ::AcaEntities::Transaction,  dbclean: :after_each do

  describe "Transaction Entity" do
    let(:input_params) do
      { :enrollment_id => "test",
        :carrier_id => "test",
        :enrollment_effective_date => Date.today }
    end

    context 'Passing invalid params' do
      context 'passing enrollment id as nil' do
        before do
          input_params.merge!({ enrollment_id: nil })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end

      context 'passing enrollment id not as string' do
        before do
          input_params.merge!({ enrollment_id: { test: "test" } })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end

      context 'passing carrier id as nil' do
        before do
          input_params.merge!({ carrier_id: nil })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end

      context 'passing carrier id not as string' do
        before do
          input_params.merge!({ carrier_id: { test: "test" } })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end

      context 'passing effective date as nil' do
        before do
          input_params.merge!({ enrollment_effective_date: nil })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end

      context 'passing enrollment date not as date' do
        before do
          input_params.merge!({ enrollment_effective_date: { test: "test" } })
        end

        it 'should raise an error' do
          expect { ::AcaEntities::Transaction.new(input_params) }.to raise_error
        end
      end
    end

    context 'Passing valid params' do
      it 'should initialize' do
        result = ::AcaEntities::Transaction.new(input_params)
        expect(result).to be_a ::AcaEntities::Transaction
      end

      it 'should not raise error' do
        expect { ::AcaEntities::Transaction.new(input_params) }.not_to raise_error
      end
    end
  end
end
