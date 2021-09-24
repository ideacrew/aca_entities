# frozen_string_literal: true

# TODO: Pending
#  documentAlternateName - no mapping found
#  employmentAuthorizationCategoryIdentifier - no mapping found

# rubocop:disable Lint/DuplicateBranch
module AcaEntities
  module Functions
    # Builder for VLP documents
    class BuildVlpDocument

      def call(input, m_identifier = nil)
        member = input.find(/attestations.members.(\w+)$/)&.map(&:item)&.last
        member_identifier = m_identifier || member
        lawful_presence_documentation = input.find(
          Regexp.new("attestations.members.#{member_identifier}.lawfulPresence.lawfulPresenceDocumentation")
        )&.first&.item
        return [] if lawful_presence_documentation.nil?

        result = lawful_presence_documentation.each_with_object([]) do |(key, value), collect|
          lawful_presence_document = value.merge(subject: remap_subject(key, value).to_s)
          collect << AcaEntities::Ffe::Transformers::Cv::VlpDocument.transform(lawful_presence_document)
        end
        result.reject {|hash| hash[:subject].nil?}
      end

      private

      def remap_subject(subject, document)
        case subject.to_s
        when "NOTICE_OF_ACTION_I_797"
          if  document[:alienNumber].present?
            "NOTICE_OF_ACTION_I_797_WITH_ALIEN"
          else
            document[:i94Number].present?
            "NOTICE_OF_ACTION_I_797_I_94"
          end
        when "OTHER"
          if document[:alienNumber].present?
            "OTHER_WITH_ALIEN"
          elsif document[:i94Number].present?
            "OTHER_WITH_I_94"
          else
            "OTHER_WITH_ALIEN"
          end
        else
          subject
        end
      end
    end
  end
end
# rubocop:enable Lint/DuplicateBranch
