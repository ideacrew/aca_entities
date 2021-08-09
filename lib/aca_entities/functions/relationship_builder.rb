# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
module AcaEntities
  module Functions
    # builds hash for primary and non primary applicant
    class RelationshipBuilder
      def call(cache)
        @memoized_data = cache
        # require 'pry';binding.pry
        @primary_applicant_id = cache.resolve('family.family_members.is_primary_applicant').item
        @current_member = cache.find(/attestations.members.(\w+)$/).map(&:item).last
        household = cache.resolve('attestations.household').item

        return [] unless @primary_applicant_id == @current_member
        # TODO: 1. build relationship for only primary member
           #    2. Inverse relationship


        relationship = ''
        household[:familyRelationships].each do |family_relationship|
          primary_match = family_relationship[:no_key][1][:no_key].include?(@primary_applicant_id)
          current_member_match = family_relationship[:no_key][1][:no_key].include?(@current_member)

          # "1698396120596498435",
          #     "SPOUSE",
          #     "839737892842424795",
          #     {
          #         "resideTogetherIndicator": true
          # {
          #     "resideTogetherIndicator": true,
          #     "caretakerRelativeIndicator": false
          # }
          #     }

          #TODO: 1. relationship that has no subcriber, 2. hash with other information

          if @primary_applicant_id == @current_member
            relationship = 'self'
            break
          elsif primary_match && current_member_match
            relationship = family_relationship[:no_key][1][:no_key][1].downcase
            break
          end
        end

        [{ relative: person_hash, kind: relationship }]
      end

      private

      def person_hash
        { hbx_id: @current_member, # default value
          first_name: @memoized_data.find(Regexp.new("first_name.#{@current_member}"))&.first&.item,
          last_name: @memoized_data.find(Regexp.new("last_name.#{@current_member}"))&.first&.item,
          gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@current_member}"))&.first&.item&.capitalize,
          dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@current_member}"))&.first&.item,
          ssn: @memoized_data.find(Regexp.new("person_demographics.ssn.#{@current_member}"))&.first&.item }
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
