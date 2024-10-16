# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Document do

  context "Given valid required parameters" do

    let(:contract)                { AcaEntities::BenefitMarkets::DocumentContract.new }
    let(:required_params) do
      {
        title: 'Title', creator: 'The Creator', publisher: 'The Publisher', type: 'Type',
        format: 'PDF', source: 'Source', language: 'English', subject: nil, description: nil,
        contributor: nil, date: nil, identifier: nil, relation: nil, coverage: nil, rights: nil,
        tags: nil, size: nil
      }
    end

    context "with required only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new Document instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::Document
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) do
        required_params.merge({ subject: 'Subject', description: 'Description', contributor: 'Contributor',
                                date: Date.today, identifier: 'Identifier', relation: 'Relation',
                                coverage: 'Coverage', rights: 'Rights', tags: [{}], size: 'size' })
      end

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new Document instance" do
        expect(described_class.new(all_params)).to be_a AcaEntities::BenefitMarkets::Document
        expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end
end