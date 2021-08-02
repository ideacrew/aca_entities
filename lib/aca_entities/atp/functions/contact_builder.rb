# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class ContactBuilder
        def call(cache)
          @memoized_data = cache

          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          addresses = applicants_hash[member_id.to_sym][:addresses]
          emails = applicants_hash[member_id.to_sym][:emails]
          phones = applicants_hash[member_id.to_sym][:phones]
          @primary_applicant_id = @memoized_data.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last

          contact_method = @memoized_data.find(Regexp.new("consumer_role.contact_method.#{@primary_applicant_id}")).map(&:item).last
          # person_relationship = @memoized_data.find(Regexp.new("family.family_members.#{member_id}.person.person_relationship")).map(&:item).last

          address_result = addresses.each_with_object([]) do |address, collector|
            collector << { :begin_date => nil,
                           :end_date => nil,
                           :contact =>
             { :email_id => nil,
               :mailing_address =>
               { :address =>
                 { :location_street => { :street_full_text => address[:address_1] },
                   :address_secondary_unit_text => address[:address_2],
                   :location_city_name => address[:city],
                   :location_county_name => address[:county],
                   :location_county_code => nil,
                   :location_state_us_postal_service_code => address[:state],
                   :location_postal_code => address[:zip] } },
               :telephone_number => nil },
                           :category_code => address[:kind],
                           :is_primary_indicator => contact_method == address[:kind] }
            collector
          end

          phone_result = phones.each_with_object([]) do |phone, collector|
            collector << { :begin_date => nil,
                           :end_date => nil,
                           :contact => { :email_id => nil, :mailing_address => nil,
                                         :telephone_number => { :telephone => { :telephone_number_full_id => phone[:full_phone_number], :telephone_suffix_id => nil } } },
                           :category_code => phone[:kind],
                           :is_primary_indicator => contact_method == phone[:kind] }
            collector
          end

          email_result = emails.each_with_object([]) do |email, collector|
            collector << { :begin_date => nil,
                           :end_date => nil,
                           :contact => { :email_id => email[:address], :mailing_address => nil, :telephone_number => nil },
                           :category_code => email[:kind],
                           :is_primary_indicator => contact_method == email[:kind] }
            collector
          end

          [address_result, phone_result, email_result].flatten
        end

        private

        def address_hash(address, contact_info)
          {
            kind: contact_info[:category_code].downcase,
            address_1: address[:location_street][:street_full_text],
            address_2: nil,
            address_3: nil,
            city: address[:location_city_name],
            county: address[:location_county_name],
            county_code: address[:location_county_code],
            state: address[:location_state_us_postal_service_code],
            zip: address[:location_postal_code],
            country_name: nil
          }
        end
      end
    end
  end
end

