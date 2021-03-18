# frozen_string_literal: true

module Ehs::Emails
  class EmailContract < Ehs::ApplicationContract

    params do
      required(:type).filled(Ehs::Types::EmailKind)
      required(:address).filled(:string)
    end
  end
end
