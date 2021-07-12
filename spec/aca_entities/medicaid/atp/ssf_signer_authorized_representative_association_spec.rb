# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/ssf_signer_authorized_representative_association'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfSignerAuthorizedRepresentativeAssociation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { signature: { signature_date: { date: DateTime.now.to_date } },
        authorized_representative_reference: { ref: "pe123" } }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:date is missing in Hash input/)
    end
  end
end
