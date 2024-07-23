# frozen_string_literal: true

require 'aca_entities/types'
require 'dry/monads'
require 'active_support/core_ext/string/conversions'

# rubocop:disable Metrics/CyclomaticComplexity
module AcaEntities
  module Atp
    module Functions
      # builds relationship attributes
      class RelationshipBuilder

        MAPPING_RELATIONS =
          { 'Spouse' => 'spouse',
            'Parent (father or mother)' => 'parent',
            'Grandparent (grandfather or grandmother)' => 'grandparent',
            'Grandchild (grandson or granddaughter)' => 'grandchild',
            'Uncle or aunt' => 'aunt_or_uncle',
            'Nephew or niece' => 'nephew_or_niece',
            'First cousin' => 'other_relationship', # no related mapping in enroll
            'Adopted son or daughter' => 'adopted_child',
            'Foster child (foster son or foster daughter)' => 'foster_child',
            'Son-in-law or daughter-in-law' => 'daughter_or_son_in_law',
            'Brother-in-law or sister-in-law' => 'brother_or_sister_in_law',
            'Mother-in-law or father-in law' => 'father_or_mother_in_law',
            'Sibling (brother or sister)' => 'sibling',
            'Ward' => 'ward',
            'Stepparent (stepfather or stepmother)' => 'stepparent',
            'Stepchild (stepson or stepdaughter)' => 'stepchild',
            'Self' => 'self',
            'Child (son or daughter)' => 'child',
            'Sponsored dependent' => 'sponsored_dependent',
            'Dependent of a minor dependent' => 'dependent_of_a_minor_dependent',
            'Former spouse' => 'other_relationship', # no related mapping in enroll
            'Guardian' => 'guardian',
            'Court-appointed guardian' => 'court_appointed_guardian',
            'Collateral dependent' => 'collateral_dependent',
            'Domestic partner' => 'domestic_partner',
            'Annuitant' => 'annuitant',
            'Trustee' => 'trustee',
            'Unspecified relationship' => 'other_relationship', # no related mapping in enroll
            'Unspecified relative' => 'other_relationship', # no related mapping in enroll
            "Parent's domestic partner" => 'parents_domestic_partner',
            'Child of domestic partner' => 'domestic_partners_child' }.freeze

        def call(cache)
          @memoized_data = cache
          family_relationships = @memoized_data.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:family_relationships]
          @primary_applicant_id = @memoized_data.resolve('primary_applicant_identifier').item
          current_member = @memoized_data.find(/record.people.(\w+)$/).map(&:item).last
          relationship = ''
          default = @primary_applicant_id == current_member ? 'self' : 'other_relationship'
          family_relationships.each do |family_relationship|
            primary_match = family_relationship[:person] == @primary_applicant_id
            if @primary_applicant_id == current_member
              relationship = 'Self'
              break
            elsif primary_match
              rel_code = family_relationship[:family_relationship_code].to_s.rjust(2, "0")
              relationship = AcaEntities::Types::RelationshipToTaxFilerCodeMap[:"#{rel_code}"]
              break
            end
          end

          kind = MAPPING_RELATIONS[relationship] || default
          [{ relative: person_hash, kind: kind }]
        end

        private

        def person_hash
          dob_value = @memoized_data.find(Regexp.new("person.person_demographics.dob.#{@primary_applicant_id}"))&.first&.item
          dob = dob_value ? Date.parse(dob_value) : nil
          { hbx_id: '1234', # default value
            first_name: @memoized_data.find(Regexp.new("person_name.first_name.#{@primary_applicant_id}"))&.first&.item&.capitalize,
            last_name: @memoized_data.find(Regexp.new("person_name.last_name.#{@primary_applicant_id}"))&.first&.item&.capitalize,
            gender: @memoized_data.find(Regexp.new("person.person_demographics.gender.#{@primary_applicant_id}"))&.first&.item&.capitalize,
            dob: dob,
            ssn: encrypt_ssn(@memoized_data.find(Regexp.new("person.person_demographics.ssn.#{@primary_applicant_id}"))&.first&.item) }
        end

        def encrypt_ssn(ssn)
          return unless ssn
          result = AcaEntities::Operations::Encryption::Encrypt.new.call({ value: ssn })
          result.success? ? result.value! : nil
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity


