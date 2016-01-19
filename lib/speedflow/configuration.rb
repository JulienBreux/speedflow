require 'yaml'

module Speedflow
  # Speedflow configuration module
  module Configuration
    extend self

    # @return [String] Project path
    attr_accessor :project_path

    # @return [Hash] Hash of settings
    attr_accessor :settings

    @filename = '.speedflow.yml'
    @project_path = '.'
    @settings = {}

    # Public: Load configuration file
    #
    # options - Hash of options.
    #
    # Examples
    #
    #    save
    #    # => nill
    #
    # Returns nothing.
    def load(options = {})
      new_sets = YAML::load_file("#{@project_path}/#{@filename}").deep_symbolize_keys
      if options[:env] && newsets[options[:env].to_sym]
        new_sets = new_sets[options[:env].to_sym]
      end
      deep_merge!(@settings, new_sets)
    end

    # Public: Save configuration file
    #
    # Examples
    #
    #    save
    #    # => nill
    #
    # Returns nothing.
    def save
      File.open("#{@project_path}/#{@filename}", 'w') do |file|
        file.write @settings.deep_stringify_keys.to_yaml.gsub("---\n", '')
      end
    end

    # Public: Check if configuration file exists
    #
    # Examples
    #
    #    exists?
    #    # => True or False
    #
    # Returns if configuration file exists.
    def exists?
      File.exist?("#{@project_path}/#{@filename}")
    end

    # Public: Deep merge data
    #
    # target - Hash of destination
    # data   - Hash of source
    #
    # Examples
    #
    #    deep_merge!({}, {})
    #    # => {}
    #
    # Returns configuration settings merged.
    def deep_merge!(target, data)
      merger = proc{|key, v1, v2|
        Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      target.merge! data, &merger
    end

    # Public: Check if configuration file exists
    #
    # name - Name of settings key
    #
    # Examples
    #
    #    method_missing(:foo)
    #    # => "value"
    #
    # Returns configuration settings by name.
    def method_missing(name)
      @settings[name.to_sym] ||
      fail(NoMethodError, "unknown configuration root #{name}", caller)
    end
  end
end
