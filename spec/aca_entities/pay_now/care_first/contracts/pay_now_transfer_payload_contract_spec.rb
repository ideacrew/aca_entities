# frozen_string_literal: true

require "spec_helper"
require "aca_entities/pay_now/care_first"

RSpec.describe ::AcaEntities::PayNow::CareFirst::Contracts::PayNowTransferPayloadContract do
  let(:member_name) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff" }
  end
  let(:member) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name,
      :birth_date => "19740601",
      :sex => "M",
      :relationship => "18",
      :is_subscriber => true }
  end
  let(:member_name2) do
    { :person_surname => "Thomas",
      :person_given_name => "Paula" }
  end
  let(:member2) do
    { :exchange_assigned_member_id => "1037295",
      :member_name => member_name,
      :birth_date => "19751213",
      :sex => "F",
      :relationship => "01",
      :is_subscriber => false }
  end

  let(:primary) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name }
  end

  let(:required_params) do
    { coverage_kind: AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType.values.first,
      primary: primary,
      members: [member, member2] }
  end
  let(:optional_params) { {} }
  let(:all_params) do
    required_params.merge(optional_params)
  end
  let(:invalid_params) do
    { bad_key: "bad_val" }
  end

  context "invalid parameters" do
    context "with empty parameters" do
      it "should list error for every required parameter" do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context "valid parameters" do
    context "with required and optional parameters" do
      it "should initialize" do
        expect(described_class.new(all_params)).to be_a described_class
      end

      it "should not raise error" do
        expect { described_class.new(all_params) }.not_to raise_error
      end
    end
  end
end
