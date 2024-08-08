# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/functions/lawful_presence_determination_builder'
require "support/atp/inbound_lawful_presence_application"

RSpec.describe AcaEntities::Atp::Functions::LawfulPresenceDeterminationBuilder do
  include_context "inbound_build_application"
  let(:cache) { context }
  let(:member_id_alien_document) { "IDC1003158" }
  let(:member_id_naturalized_citizen) { "IDC1003159" }
  let(:member_id_us_citizen) { "IDC1002699" }
  let(:member_id_not_lawful) { "IDC1003160" }
  let(:subject) { described_class.new }

  describe '#call' do
    context 'when member_id is not provided' do
      it 'returns "not_lawfully_present_in_us" when no indicators are true' do
        expect(subject.call(cache)).to eq('not_lawfully_present_in_us')
      end
    end

    context 'when member_id is provided' do
      it 'returns "alien_lawfully_present" when category code on document is present' do
        expect(subject.call(cache, member_id_alien_document)).to eq('alien_lawfully_present')
      end

      it 'returns "naturalized_citizen" when naturalized citizen indicator is true' do
        expect(subject.call(cache, member_id_naturalized_citizen)).to eq('naturalized_citizen')
      end

      it 'returns "us_citizen" when us citizen indicator is true' do
        expect(subject.call(cache, member_id_us_citizen)).to eq('us_citizen')
      end

      it 'returns "not_lawfully_present_in_us" when no indicators are true' do
        expect(subject.call(cache, member_id_not_lawful)).to eq('not_lawfully_present_in_us')
      end
    end
  end
end
