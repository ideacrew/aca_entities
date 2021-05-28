# frozen_string_literal: true

# rubocop:disable Style/GuardClause, Metrics/CyclomaticComplexity
module AcaEntities
  module Functions
    # builds hash for primary and non primary applicant
    class RelationshipBuilder
      def call(cache)
        @memoized_data = cache
        @primary_applicant_id = cache.resolve('family.family_members.is_primary_applicant').item
        current_member = cache.find(/attestations.members.(\w+)$/).map(&:item).last
        household = cache.resolve('attestations.household').item

        relationship = ''
        household[:familyRelationships].each do |a|
          primary_match = a[:no_key][1][:no_key][0] == @primary_applicant_id
          current_member_match = a[:no_key][1][:no_key][2] == current_member

          if primary_match && current_member_match
            relationship = a[:no_key][1][:no_key][1].downcase
          else
            next
          end
        end
        [{ relative: person_hash, kind: relationship }]
      end

      private

      def person_hash
        { hbx_id: '1234', # default value
          first_name: @memoized_data.find(Regexp.new("first_name.#{@primary_applicant_id}"))&.first&.item,
          last_name: @memoized_data.find(Regexp.new("last_name.#{@primary_applicant_id}"))&.first&.item,
          gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@primary_applicant_id}"))&.first&.item&.capitalize,
          dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@primary_applicant_id}"))&.first&.item,
          ssn: @memoized_data.find(Regexp.new("person_demographics.ssn.#{@primary_applicant_id}"))&.first&.item }
      end
    end
  end
end
# rubocop:enable Style/GuardClause, Metrics/CyclomaticComplexity
