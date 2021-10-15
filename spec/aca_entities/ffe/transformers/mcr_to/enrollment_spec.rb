# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ffe/transformers/mcr_to/enrollment'

RSpec.describe AcaEntities::FFE::Transformers::McrTo::Enrollment do
  describe 'When a valid json file passed' do

    let(:source_file) { Pathname.pwd.join("spec/support/transform_example_payloads/enrollment.json") }

    it 'should parse and then transform when transform_mode set to batch' do
      AcaEntities::FFE::Transformers::McrTo::Enrollment.call(source_file, { transform_mode: :batch }) do |payload|
        record = AcaEntities::FFE::Transformers::McrTo::Enrollment.transform(payload)
        record_with_string_keys = JSON.parse(record.to_json).except("timestamp")

        example_output_hash = JSON.parse(File.read(Pathname.pwd.join("spec/support/transform_example_payloads/enrollment_transform_result.json")))
        expect(record_with_string_keys).to match(example_output_hash)

        expect(record).to have_key(:external_id)
        expect(record).to have_key(:effective_on)
        expect(record).to have_key(:market_place_kind)
        expect(record).to have_key(:enrollment_period_kind)
        expect(record).to have_key(:product_kind)
        expect(record).to have_key(:product_reference)
        expect(record).to have_key(:issuer_profile_reference)
        expect(record).to have_key(:hbx_enrollment_members)
        expect(record[:hbx_enrollment_members].one? { |mem| mem[:is_subscriber] == true }).to be_truthy
      end
    end

    it 'should transform the payload according to instructions' do
      AcaEntities::FFE::Transformers::McrTo::Enrollment.call(source_file) do |record|
        expect(record).to have_key(:external_id)
        expect(record).to have_key(:effective_on)
        expect(record).to have_key(:market_place_kind)
        expect(record).to have_key(:enrollment_period_kind)
        expect(record).to have_key(:product_kind)
        expect(record).to have_key(:product_reference)
        expect(record).to have_key(:issuer_profile_reference)
        expect(record).to have_key(:hbx_enrollment_members)
        expect(record[:hbx_enrollment_members].one? { |mem| mem[:is_subscriber] == true }).to be_truthy
      end
    end
  end
end
