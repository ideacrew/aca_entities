# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Vlp::H92::Operations::PersonToInitialRequest do
  let(:person_params) do
    {
      :hbx_id => "a7619992755141bea940230b3a0a97d4",
      :person_name => {
        :first_name => "vlp",
        :middle_name => nil,
        :last_name => "first",
        :name_sfx => nil,
        :name_pfx => nil,
        :full_name => "vlp first",
        :alternate_name => nil
      },
      :person_demographics => {
        :ssn => "368748379",
        :no_ssn => false,
        :gender => "male",
        :dob => Date.new(1990, 10, 10),
        :date_of_death => nil,
        :dob_check => false,
        :is_incarcerated => false,
        :ethnicity => ["", "", "", "", "Other", "", "", "", "Cuban"],
        :race => nil, :tribal_id => nil, :language_code => "en"
      },
      :person_health => {
        :is_tobacco_user => "unknown",
        :is_physically_disabled => nil
      },
      :no_dc_address => false,
      :no_dc_address_reason => nil,
      :is_homeless => false,
      :is_temporarily_out_of_state => false,
      :age_off_excluded => false,
      :is_applying_for_assistance => false,
      :is_active => true,
      :is_disabled => nil,
      :person_relationships => [],
      :consumer_role => {
        :five_year_bar => false,
        :requested_coverage_start_date => Date.today,
        :aasm_state => "unverified",
        :is_applicant => true,
        :birth_location => nil,
        :marital_status => nil,
        :is_active => true,
        :is_applying_coverage => true,
        :bookmark_url => "bookmark_url",
        :admin_bookmark_url => "admin_bookmark_url",
        :contact_method => "Paper and Electronic communications",
        :language_preference => "English",
        :is_state_resident => nil,
        :identity_validation => "valid",
        :identity_update_reason => "Verified from Experian",
        :application_validation => "valid",
        :application_update_reason => "Verified from Experian",
        :identity_rejected => false,
        :application_rejected => false,
        :vlp_documents => [
          {
            :title => "untitled",
            :creator => "dchl",
            :subject => "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
            :description => nil,
            :publisher => "dchl",
            :contributor => nil,
            :date => nil,
            :type => "text",
            :format => "application/octet-stream",
            :identifier => nil,
            :source => "enroll_system",
            :language => "en",
            :relation => nil,
            :coverage => nil,
            :rights => nil,
            :tags => [],
            :size => nil,
            :doc_identifier => nil,
            :alien_number => "123987645",
            :i94_number => nil,
            :visa_number => "97568368",
            :passport_number => "L2257123",
            :sevis_id => nil,
            :naturalization_number => nil,
            :receipt_number => nil,
            :citizenship_number => nil,
            :card_number => nil,
            :country_of_citizenship => "India",
            :expiration_date => nil,
            :issuing_country => nil
          }
        ],
        :lawful_presence_determination => {
          :vlp_verified_at => nil,
          :vlp_authority => nil,
          :vlp_document_id => nil,
          :citizen_status => "alien_lawfully_present",
          :citizenship_result => nil,
          :qualified_non_citizenship_result => nil,
          :aasm_state => "verification_pending"
        }
      },
      :resident_role => nil,
      :individual_market_transitions => [],
      :verification_types => [],
      :broker_role => nil,
      :user => {},
      :addresses => [
        {
          :has_fixed_address => true,
          :kind => "home",
          :address_1 => "test",
          :address_2 => "test",
          :address_3 => "",
          :city => "test",
          :county => "",
          :state => "DC",
          :zip => "01101",
          :country_name => "United States of America"
        }
      ],
      :emails => [],
      :phones => [
        {
          :kind => "home",
          :country_code => "",
          :area_code => "763",
          :number => "8478634",
          :extension => "",
          :primary => nil,
          :full_phone_number => "7638478634"
        }
      ],
      :documents => [],
      :timestamp => {
        :created_at => DateTime.now,
        :modified_at => DateTime.now
      }
    }
  end

  let(:person_entity) { AcaEntities::People::Person.new(person_params)}

  before do
    @result = subject.call(person_entity)
    @request = @result.success
  end

  it 'converts person into vlp initial request with nil expiration_date' do
    expect(@result).to be_success
    expect(@request.is_a?(AcaEntities::Fdsh::Vlp::H92::InitialVerificationRequest)).to be_truthy
  end
end
