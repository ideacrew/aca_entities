# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/qualifying_life_event_kind_contract'

RSpec.describe AcaEntities::Contracts::QualifyingLifeEventKindContract, type: :model, dbclean: :after_each do
  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:contract_params) do
    { :start_on => Date.today,
      :end_on => Date.today.next_month,
      :title => 'Married',
      :tool_tip => 'test tool tip',
      :pre_event_sep_in_days => '4',
      :is_self_attested => true,
      :reason => 'lost_access_to_mec',
      :post_event_sep_in_days => '7',
      :market_kind => 'individual',
      :effective_on_kinds => ['date_of_event'],
      :ordinal_position => 1,
      coverage_start_on: Date.today,
      coverage_end_on: (Date.today.next_month),
      event_kind_label: 'event kind label',
      is_visible: true,
      qle_event_date_kind: 'qle_on',
      termination_on_kinds: ['date_of_event'],
      date_options_available: true }
  end

  context 'success case' do
    before  do
      @result = subject.call(contract_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end

    it 'should set dehumanized form for reason' do
      expect(@result.to_h[:reason]).to eq('lost_access_to_mec')
    end

    context 'for end_on being optional' do
      before do
        contract_params.merge!({end_on: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for tool_tip being optional' do
      before do
        contract_params.merge!({tool_tip: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for coverage_start_on being optional' do
      before do
        contract_params.merge!({coverage_start_on: nil, coverage_end_on: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for coverage_end_on being optional' do
      before do
        contract_params.merge!({coverage_start_on: nil, coverage_end_on: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for termination_on_kinds being optional for individual' do
      before do
        contract_params.merge!({termination_on_kinds: nil})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'for termination_on_kinds being mandatory' do
      before do
        contract_params.merge!({market_kind: 'shop'})
        @result = subject.call(contract_params)
      end

      it 'should return success' do
        expect(@result.success?).to be_truthy
      end

      it 'should not have any errors' do
        expect(@result.errors.empty?).to be_truthy
      end
    end

    context 'with auditing attributes' do
      context "with create params" do
        before do
          contract_params.merge!({market_kind: 'shop', published_by: '1', updated_by: '', created_by: '1'})
          @result = subject.call(contract_params)
        end

        it 'should return success' do
          expect(@result.success?).to be_truthy
        end

        it 'should not have any errors' do
          expect(@result.errors.empty?).to be_truthy
        end

        it 'should have created by value' do
          expect(@result[:created_by]).to eq '1'
        end

        it 'should not have published_by value' do
          expect(@result[:published_by]).to eq nil
        end

        it 'should not have updated_by value' do
          expect(@result[:updated_by]).to eq nil
        end
      end
    end
  end

  context 'failure case' do

    context 'start on date is in the past' do
      before  do
        contract_params.merge!({start_on: Date.today.prev_day})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Start on must be current or future date')
      end
    end

    context 'end on date is less than start on date' do
      before  do
        contract_params.merge!({end_on: Date.today.prev_year, publish: 'Publish'})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date is after end date' do
        expect(@result.errors.messages.first.text).to eq('End on must be after start on date')
      end
    end

    context 'invalid end_on value' do
      before do
        contract_params.merge!({end_on: 'test', publish: 'Publish'})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should return error message as end_on is not a date' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end
    end

    context 'invalid coverage_start_on value' do
      before do
        contract_params.merge!({coverage_start_on: 'test'})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should return error message as end_on is not a date' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end
    end

    context 'invalid coverage_end_on value' do
      before do
        contract_params.merge!({coverage_end_on: 'test'})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should return error message as end_on is not a date' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end
    end

    context 'coverage_start_on present' do
      before  do
        contract_params.merge!({coverage_start_on: Date.today.next_day, coverage_end_on: nil})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Eligibility End Date must be filled')
      end
    end

    context 'coverage_end_on present' do
      before  do
        contract_params.merge!({coverage_end_on: Date.today.next_day, coverage_start_on: nil})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Eligibility Start Date must be filled')
      end
    end

    context 'coverage_end_on less than coverage_start_on date ' do
      before  do
        contract_params.merge!({coverage_start_on: Date.today.next_month, coverage_end_on: Date.today})
        @result = subject.call(contract_params)
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Eligibility End Date must be after Eligibility Start Date')
      end
    end
  end
end
