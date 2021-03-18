# frozen_string_literal: true

module Ehs
  class People::PersonRelationship < Dry::Struct
    INVERSE_MAP = { "child" => "parent", "parent" => "child", "grandparent" => "grandchild",
                    "grandchild" => "grandparent", "great_grandparent" => "great_grandchild",
                    "great_grandchild" => "great_grandparent", "stepparent" => "stepchild",
                    "stepchild" => "stepparent", "aunt_or_uncle" => "nephew_or_niece",
                    "nephew_or_niece" => "aunt_or_uncle", "ward" => "guardian",
                    "father_or_mother_in_law" => "daughter_or_son_in_law",
                    "daughter_or_son_in_law" => "father_or_mother_in_law", "guardian" => "ward",
                    # bi directional
                    "self" => "self", "brother_or_sister_in_law" => "brother_or_sister_in_law",
                    "sibling" => "sibling", "life_partner" => "life_partner", "spouse" => "spouse",
                    "other_relationship" => "other_relationship", "cousin" => "cousin", "unrelated" => "unrelated",
                    #one directional
                    "foster_child" => "guardian", "court_appointed_guardian" => "ward", "adopted_child" => "parent" }

    attribute :subject_individual_id, Types::String.meta(omittable: false)
    attribute :object_individual_id,  Types::String.meta(omittable: false)
    attribute :relationship_uri,      Types::FamilyRelationshipKind.meta(omittable: false)
  end
end
