# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'

RSpec.describe AcaEntities::Atp::Operations::Aces::GenerateXml  do
  describe 'When a valid json file is passed' do

    let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_cv_payload.json")) }
    let(:payload_hash) { JSON.parse(payload, symbolize_names: true) }
    let(:namespaces) do
      {
        'hix-core' => 'http://hix.cms.gov/0.1/hix-core',
        'nc' => 'http://niem.gov/niem/niem-core/2.0',
        'hix-ee' => 'http://hix.cms.gov/0.1/hix-ee',
        'niem-s' => 'http://niem.gov/niem/structures/2.0'
      }
    end

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new.call(payload)
      _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))
      expect(result.success?).to be_truthy
    end

    it 'should have an IdentificationCategoryText of AppliedForSSN if applicant applied for ssn' do
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:is_ssn_applied] = true
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//nc:PersonSSNIdentification/nc:IdentificationCategoryText", namespaces)
      expect(texts.present?).to be_truthy
      expect(texts.first.content).to eq 'AppliedForSSN'
    end

    it 'should have a pregnancy end date if in post partum period' do
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:pregnancy_information][:is_post_partum_period] = true
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:pregnancy_information][:pregnancy_end_on] = Date.today
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-core:PersonPregnancyStatus/hix-core:StatusValidDateRange/nc:EndDate", namespaces)
      expect(texts.present?).to be_truthy
      expect(texts&.first&.content&.strip).to eq Date.today.strftime("%F")
    end

    it 'should not include LocationStateUSPostalServiceCode within tribal augmentation if the tribal state is a blank string' do
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:native_american_information][:tribal_state] = " "
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-core:TribalAugmentation/nc:LocationStateUSPostalServiceCode", namespaces)
      expect(texts.present?).not_to be_truthy
    end

    it 'should include policy details within InsuranceApplicantNonEsiPolicy if exists' do
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-ee:InsuranceApplicantNonESIPolicy//hix-ee:InsurancePolicyAppliedEffectiveDateRange//nc:StartDate//nc:Date", namespaces)
      expect(texts&.first&.content&.strip).to eq "2021-01-01"
    end

    it 'should include planned_coverage_date_ranges within InsuranceApplicantESIAssociation if exists' do
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-ee:InsuranceApplicantESIPlannedCoverageDateRange//nc:StartDate//nc:Date", namespaces)
      expect(texts&.first&.content&.strip).to eq "2022-02-02"
    end

    it 'should have the temporarily_lives_outside_application_state_indicator tag mapped' do
      payload_hash[:family][:magi_medicaid_applications][:applicants].first[:is_temporarily_out_of_state] = true
      result = described_class.new.call(payload_hash.to_json)
      doc = Nokogiri::XML.parse(result.value!)
      texts = doc.xpath("//hix-ee:InsuranceApplicantTemporarilyLivesOutsideApplicationStateIndicator", namespaces)
      expect(texts&.first&.content&.strip).to eq "true"
    end

    context 'when person has contact with unmappable kind' do
      it 'should not include PersonContactInformationAssociation tags for that kind' do
        payload_hash[:family][:family_members].first[:person][:phones].first[:kind] = "fax"
        result = described_class.new.call(payload_hash.to_json)
        doc = Nokogiri::XML.parse(result.value!)
        texts = doc.xpath("//hix-core:PersonContactInformationAssociation/hix-core:ContactInformationCategoryCode", namespaces).text
        expect(texts.include?('fax')).not_to be_truthy
      end
    end

    context 'when vlp document is present on applicant' do
      context 'when applicant is US citizen (not naturalized)' do
        it 'should not include LawfulPresenceStatusImmigrationDocument tags' do
          result = described_class.new.call(payload)
          doc = Nokogiri::XML.parse(result.value!)
          tags = doc.xpath("//hix-ee:LawfulPresenceStatusImmigrationDocument", namespaces)
          expect(tags.present?).to be_falsey
        end
      end

      context 'naturalized citizen with Naturalization Certificate' do
        let(:naturalized_citizen_payload) do
          applicant = payload_hash[:family][:magi_medicaid_applications][:applicants].first
          applicant[:citizenship_immigration_status_information][:citizen_status] = 'naturalized_citizen'
          applicant[:vlp_document] = {}
          applicant[:vlp_document][:subject] = 'Naturalization Certificate'
          applicant[:vlp_document][:naturalization_number] = '234567'
          applicant[:vlp_document][:alien_number] = '987654321'
          payload_hash.to_json
        end

        before do
          result = described_class.new.call(naturalized_citizen_payload)
          doc = Nokogiri::XML.parse(result.value!)
          @tags = doc.xpath("//hix-ee:LawfulPresenceDocumentPersonIdentification/nc:IdentificationCategoryText", namespaces)
        end

        it 'should populate LawfulPresenceDocumentPersonIdentification tags for Naturalization Certificate Number' do
          node = @tags.detect {|t| t.text == 'Naturalization Certificate Number'}&.parent
          expect(node.present?).to be_truthy
          expect(node.children.detect {|c| c.name == 'IdentificationID'}.text).to eq '234567'
          expect(node.children.detect {|c| c.name == 'IdentificationCategoryText'}.text).to eq 'Naturalization Certificate Number'
        end

        it 'should populate LawfulPresenceDocumentPersonIdentification tags for Alien Number' do
          node = @tags.detect {|t| t.text == 'Alien Number'}&.parent
          expect(node.present?).to be_truthy
          expect(node.children.detect {|c| c.name == 'IdentificationID'}.text).to eq '987654321'
          expect(node.children.detect {|c| c.name == 'IdentificationCategoryText'}.text).to eq 'Alien Number'
        end
      end

      context 'naturalized citizen with Certificate of Citizenship' do
        let(:naturalized_citizen_payload) do
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
        payload_hash = JSON.parse(payload, symbolize_names: true)
        payload_hash[:family][:magi_medicaid_applications][:applicants].each do |applicant|
          applicant[:is_required_to_file_taxes] = false
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

    context 'family relationships' do
      context 'when grandparent/grandchild relationship exists' do
        let(:grandparent_grandchild_payload) do
          File.read('spec/support/atp/sample_payloads/grandparent_grandchild_payload.json')
        end

        it 'should not include tax return tags in the payload' do
          result = described_class.new.call(grandparent_grandchild_payload)
          doc = Nokogiri::XML.parse(result.value!)
          person_associations = doc.xpath('//hix-core:Person/hix-core:PersonAugmentation/hix-core:PersonAssociation', namespaces)
          grandparent_rel_code = person_associations.xpath('//hix-core:FamilyRelationshipCode', namespaces).first.text
          grandchild_rel_code = person_associations.xpath('//hix-core:FamilyRelationshipCode', namespaces).last.text
          expect(grandchild_rel_code).to eq '05'
          expect(grandparent_rel_code).to eq '04'
        end
      end
    end

    context "when contact_method" do
      let(:payload_hash) { JSON.parse(payload, symbolize_names: true) }
      let(:result) { described_class.new.call(payload_hash.to_json) }

      context 'is mapped correctly' do
        it "should return success" do
          expect(result.success?).to be_truthy
        end
      end

      context "is not recognized" do
        before do
          payload_hash[:family][:family_members].first[:person][:consumer_role][:contact_method] = "mail"
        end

        it "should return failure" do
          expect(result.failure?).to be_truthy
        end
      end

      context "is mail" do
        before do
          payload_hash[:family][:family_members].first[:person][:consumer_role][:contact_method] = "Only Paper communication"
        end

        context "when there is a mailing and home address" do
          it "should mark the mailing address with the primary indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 1nd & 2nd PersonContactInformationAssociation nodes are addresses
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[1]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end

        context "when there is only a home address" do
          before do
            home_address = payload_hash[:family][:magi_medicaid_applications][:applicants].first[:addresses].first
            payload_hash[:family][:magi_medicaid_applications][:applicants].first[:addresses] = [home_address]
          end

          it "should mark the home address with the primary indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 1nd & 2nd PersonContactInformationAssociation nodes are addresses
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[0]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end
      end

      context "is text message" do
        before do
          payload_hash[:family][:family_members].first[:person][:consumer_role][:contact_method] = "Only Text Message communication"
        end

        context "when there is multiple phone numbers" do
          it "should mark the phone number set as mobile with is_primary_indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 2nd & 3rd PersonContactInformationAssociation nodes are phone #s
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[3]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end

        context "when there is only a home phone number" do
          it "should mark the home phone number with is_primary_indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 2nd & 3rd PersonContactInformationAssociation nodes are phone #s
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[3]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end
      end

      context "is email" do
        before do
          payload_hash[:family][:family_members].first[:person][:consumer_role][:contact_method] = "Only Electronic communications"
        end

        context "when there is multiple email addresses" do
          it "should mark the home email with is_primary_indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 4th & 5th PersonContactInformationAssociation nodes are emails
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[4]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end

        context "when there is only a work email address" do
          before do
            work_email = payload_hash[:family][:magi_medicaid_applications][:applicants].first[:emails].last
            payload_hash[:family][:magi_medicaid_applications][:applicants].first[:emails] = [work_email]
          end
          it "should mark the work email with is_primary_indicator" do
            doc = Nokogiri::XML.parse(result.value!)
            # 4th & 5th PersonContactInformationAssociation nodes are emails
            contact_info = doc.xpath("//hix-core:PersonContactInformationAssociation", namespaces)[4]
            is_primary_indicator = contact_info.xpath("./nc:ContactInformationIsPrimaryIndicator", namespaces).text
            expect(is_primary_indicator).to eq "true"
          end
        end
      end

    end

    context "verification metadata" do
      context "when ssa_response exists for one person" do
        it "should set verification metadata" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.present?).to be_truthy
          expect(verification_metadata.attributes["id"].value).to eq "vmssa1003159"
        end

        it "should populate FFEVerificationCode to Y" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.xpath("//hix-core:FFEVerificationCode", namespaces).text).to eq "Y"
        end

        it "should populate VerificationAuthorityTDS-FEPS-AlphaCode to SSA" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.xpath("//hix-core:VerificationAuthorityTDS-FEPS-AlphaCode", namespaces)[1].text).to eq "SSA"
        end

        it "should populate VerificationRequestingSystem" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.xpath("//hix-core:VerificationRequestingSystem", namespaces).text).to be_present
        end

        it "should populate VerificationDate" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.xpath("//hix-core:VerificationDate", namespaces).text).to be_present
        end

        it "should populate VerificationCategoryCode" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          expect(verification_metadata.xpath("//hix-core:VerificationCategoryCode", namespaces).count).to eq 4
        end

        it "should populate VerificationStatusCode" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[1]
          status = verification_metadata.xpath("//hix-core:VerificationStatus", namespaces)
          expect(status.xpath('./hix-core:VerificationStatusCode', namespaces)[0].text).to eq "5"
        end
      end

      context "when vlp_response exists" do
        it "should set verification metadata" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)
          expect(verification_metadata.count).to eq 3
          expect(verification_metadata[0].attributes["id"].value).to eq "vmdhs1002699"
          expect(verification_metadata[2].attributes["id"].value).to eq "vmdhs1003159"
        end

        it "should populate DHS-SAVEVerificationCode to Y" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:DHS-SAVEVerificationCode", namespaces)[0].text).to eq "1"
          expect(verification_metadata.xpath("//hix-core:DHS-SAVEVerificationCode", namespaces)[1].text).to eq "1"
        end

        it "should populate VerificationAuthorityTDS-FEPS-AlphaCode to DHS" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:VerificationAuthorityTDS-FEPS-AlphaCode", namespaces)[0].text).to eq "DHS"
        end

        it "should populate VerificationRequestingSystem" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:VerificationRequestingSystem", namespaces).text).to be_present
        end

        it "should populate VerificationDate" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:VerificationDate", namespaces).text).to be_present
        end

        it "should populate VerificationCategoryCode" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:VerificationCategoryCode", namespaces)[0].text).to eq "EligibleImmigrationStatus"
        end

        it "should populate VerificationStatusCode" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          status = verification_metadata.xpath("//hix-core:VerificationStatus", namespaces)
          expect(status.xpath('./hix-core:VerificationStatusCode', namespaces)[0].text).to eq "5"
        end

        it "should populate dhs save verification supplement" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:DHS-SAVEVerificationSupplement", namespaces).count).to eq 2
        end

        it "should populate StepID in dhs save verification supplement" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:StepID", namespaces)[0].text).to eq "1"
        end

        it "should populate LawfulPresenceVerificationCode in dhs save verification supplement if present" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:LawfulPresenceVerificationCode", namespaces)[0].text).to eq "Y"
          expect(verification_metadata.xpath("//hix-core:LawfulPresenceVerificationCode", namespaces)[1].text).to eq "P"
        end

        it "should populate QualifiedNonCitizenVerificationCode in dhs save verification supplement if present" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:QualifiedNonCitizenVerificationCode", namespaces)[0].text).to eq "Y"
        end

        it "should populate FiveYearBarMetVerificationCode in dhs save verification supplement if present" do
          result = described_class.new.call(payload_hash.to_json)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.xpath("//hix-core:FiveYearBarMetVerificationCode", namespaces)[0].text).to eq "Y"
        end
      end

      context "when no valid ssa_response exists for the person" do
        let(:invalid_ssa_response_payload) do
          person_1 = payload_hash[:family][:family_members][0][:person][:consumer_role][:lawful_presence_determination]
          person_2 = payload_hash[:family][:family_members][1][:person][:consumer_role][:lawful_presence_determination]
          person_3 = payload_hash[:family][:family_members][2][:person][:consumer_role][:lawful_presence_determination]
          person_1[:ssa_responses] = [{
            received_at: "2024-06-20T18:48:28.368+00:00",
            body: "{\"ResponseMetadata\":{\"ResponseCode\":\"HX005001\",
\"ResponseDescriptionText\":\"Unexpected Exception Occurred at Trusted Data Source\",\"TDSResponseDescriptionText\":null},
\"SSACompositeIndividualResponses\":[{\"ResponseMetadata\":{\"ResponseCode\":\"HX005001\",
\"ResponseDescriptionText\":\"Unexpected Exception Occurred at Trusted Data Source\",
\"TDSResponseDescriptionText\":null},\"PersonSSNIdentification\":\"123456789\",\"SSAResponse\":null}]}"
          }]
          person_2[:ssa_responses] = []
          person_3[:ssa_responses] = []
          payload_hash.to_json
        end

        it "should not set verification metadata" do
          result = described_class.new.call(invalid_ssa_response_payload)
          doc = Nokogiri::XML.parse(result.value!)
          verification_metadata = doc.xpath("//hix-core:VerificationMetadata", namespaces)[0]
          expect(verification_metadata.present?).to be_falsey
        end
      end
    end

    context 'param flags' do
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
          payload_hash[:family][:magi_medicaid_applications][:applicants].first["is_ssn_applied"] = true
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

      context 'family flags' do
        context 'invert_person_association flag present in family hash' do
          let(:family) { payload_hash[:family] }
          let(:person_id) { family[:magi_medicaid_applications][:applicants].first[:person_hbx_id] }
          let(:relative_id) { family[:magi_medicaid_applications][:applicants].first[:mitc_relationships].first[:other_id] }
          let(:relationship_kind) do
            family[:family_members].first[:person][:person_relationships].detect {|rel| rel[:relative][:hbx_id] == relative_id}[:kind]
          end
          let(:faa_mitc_relationship_map) do
            {
              'spouse' => :husband_or_wife,
              'domestic_partner' => :domestic_partner,
              'child' => :son_or_daughter,
              'parent' => :parent,
              'sibling' => :brother_or_sister,
              'aunt_or_uncle' => :aunt_or_uncle,
              'nephew_or_niece' => :nephew_or_niece,
              'grandchild' => :grandchild,
              'grandparent' => :grandparent,
              'parents_domestic_partner' => :parents_domestic_partner,
              'domestic_partners_child' => :domestic_partners_child,
              'father_or_mother_in_law' => :mother_in_law_or_father_in_law,
              'daughter_or_son_in_law' => :son_in_law_or_daughter_in_law,
              'brother_or_sister_in_law' => :brother_in_law_or_sister_in_law,
              'cousin' => :first_cousin
            }.freeze
          end

          before do
            param_flags = { 'family_flags' => { 'invert_person_association' => true } }
            flagged_family = payload_hash[:family].merge(param_flags)
            payload_hash['family'] = flagged_family
            result = described_class.new.call(payload_hash.to_json)
            doc = Nokogiri::XML.parse(result.value!)
            @person_ref = doc.xpath('//hix-core:Person/@niem-s:id', namespaces).first.value
            person_associations = doc.xpath('//hix-core:Person/hix-core:PersonAugmentation/hix-core:PersonAssociation', namespaces)
            @relative_ref = person_associations.xpath('//nc:PersonReference/@niem-s:ref', namespaces).first.value
            relationship_code = person_associations.xpath('//hix-core:FamilyRelationshipCode', namespaces).first.text
            relationship_text = AcaEntities::Types::RelationshipToTaxFilerCodeMap[relationship_code.to_sym]
            relationship_symbol = AcaEntities::Atp::Functions::BuildOutboundRelationship::RelationshipCodeMap.invert[relationship_text]
            @relationship_kind = faa_mitc_relationship_map.invert[relationship_symbol]
          end

          it 'should represent the relationship of PersonReference tag to Person tag' do
            expect(@person_ref).to eq("pe#{person_id}")
            expect(@relative_ref).to eq("pe#{relative_id}")
            expect(@relationship_kind).to eq(relationship_kind)
          end

          context 'when primary and spouse applicants are both filing taxes' do
            let(:spouse_filer_paylaod) { File.read('spec/support/atp/sample_payloads/spouse_th.json') }
            let(:payload_hash) { JSON.parse(spouse_filer_paylaod, symbolize_names: true) }
            before do
              param_flags = { 'family_flags' => { 'invert_person_association' => true } }
              flagged_family = payload_hash[:family].merge(param_flags)
              payload_hash['family'] = flagged_family
            end

            it 'should include SpouseTaxFiler tags in the payload' do
              result = described_class.new.call(payload_hash.to_json)
              doc = Nokogiri::XML.parse(result.value!)
              texts = doc.xpath("//hix-ee:TaxReturn/hix-ee:TaxHousehold/hix-ee:SpouseTaxFiler", namespaces)
              expect(texts.present?).to be_truthy
            end
          end
        end
      end
    end
  end
end