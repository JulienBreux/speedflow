require 'commander'
require 'colorize'

module Speedflow
  # Speedflow application
  class App
    include Commander::Methods

    def initialize(project_path)
      @project_path = project_path
      @specs = Gem.loaded_specs['speedflow']
      @config = Speedflow::Configuration
      @config.project_path = project_path
    end

    # Public: Run Speedflow application
    #
    # Example
    #
    #    run
    #    # => nil
    #
    # Returns nothing.
    def run
      define_app!
      default_command!
      init_command!
      new_command!
      review_command!

      run!
    end

    protected

    # Public: Define app properties
    #
    # Example
    #
    #    define_app!
    #    # => nil
    #
    # Returns nothing.
    def define_app!
      program :name, @specs.name.to_s
      program :version, @specs.version.to_s
      program :description, @specs.description.to_s
      program :help, 'Author', "#{@specs.authors.first} #{@specs.email.first}"
    end

    # Public: Default command
    #
    # Example
    #
    #    default_command!
    #    # => nil
    #
    # Returns nothing.
    def default_command!
      command :default do |c|
        c.action(
          Speedflow::Commands::Default.new(@specs, @project_path, c, @config)
        )
      end
      default_command :default
    end

    # Public: Init command
    #
    # Example
    #
    #    init_command!!
    #    # => nil
    #
    # Returns nothing.
    def init_command!
      command :init do |c|
        c.syntax = "#{@specs.name} init"
        c.description = 'Initialize your project flow'
        c.option '-f', '--force', 'Force file creation'
        c.action(
          Speedflow::Commands::Init.new(@specs, @project_path, c, @config)
        )
      end
      alias_command :i, :init
    end

    # Public: New command
    #
    # Example
    #
    #    new_command!!
    #    # => nil
    #
    # Returns nothing.
    def new_command!
      command :new do |c|
        c.syntax = "#{@specs.name} new"
        c.description = 'New issue'
        c.option '-s', '--subject [STRING]', String, 'Subject'
        c.action(
          Speedflow::Commands::New.new(@specs, @project_path, c, @config)
        )
      end
      alias_command :n, :new
    end

    # Public: Review command
    #
    # Example
    #
    #    review_command!!!
    #    # => nil
    #
    # Returns nothing.
    def review_command!
      command :review do |c|
        c.syntax = "#{@specs.name} review"
        c.description = 'Review issue'
        c.action(
          Speedflow::Commands::Review.new(@specs, @project_path, c, @config)
        )
      end
      alias_command :r, :review
    end
  end
end
