# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature'
require 'aca_entities/medicaid/atp/authorized_representative_reference'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require "aca_entities/medicaid/atp/ssf_signer_authorized_representative_association"
require 'aca_entities/medicaid/atp/ssf_attestation'
require 'aca_entities/medicaid/atp/ssf_signer'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfSigner, dbclean: :after_each do

  describe 'with valid arguments' do

    let(:required_params) { {role_reference: { ref: "a-person-id" } } }

    let(:optional_params) do
      { signature: signature,
        ssf_attestation: ssf_attestation,
        ssf_signer_authorized_representative_association: {
          signature: signature,
          authorized_representative_reference: { ref: "another-person-id" }
        }
      }
    end

    let(:ssf_attestation) do 
      {
        non_perjury_indicator: true,
        not_incarcerated_indicators: [{metadata: nil, value: true}],
        information_changes_indicator: false
      }
    end

    let(:signature) do
      {
        date_time: {date: DateTime.now.to_date}
      }
    end
    
    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end