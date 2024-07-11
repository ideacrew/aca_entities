# frozen_string_literal: true

module Domain
  # Generator that adds Domain Model to a Rails application
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    def initialize(*args, &blk)
      super(*args, &blk)
      @app_name = app_name
    end

    desc 'Create Domain folder, Contract subfolder, Application folder and Types files'

    def verify_required_gems
      gem "event_source", git: "https://github.com/ideacrew/event_source.git", branch: 'trunk'
    end

    def create_domain_contract_file
      template 'domain_contract.rb', File.join('app/domain/contracts', 'contract.rb')
    end

    def create_types_file
      template 'types.rb', File.join("app/domain", 'types.rb')
    end

    def create_domain_types_file
      template 'domain_types.rb', File.join("app/domain/#{@app_name}", 'types.rb')
    end

    hook_for :test_framework, in: :rspec, as: :dry_type

    private

    def app_name
      Rails.application.class.name.chomp('::Application').underscore
    end
  end
end
