# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Email < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'begin_date'
          add_key 'end_date'
          map 'address', 'contact.email_id'
          add_key 'contact.mailing_address'
          add_key 'contact.telephone_number'
          map 'kind', 'category_code', memoize: true, visible: true
          add_key 'is_primary_indicator', value: lambda { |v|
            kind = v.resolve('category_code').item
            @contact_method == kind
          }
        end
      end
    end
  end
end