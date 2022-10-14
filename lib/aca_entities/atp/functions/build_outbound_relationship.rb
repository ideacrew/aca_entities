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
          great_grandchild: 'Unspecified relative',
          brother_or_sister: 'Sibling (brother or sister)',
          stepparent: 'Stepparent (stepfather or stepmother)',
          aunt_or_uncle: 'Uncle or aunt',
          nephew_or_niece: 'Nephew or niece',
          grandparent: 'Grandparent (grandfather or grandmother)',
          great_grandparent: 'Unspecified relative',
          first_cousin: 'First cousin',
          brother_in_law_or_sister_in_law: 'Brother-in-law or sister-in-law',
          son_in_law_or_daughter_in_law: 'Son-in-law or daughter-in-law',
          mother_in_law_or_father_in_law: 'Mother-in-law or father-in law',
          other_relative: 'Unspecified relative',
          other: 'Unspecified relationship',
          domestic_partner: 'Domestic partner',
          parents_domestic_partner: "Parent's domestic partner",
          domestic_partners_child: "Child of domestic partner"
        }.freeze

        def call(cache)
          @applicants_hash = cache.resolve('family.magi_medicaid_applications.applicants').item
          family_flags = cache.resolve('family.family_flags').item
          member_id = cache.find(/family.family_members.(\w+)$/).map(&:item).last
          person_relationships = @applicants_hash[member_id.to_sym][:mitc_relationships]
          person_relationships = find_relationships_to_member(member_id) if family_flags&.dig(:invert_person_association)
          return unless person_relationships

          person_relationships.uniq.each_with_object([]) do |person_relationship, collect|
            mitc_relationship_code =
              ::AcaEntities::MagiMedicaid::Mitc::Types::RelationshipCodeMap.invert[person_relationship[:relationship_code]] || '88'
            # prevent mismapping of relationship codes after inverting RelationshipCodeMap
            mitc_relationship_code = :grandchild if person_relationship[:relationship_code] == '06'
            mitc_relationship_code = :grandparent if person_relationship[:relationship_code] == '15'

            relation = RelationshipCodeMap[mitc_relationship_code]
            atp_relationship_code = AcaEntities::Types::RelationshipToTaxFilerCodeMap.invert[relation.to_s].to_s
            collect << { :person => { :ref => "pe#{person_relationship[:other_id]}" }, :family_relationship_code => atp_relationship_code,
                         :caretaker_dependent_code => nil }
          end
        end

        # collects relationships FROM other applicants TO applicant with member_id
        def find_relationships_to_member(member_id)
          @applicants_hash.each_with_object([]) do |applicant, collect|
            applicant_id = applicant[0]
            applicant_hash = applicant[1]
            relationships = applicant_hash[:mitc_relationships].select {|rel| rel[:other_id] == member_id}
            relationships.each do |rel|
              collect << {
                other_id: applicant_id,
                attest_primary_responsibility: rel[:attest_primary_responsibility],
                relationship_code: rel[:relationship_code]
              }
            end
          end.flatten
        end
      end
    end
  end
end
