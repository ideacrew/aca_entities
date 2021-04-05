# frozen_string_literal: true

module AcaEntities
  # A module for all the common methods that can be used across the gem.
  module AppHelper
    # An object is blank if it's empty, or a whitespace string.
    # For example, nil, '', '   ', [], and {} are all blank.
    # Note: false is not blank.
    def check_if_blank?(data_object)
      if data_object.respond_to?(:empty?)
        data_object.is_a?(String) ? data_object.strip.empty? : data_object.empty?
      else
        data_object.nil?
      end
    end

    def check_if_present?(data_object)
      !check_if_blank?(data_object)
    end
  end
end
