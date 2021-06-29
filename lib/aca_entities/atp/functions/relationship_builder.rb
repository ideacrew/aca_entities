# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
module AcaEntities
  module Atp
    module Functions
      # builds hash for primary and non primary applicant
      class RelationshipBuilder
        def call(cache)
          @memoized_data = cache
          family_relationships = @memoized_data.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:family_relationships]
          @primary_applicant_id = @memoized_data.resolve('primary_applicant_identifier').item
          current_member = @memoized_data.find(/record.people.(\w+)$/).map(&:item).last

          relationship = ''
          family_relationships.each do |family_relationship|
            primary_match = family_relationship[:relative_id] == @primary_applicant_id
            if @primary_applicant_id == current_member
              relationship = 'self'
              break
            elsif primary_match
              rel_code = family_relationship[:family_relationship_code].to_s.rjust(2, "0")
              relationship = Types::RelationshipToTaxFilerCodeMap[:"#{rel_code}"].downcase
              break
            end
          end

          [{ relative: person_hash, kind: relationship }]
        end

        private

        def person_hash
          { hbx_id: '1234', # default value
            first_name: @memoized_data.find(Regexp.new("person_name.first_name.#{@primary_applicant_id}"))&.first&.item,
            last_name: @memoized_data.find(Regexp.new("person_name.last_name.#{@primary_applicant_id}"))&.first&.item,
            gender: @memoized_data.find(Regexp.new("person.person_demographics.gender.#{@primary_applicant_id}"))&.first&.item&.capitalize,
            dob: @memoized_data.find(Regexp.new("person.person_demographics.dob.#{@primary_applicant_id}"))&.first&.item,
            ssn: @memoized_data.find(Regexp.new("person.person_demographics.ssn.#{@primary_applicant_id}"))&.first&.item }
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity


