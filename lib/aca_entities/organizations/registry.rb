# frozen_string_literal: true

module AcaEntities
  module Organizations
    # The Dry::Container's reserved configuration namespace structure
    # Used when initilizing a new container instance.
    # @see ResourceRegistry::Stores::Container::Create
    class Registry < Dry::Struct

      # @!attribute [r] name
      # A unique identifier for this container
      # @return [String]
      attribute :name,              Types::Symbol.meta(ommittable: false)

      # @!attribute [r] root
      # Root directory for this system (defaults to `pwd`)
      # @return [String]
      attribute :root,              Types::Path.meta(ommittable: false)

      # @!attribute [r] default_namespace
      # @return [String]
      attribute :default_namespace, Types::String.optional.meta(ommittable: true)

      # @!attribute [r] system_dir
      # Folder name relative to root, where bootable components live
      # @return [String]
      attribute :system_dir,        Types::String.optional.meta(ommittable: true)

      # @!attribute [r] load_path
      # @return [Array<String>]
      attribute :load_path,         Types::Array.of(Types::String).optional.meta(ommittable: true)

      # @!attribute [r] auto_register
      # A folder containing class definitions that will be automatically registered in the container.
      # Path is defined relative to {root} attribute value
      # @return [String]
      attribute :auto_register,     Types::Array.of(Types::String).optional.meta(ommittable: true)
      # end

      # @!attribute [r] options
      # @return [Array<ResourceRegistry::Entities::Option>]
      attribute :settings,   Types::Array.of(ResourceRegistry::Entities::Setting).meta(omittable: true)

      # @!attribute [r] timestamp
      # @return [String]
      attribute :timestamp, Types::String.optional.meta(ommittable: true)
    end
  end
end
