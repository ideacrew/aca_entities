# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/address'
require 'aca_entities/atp/transformers/aces/phone'
require 'aca_entities/atp/transformers/aces/email'
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
          @contact_method = @memoized_data.find(Regexp.new("consumer_role.contact_method.#{@primary_applicant_id}")).map(&:item).last

          address_result = addresses.each_with_object([]) do |address, collector|
            collector << ::AcaEntities::Atp::Transformers::Aces::Address.transform(address)
            collector
          end

          phone_result = phones.each_with_object([]) do |phone, collector|
            next if ContactKinds[phone[:kind]].nil?
            collector << ::AcaEntities::Atp::Transformers::Aces::Phone.transform(phone)
            collector
          end

          email_result = emails.each_with_object([]) do |email, collector|
            collector << ::AcaEntities::Atp::Transformers::Aces::Email.transform(email)
            collector
          end

          [address_result, phone_result, email_result].flatten
        end
      end
    end
  end
end

