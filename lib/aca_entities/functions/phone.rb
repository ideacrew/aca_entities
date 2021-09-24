# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person phone
    class Phone
      def call(cache, m_identifier = nil)
        member_identifier = m_identifier || cache.find(/attestations.members.(\w+)$/).map(&:item).last
        return [] unless cache.resolve('family.family_members.is_primary_applicant').item == member_identifier
        contact_information = cache.resolve('attestations.application.contactInformation').item

        return [] if contact_information[:primaryPhoneNumber].nil?
        primary_phone = Ffe::Transformers::Cv::Phone.transform(contact_information[:primaryPhoneNumber]&.merge!(primary: true))
        secondary_phone = Ffe::Transformers::Cv::Phone.transform(contact_information[:SecondaryPhoneNumber]&.merge!(primary: false) || [])
        [primary_phone, secondary_phone].compact
      end
    end
  end
end
