# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person email
    class Email
      def call(cache, m_identifier = nil)
        member_identifier = m_identifier || cache.find(/attestations.members.(\w+)$/).map(&:item).last
        return [] unless cache.resolve('family.family_members.is_primary_applicant').item == member_identifier
        contact_information = cache.resolve('attestations.application.contactInformation').item
        return [] unless contact_information[:email]
        [{ address: contact_information[:email], kind: 'home' }]
      end
    end
  end
end

