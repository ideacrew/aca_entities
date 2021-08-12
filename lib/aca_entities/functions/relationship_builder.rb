# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
module AcaEntities
  module Functions
    # builds hash for primary and non primary applicant
    class RelationshipBuilder

      RelationshipMap = {
        "self" => "self",
        "spouse" => "spouse",
        "parent" => "child",
        "sibling" => "sibling",
        "grandparent" => "grandchild",
        "domestic_partner" => "domestic_partner",
        "aunt_uncle" => "nephew_or_niece",
        "step_parent" => "child",
        "unrelated" => "unrelated",
        "parents_domestic_partner" =>"unrelated",
        "other_relative" => "unrelated",
        "first_cousin" =>"unrelated",
        "mother_in_law_father_in_law" => "child",
        "brother_in_law_sister_in_law" => "sibling"
      }

      def call(cache)
        @memoized_data = cache
        @primary_applicant_id = cache.resolve('family.family_members.is_primary_applicant').item
        @current_member = cache.find(/attestations.members.(\w+)$/).map(&:item).last
        household = cache.resolve('attestations.household').item
        relationship = ''

        household[:familyRelationships].each do |family_relationship|
          primary_match = family_relationship[:no_key][1][:no_key].include?(@primary_applicant_id)
          current_member_match = family_relationship[:no_key][1][:no_key].include?(@current_member)

          if @primary_applicant_id == @current_member
            relationship = 'self'
            break
          elsif primary_match && current_member_match
            relationship = RelationshipMap[family_relationship[:no_key][1][:no_key][1].downcase]
            break
          elsif current_member_match
            relationship = RelationshipMap[family_relationship[:no_key][1][:no_key][1].downcase]
          else
            relationship = "unrelated"   # Case for relationship not provided
          end
        end

        [{ relative: person_hash, kind: relationship }]
      end

      private

      def person_hash
        # TODO check here Date
        dob_value = @memoized_data.find(Regexp.new("person_demographics.dob.#{@current_member}"))&.first&.item
        dob = dob_value ?  Date.parse(dob_value) : Date.parse("2021-05-07")
        { hbx_id: @current_member, # default value
          first_name: @memoized_data.find(Regexp.new("first_name.#{@current_member}"))&.first&.item,
          last_name: @memoized_data.find(Regexp.new("last_name.#{@current_member}"))&.first&.item,
          gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@current_member}"))&.first&.item&.capitalize,
          dob: dob,
          ssn: @memoized_data.find(Regexp.new("person_demographics.ssn.#{@current_member}"))&.first&.item }
      end
    end
  end
end

# return [] unless @primary_applicant_id == @current_member
# TODO: 1. build relationship for only primary member
#    2. Inverse relationship
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

# rubocop:enable Metrics/CyclomaticComplexity
