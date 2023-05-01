# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/address'
require 'aca_entities/atp/transformers/aces/phone'
require 'aca_entities/atp/transformers/aces/email'
require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/MethodLength
      class ContactBuilder

        def call(cache)
          @memoized_data = cache

          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          addresses = applicants_hash[member_id.to_sym][:addresses]
          emails = applicants_hash[member_id.to_sym][:emails]
          phones = applicants_hash[member_id.to_sym][:phones]
          @primary_applicant_id = @memoized_data.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
          @contact_method = @memoized_data.find(Regexp.new("consumer_role.contact_method.#{@primary_applicant_id}")).map(&:item).last

          @primary_address_kind = addresses.any? { |a| a[:kind] == "mailing"} ? "Mailing" : "Home"
          @primary_phone_kind = if phones.any? { |a| a[:kind] == "mobile"}
                                  "Mobile"
                                elsif phones.any? { |a| a[:kind] == "home"}
                                  "Home"
                                else
                                  "Work"
                                end
          @primary_email_kind = emails.any? { |a| a[:kind] == "home"} ? "Home" : "Work"

          address_result = addresses.each_with_object([]) do |address, collector|
            result = ::AcaEntities::Atp::Transformers::Aces::Address.transform(address)
            prefered_method = AcaEntities::Atp::Types::ContactPreferenceCode[@contact_method] == "Mail"
            result[:is_primary_indicator] = prefered_method && result[:category_code] == @primary_address_kind
            collector << result
          end

          phone_result = phones.each_with_object([]) do |phone, collector|
            next if AcaEntities::Atp::Types::ContactKinds[phone[:kind]].nil? # to rule out 'fax' and other types that arent valid contact methods
            result = ::AcaEntities::Atp::Transformers::Aces::Phone.transform(phone)
            prefered_method = AcaEntities::Atp::Types::ContactPreferenceCode[@contact_method] == "TextMessage"
            result[:is_primary_indicator] = prefered_method && result[:category_code] == @primary_phone_kind
            collector << result
          end

          email_result = emails.each_with_object([]) do |email, collector|
            result = ::AcaEntities::Atp::Transformers::Aces::Email.transform(email)
            prefered_method = AcaEntities::Atp::Types::ContactPreferenceCode[@contact_method] == "Email"
            result[:is_primary_indicator] = prefered_method && result[:category_code] == @primary_email_kind
            collector << result
          end

          [address_result, phone_result, email_result].flatten
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/MethodLength
    end
  end
end

