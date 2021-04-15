# frozen_string_literal: true

module AcaEntities
  module Identifiers

    # @example
    # {
    #     key: :curam_e_case_id,
    #     item: '8422201791080300544',
    #     kind: {
    #         key: :e_case,
    #         namespace: 'curam',
    #         label: 'Curam Case Id',
    #         description: '' # optional
    #     },
    #     start_on: Date.today,
    #     end_on: Date.today.next_month
    # }
    class Id < Dry::Struct
      attribute :key,       Types::IdKey.meta(omittable: false)
      attribute :item,      Types::String.meta(omittable: false)
      attribute :kind,      AcaEntities::Identifiers::IdentifierKind.optional.meta(omittable: true)
      attribute :start_on,  Types::Date.optional.meta(omittable: true)
      attribute :end_on,    Types::Date.optional.meta(omittable: true)
    end
  end
end

