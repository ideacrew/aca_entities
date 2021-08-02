# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # builds relationship attributes
      class BuildOutboundRelationship

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
            "Parent's domestic partner" => 'other_relationship', # no related mapping in enroll
            'Child of domestic partner' => 'other_relationship' }.freeze  # no related mapping in enroll

        RelationshipCodeMap = {
          self: 'self',
          husband_or_wife: 'Spouse',
          parent: 'Parent (father or mother)',
          son_or_daughter: 'Child (son or daughter)',
          stepson_or_stepdaughter: 'Stepchild (stepson or stepdaughter)',
          grandchild: 'Grandchild (grandson or granddaughter)',
          great_grandchild: '06',
          brother_or_sister: 'Sibling (brother or sister)',
          stepparent: 'Stepparent (stepfather or stepmother)',
          aunt_or_uncle: 'Uncle or aunt',
          nephew_or_niece: 'Nephew or niece',
          grandparent: 'Grandparent (grandfather or grandmother)',
          great_grandparent: '15',
          first_cousin: 'First cousin',
          brother_in_law_or_sister_in_law: 'Brother-in-law or sister-in-law',
          son_in_law_or_daughter_in_law: 'Son-in-law or daughter-in-law',
          mother_in_law_or_father_in_law: 'Mother-in-law or father-in law',
          other_relative: 'Unspecified relative',
          other: 'Unspecified relationship'
        }.freeze

        def call(cache)
          @memoized_data = cache
          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          person_relationships = applicants_hash[member_id.to_sym][:mitc_relationships]
          @primary_applicant_id = @memoized_data.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last

          person_relationships.each_with_object([]) do |person_relationship, collect|
            mitc_relationship_code =
              ::AcaEntities::MagiMedicaid::Mitc::Types::RelationshipCodeMap.invert[person_relationship[:relationship_code]] || '88'
            relation = RelationshipCodeMap[mitc_relationship_code]
            atp_relationship_code = Types::RelationshipToTaxFilerCodeMap.invert[relation.to_s].to_s

            collect << { :relative_id => person_relationship[:other_id], :family_relationship_code => atp_relationship_code,
                         :caretaker_dependent_code => nil }
          end
        end
      end
    end
  end
end
