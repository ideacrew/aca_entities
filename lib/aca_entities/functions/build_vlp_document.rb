# frozen_string_literal: true

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
          lawful_presence_document = value.merge(subject: key.to_s)
          collect << AcaEntities::Ffe::Transformers::Cv::VlpDocument.transform(lawful_presence_document)
        end
        result.reject {|hash| hash[:subject].nil?}
      end
    end
  end
end

