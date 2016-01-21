require 'yaml'
require 'erb'

module Speedflow
  # Speedflow configuration
  class Config
    FILENAME = '.speedflow.yml'.freeze

    # @return [String] String of path
    attr_accessor :path

    # @return [Hash] Hash of settings
    attr_accessor :settings

    # Public: Create an instance of Speedflow::Configuration
    #
    # path     - Path.
    # settings - Hash of default settings.
    #
    # Examples
    #
    #    Speedflow::Configuration.new('.')
    #
    # Returns nothing.
    def initialize(path, settings = nil)
      @path = path
      @settings = settings || {}
    end

    # Public: Convert open struct to hash
    #
    # Examples
    #
    #    config = Speedflow::Configuration.new('.')
    #    config.to_h
    #    # => {}
    #
    # Returns a hash.
    def to_h
      @settings
    end

    # Public: Save configuration file
    #
    # Examples
    #
    #    save
    #    # => nil
    #
    # Returns nothing.
    def save
      File.open("#{@path}/#{FILENAME}", 'w') do |file|
        file.write @settings.deep_stringify_keys.to_yaml
      end
    end

    # Public: Check if configuration file exists
    #
    # Examples
    #
    #    config = Speedflow.new(PROJECT_PATH)
    #    config.exists?
    #    # => False
    #
    # Returns if configuration file exists.
    def exists?
      File.exist?("#{@path}/#{FILENAME}")
    end

    # Public: Check empty configuration
    #
    # Examples
    #
    #    config = Speedflow.new(PROJECT_PATH)
    #    config.empty?
    #    # => True
    def empty?
      @settings.empty?
    end

    # Public: Delete root key from settings
    #
    # Examples
    #
    #    config = Speedflow::Config.new({foo: 'bar'})
    #    config.remove!(:foo)
    #    # => nil
    #
    # Returns nothings.
    def remove_key!(key)
      @settings.delete(key)
    end

    # Public: Merge settings
    #
    # Examples
    #
    #    config = Speedflow::Config.new({foo: 'bar'})
    #    config.merge!({foo: 'baz'})
    #    # => {foo: 'baz'}
    #
    # Returns if configuration file exists.
    def merge!(settings)
      @settings = @settings.deep_merge(settings)
    end

    # Public: Load configuration to open struct
    #
    # - path - File path
    #
    # Examples
    #
    #    load!
    #    # => {}
    #
    # Returns config instance.
    def load!
      if exists?
        path = File.read("#{@path}/#{FILENAME}")
        content = ERB.new(path).result
        content = YAML.load(content)
        @settings = content.deep_symbolize_keys if content.is_a?(Hash)
      else
        Hash
      end
    end
  end
end
