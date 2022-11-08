# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Phone < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'begin_date', value: ->(_v) { Date.today } # default
          add_key 'end_date', value: ->(_v) { Date.today } # default
          add_key 'contact.email_id'
          add_key 'contact.mailing_address'
          map 'full_phone_number', 'contact.telephone_number.telephone.telephone_number_full_id'
          map 'extension', 'contact.telephone_number.telephone.telephone_suffix_id'
          map 'contact.telephone_number.telephone.telephone_suffix_id'
          map 'kind', 'category_code', memoize: true, visible: true, function: ->(_v) { ContactKinds[phone[:kind]] }
          add_key 'is_primary_indicator', value: lambda { |v|
            kind = v.resolve('category_code').item
            @contact_method == kind
          }
        end
      end
    end
  end
end