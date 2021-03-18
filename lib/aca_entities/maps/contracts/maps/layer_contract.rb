# frozen_string_literal: true

module Maps
  class LayerContract < ApplicationContract
    params do
      required(:key).filled(Types::Symbol)
      optional(:title).filled(Types::String)
      optional(:feature_groups).array(:hash)
      optional(:z_index).filled(:integer)
      optional(:options).filled(:hash)
    end

    rule(:feature_groups).each do
      if key? && value
        result = Maps::FeatureGroupContract.new.call(value)
        key.failure(text: "invalid feature group", error: result.errors.to_h) unless result.success?
      end
    end

  end
end
