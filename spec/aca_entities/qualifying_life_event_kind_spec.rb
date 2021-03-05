# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/qualifying_life_event_kind'

RSpec.describe ::AcaEntities::QualifyingLifeEventKind, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { :start_on => Date.today,
        :end_on => Date.today.next_month,
        :title => 'A new SEP Type',
        :tool_tip => 'test tool tip',
        :pre_event_sep_in_days => 4,
        :is_self_attested => true,
        :reason => 'lost_access_to_mec',
        :post_event_sep_in_days => 7,
        :market_kind => 'individual',
        :effective_on_kinds => ['date_of_event'],
        :ordinal_position => 1,
        coverage_effective_on: Date.today,
        coverage_start_on: Date.today,
        coverage_end_on: Date.today.next_month,
        event_kind_label: 'event kind label',
        qle_event_date_kind: 'qle_on',
        is_visible: true,
        termination_on_kinds: [],
        updated_by: '',
        published_by: '',
        created_by: '',
        date_options_available: true }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end

    context 'for end_on as optional' do
      before do
        input_params.merge!({ end_on: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for end_on as optional' do
      before do
        input_params.merge!({ end_on: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for updated_by as optional' do
      before do
        input_params.merge!({ updated_by: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for published_by as optional' do
      before do
        input_params.merge!({ published_by: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for created_by as optional' do
      before do
        input_params.merge!({ created_by: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for tool_tip as optional' do
      before do
        input_params.merge!({ tool_tip: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for coverage_start_on as optional' do
      before do
        input_params.merge!({ coverage_start_on: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for coverage_end_on as optional' do
      before do
        input_params.merge!({ coverage_end_on: nil })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end

    context 'for termination_on_kinds as empty' do
      before do
        input_params.merge!({ termination_on_kinds: [] })
        @result = described_class.new(input_params)
      end

      it 'should initialize the entity' do
        expect(@result).to be_a described_class
      end
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:start_on is missing in Hash input/)
    end
  end
end
