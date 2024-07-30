# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'
require 'support/shared_content/families/sample_cv_family'

RSpec.describe AcaEntities::Crm::Transformers::FamilyTo::Account do
  include_context 'sample family cv'

  let(:input_params) { ::AcaEntities::Operations::CreateFamily.new.call(family_cv).success }

  let(:subject) { described_class.new }

  before do
    @result = subject.call(input_params)
  end

  context 'valid params' do
    context 'validates contract' do
      it 'passes contract validations' do
        expect(
          AcaEntities::Crm::Contracts::AccountContract.new.call(@result.success).success?
        ).to be_truthy
      end
    end

    context 'creates a valid account' do
      it 'returns account entity' do
        expect(
          AcaEntities::Crm::Operations::CreateAccount.new.call(@result.success).success
        ).to be_a(AcaEntities::Crm::Account)
      end
    end
  end

  context "valid params" do
    it "returns a success" do
      expect(@result.success?).to be_truthy
    end
  end

  context "transformed addresses" do

    it "returns transformed address 1" do
      expect(@result.success[:billing_address_street]).to eq(addresses.first[:address_1])
    end

    it "returns transformed address city" do
      expect(@result.success[:billing_address_city]).to eq(addresses.first[:city])
    end

    it "returns transformed address state" do
      expect(@result.success[:billing_address_state]).to eq(addresses.first[:state])
    end

    it "returns transformed addresses zip code" do
      expect(@result.success[:billing_address_postalcode]).to eq(addresses.first[:zip])
    end
  end

  context "transformed phones" do
    it "returns transformed phone" do
      expect(@result.success[:phone_office]).to eq('(202) 299-1290')
    end
  end

  context "transformed emails" do

    it "returns transformed email" do
      expect(@result.success[:email1]).to eq(emails.first[:address])
    end
  end

  context "transformed ssn" do

    let(:ssn) {'123456789'}

    before do
      encrypted_ssn = AcaEntities::Operations::Encryption::Encrypt.new.call({ value: ssn })
      family_cv[:family_members].first[:person][:person_demographics].merge!({ encrypted_ssn: encrypted_ssn.success })
      @family_with_ssn = ::AcaEntities::Operations::CreateFamily.new.call(family_cv).success
    end

    it "returns transformed raw ssn" do
      result = subject.call(@family_with_ssn)
      expect(result.success[:rawssn_c]).to eq(ssn)
    end
  end

  context "Transformed Contacts" do

    let(:relationship) { family_cv[:family_members].first[:person][:person_relationships].first[:kind] }

    it 'returns Contacts' do
      expect(@result.success[:contacts].size).to eql(family_cv[:family_members].size)
    end

    it 'returns correct relationship to primary' do
      expect(@result.success[:contacts].first[:relationship_c]).to eql("Self")
    end

    it "returns a titleized relationship" do
      expect(@result.success[:contacts].last[:relationship_c]).to eql(relationship.titleize)
    end
  end
end
