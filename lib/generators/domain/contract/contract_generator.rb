# frozen_string_literal: true

require_relative '../generated_dry_attribute'

module Domain
  # Generate a Domain Entity Contract file
  class ContractGenerator < Rails::Generators::NamedBase # :nodoc:
    source_root File.expand_path('templates', __dir__)

    ENTITY_CONTRACT_PATH = 'app/domain/contracts'
    ENTITY_CONTRACT_TEMPLATE_FILENAME = 'entity_contract.rb'
    DOC_PREFIX_TEXT = <<~ATTR.chomp.strip
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
    ATTR

    desc 'Create Dry::Validations Contract file'

    argument :arguments,
             type: :array,
             default: [],
             banner:
               'ATTRIBUTE_NAME[:type][:optional_key (default) | :require_key] ATTRIBUTE_NAME[:type][:optional_key (default) | :require_key]'

    check_class_collision suffix: 'Contract'

    def initialize(*args, &blk)
      @local_args = args[0].dup
      super(*args, &blk)

      @local_class_name = class_name.to_s.split('::').last
      @doc_content = DOC_PREFIX_TEXT
      @params_content = ''
      @indentation = 2
      @class_indent = [class_path.size, 0].max
    end

    # Convert arguments array into GeneratedDryAttribute objects
    def parse_dry_arguments
      attrs = @local_args.drop(1)

      (attrs || []).map do |attr|
        parsed_attr = Generators::Domain::GeneratedDryAttribute.parse(attr)
        @doc_content += doc_text(parsed_attr).chomp
        @params_content += params_text(parsed_attr).chomp
      end
    end

    def create_entity_contract_file
      template ENTITY_CONTRACT_TEMPLATE_FILENAME, contract_filename
    end

    hook_for :test_framework, in: :rspec, as: :contract

    private

    def contract_filename
      File.join(ENTITY_CONTRACT_PATH, class_path, "#{file_name}_contract.rb")
    end

    def params_text(attr)
      attr.key_required? ? required_attribute(attr) : optional_attribute(attr)
    end

    def doc_text(attr)
      attr.key_required? ? required_doc(attr) : optional_doc(attr)
    end

    def required_attribute(attr)
      data_type = attr.type
      "\nrequired(:#{attr.name}).filled(:#{data_type})"
    end

    def optional_attribute(attr)
      data_type = attr.type.to_s
      "\noptional(:#{attr.name}).maybe(:#{data_type})"
    end

    def required_doc(attr)
      data_type = attr.type.to_s.classify
      "\n# @option opts [#{data_type}] :#{attr.name.to_sym} (required)"
    end

    def optional_doc(attr)
      data_type = attr.type.to_s.classify
      "\n# @option opts [#{data_type}] :#{attr.name.to_sym} (optional)"
    end
  end
end
