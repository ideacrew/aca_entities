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
        'nc' => 'http://niem.gov/niem/niem-core/2.0',
        'hix-ee' => 'http://hix.cms.gov/0.1/hix-ee'
      }
    end

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new.call(payload)
      _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))
      expect(result.success?).to be_truthy
    end

    it 'should have an IdentificationCategoryText of AppliedForSSN if applicant applied for ssn' do
      payload_hash = JSON.parse(payload, symbolize_names: true)
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:is_ssn_applied] = true
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//nc:PersonSSNIdentification/nc:IdentificationCategoryText", namespaces)
      expect(texts.present?).to be_truthy
      expect(texts.first.content).to eq 'AppliedForSSN'
    end

    it 'should have a pregnancy end date if in post partum period' do
      payload_hash = JSON.parse(payload, symbolize_names: true)
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:pregnancy_information][:is_post_partum_period] = true
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:pregnancy_information][:pregnancy_end_on] = Date.today
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-core:PersonPregnancyStatus/hix-core:StatusValidDateRange/nc:EndDate", namespaces)
      expect(texts.present?).to be_truthy
      expect(texts&.first&.content&.strip).to eq Date.today.strftime("%F")
    end

    context 'when vlp document is present on applicant' do
      context 'naturalized citizen with Certificate of Citizenship' do
        let(:naturalized_citizen_payload) do
          payload_hash = JSON.parse(payload, symbolize_names: true)
          applicant = payload_hash[:family][:magi_medicaid_applications][:applicants].first
          applicant[:citizenship_immigration_status_information][:citizen_status] = 'naturalized_citizen'
          applicant[:vlp_document] = {}
          applicant[:vlp_document][:subject] = 'Certificate of Citizenship'
          applicant[:vlp_document][:citizenship_number] = '234567'
          payload_hash.to_json
        end

        it 'should populate LawfulPresenceDocumentPersonIdentification tags for Certificate of Citizenship' do
          result = described_class.new.call(naturalized_citizen_payload)
          doc = Nokogiri::XML.parse(result.value!)
          tags = doc.xpath("//hix-ee:LawfulPresenceDocumentPersonIdentification/nc:IdentificationCategoryText", namespaces)
          node = tags.detect {|t| t.text == 'Certificate Of Citizenship'}&.parent
          expect(node.present?).to be_truthy
          expect(node.children.detect {|c| c.name == 'IdentificationID'}.text).to eq '234567'
          expect(node.children.detect {|c| c.name == 'IdentificationCategoryText'}.text).to eq 'Certificate Of Citizenship'
        end
      end

      context 'when expiration date is nil' do
        it 'should not create and populate LawfulPresenceDocumentExpirationDate tags' do
          payload_hash = JSON.parse(payload, symbolize_names: true)
          payload_hash[:family][:magi_medicaid_applications][:applicants].first[:vlp_document][:expiration_date] = nil
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath("//hix-ee:LawfulPresenceDocumentExpirationDate", namespaces)
          expect(texts.present?).to be_falsey
        end
      end
    end

    context "when annual_tax_household_income is a string" do
      let(:payload1) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_string_income_payload.json")) }

      it 'should parse and then transform when transform_mode set to batch' do
        result = described_class.new.call(payload1)
        _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))
        expect(result.success?).to be_truthy
      end
    end

    context 'when applicant is filing taxes' do
      it 'should include tax return tags in the payload' do
        result = described_class.new.call(payload)
        doc = Nokogiri::XML.parse(result.value!)
        texts = doc.xpath("//hix-ee:TaxReturn", namespaces)
        expect(texts.present?).to be_truthy
      end
    end

    context 'when no applicants are filing taxes' do
      let(:no_tax_filers_payload) do
        payload_hash = JSON.parse(payload)
        payload_hash['family']['magi_medicaid_applications']['applicants'].each do |applicant|
          applicant['is_required_to_file_taxes'] = false
        end
        payload_hash.to_json
      end

      it 'should not include tax return tags in the payload' do
        result = described_class.new.call(no_tax_filers_payload)
        doc = Nokogiri::XML.parse(result.value!)
        texts = doc.xpath("//hix-ee:TaxReturn", namespaces)
        expect(texts.present?).to be_falsey
      end
    end

    context 'param flags' do
      let(:payload_hash) { JSON.parse(payload) }

      context "when drop_non_ssn_apply_reason flag is present in payload" do
        it 'should not populate IdentificationCategoryText tag in PersonSSNIdentification' do
          param_flags = { 'drop_param_flags' => ['drop_non_ssn_apply_reason'] }
          flagged_payload = payload_hash.merge(param_flags).to_json
          result = described_class.new.call(flagged_payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath("//nc:PersonSSNIdentification/nc:IdentificationCategoryText", namespaces)
          expect(texts.present?).to be_falsey
        end

        it 'should not have an IdentificationCategoryText of AppliedForSSN if applicant applied for ssn' do
          payload_hash["family"]["magi_medicaid_applications"]["applicants"].first["is_ssn_applied"] = true
          param_flags = { 'drop_param_flags' => ['drop_non_ssn_apply_reason'] }
          flagged_payload = payload_hash.merge(param_flags).to_json
          result = described_class.new.call(flagged_payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath("//nc:PersonSSNIdentification/nc:IdentificationCategoryText", namespaces)
          expect(texts.present?).to be_falsey
        end
      end

      context 'drop_income_start_on flag present in payload' do
        it 'should not populate StartDate/Date tag in IncomeEarnedDateRange' do
          param_flags = { 'drop_param_flags' => ['drop_income_start_on'] }
          flagged_payload = payload_hash.merge(param_flags).to_json
          result = described_class.new.call(flagged_payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath('//hix-core:IncomeEarnedDateRange/nc:StartDate/nc:Date', namespaces)
          expect(texts.present?).to be_falsey
        end
      end

      context 'drop_income_end_on flag present in payload' do
        it 'should not populate EndDate/Date tag in IncomeEarnedDateRange' do
          param_flags = { 'drop_param_flags' => ['drop_income_end_on'] }
          flagged_payload = payload_hash.merge(param_flags).to_json
          result = described_class.new.call(flagged_payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath('//hix-core:IncomeEarnedDateRange/nc:EndDate/nc:Date', namespaces)
          expect(texts.present?).to be_falsey
        end
      end

      context 'drop_vlp_document flag present in payload' do
        it 'should not populate LawfulPresenceStatusImmigrationDocument tags' do
          param_flags = { 'drop_param_flags' => ['drop_vlp_document'] }
          flagged_payload = payload_hash.merge(param_flags).to_json
          result = described_class.new.call(flagged_payload)
          doc = Nokogiri::XML.parse(result.value!)
          texts = doc.xpath('//hix-ee:LawfulPresenceStatusImmigrationDocument', namespaces)
          expect(texts.present?).to be_falsey
        end
      end
    end
  end
end