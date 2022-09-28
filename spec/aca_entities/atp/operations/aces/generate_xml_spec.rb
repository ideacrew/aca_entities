# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'

RSpec.describe AcaEntities::Atp::Operations::Aces::GenerateXml  do
  describe 'When a valid json file is passed' do

    let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_cv_payload.json")) }
    let(:namespaces) do
      {
        'hix-core' => 'http://hix.cms.gov/0.1/hix-core',
        "nc" => "http://niem.gov/niem/niem-core/2.0"
      }
    end

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new.call(payload)
      _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))

      expect(result.success?).to be_truthy
    end

    context "when annual_tax_household_income is a string" do
      let(:payload1) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_string_income_payload.json")) }

      it 'should parse and then transform when transform_mode set to batch' do
        result = described_class.new.call(payload1)
        _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))
        expect(result.success?).to be_truthy
      end
    end

    context "when non_ssn_apply_reason is present on applicant" do
      it 'should populate IdentificationCategoryText tag in PersonSSNIdentification' do
        result = described_class.new.call(payload)
        doc = Nokogiri::XML.parse(result.value!)
        texts = doc.xpath("//nc:PersonSSNIdentification/nc:IdentificationCategoryText", namespaces)
        expect(texts.present?).to be_truthy
        expect(texts.first.text).to eq 'NoGoodCause'
      end
    end

    context 'applicant income' do
      context 'income start date present' do
        it 'should populate StartDate/Date tag in IncomeEarnedDateRange' do
          result = described_class.new.call(payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath('//hix-core:IncomeEarnedDateRange/nc:StartDate/nc:Date', namespaces)
          expect(texts.present?).to be_truthy
          expect(texts.first.text).to eq '2021-01-01'
        end
      end

      context 'income end date present' do
        it 'should populate EndDate/Date tag in IncomeEarnedDateRange' do
          result = described_class.new.call(payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath('//hix-core:IncomeEarnedDateRange/nc:EndDate/nc:Date', namespaces)
          expect(texts.present?).to be_truthy
          expect(texts.first.text).to eq '2021-12-31'
        end
      end
    end
  end
end