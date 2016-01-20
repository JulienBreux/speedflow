require 'commander'
require 'colorize'

module Speedflow
  # Speedflow application
  class App
    include Commander::Methods

    # Public: Create an instance of Speedflow::App
    #
    # config - Speedflow config object.
    #
    # Examples
    #
    #    Speedflow::App.new(Speedflow::Config.load(PROJECT_PATH))
    #
    # Returns nothing.
    def initialize(config)
      @specs = Gem.loaded_specs['speedflow']
      @config = config
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
      command :default do |cmd|
        cmd.action(
          Speedflow::Commands::Default.new(@specs, @config, cmd)
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
      command :init do |cmd|
        cmd.syntax = "#{@specs.name} init"
        cmd.description = 'Initialize your project flow'
        cmd.option '-f', '--force', 'Force file creation'
        cmd.action(
          Speedflow::Commands::Init.new(@specs, @config, cmd)
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
      command :new do |cmd|
        cmd.syntax = "#{@specs.name} new"
        cmd.description = 'New issue'
        cmd.option '-s', '--subject [STRING]', String, 'Subject'
        cmd.action(
          Speedflow::Commands::New.new(@specs, @config, cmd)
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
      command :review do |cmd|
        cmd.syntax = "#{@specs.name} review"
        cmd.description = 'Review issue'
        cmd.action(
          Speedflow::Commands::Review.new(@specs, @config, cmd)
        )
      end
      alias_command :r, :review
    end
  end
end
