require "yaml"

module Speedflow
  module Configuration
    extend self

    attr_accessor :project_path, :settings

    @filename = ".speedflow.yml"
    @project_path = "."
    @settings = {}

    def load!(options = {})
      newsets = YAML::load_file(@project_path+"/"+@filename).deep_symbolize
      if options[:env] && newsets[options[:env].to_sym]
        newsets = newsets[options[:env].to_sym]
      end
      deep_merge!(@settings, newsets)
    end

    def save!
      File.open(@project_path+"/"+@filename, 'w') do |file|
        file.write @settings.deep_stringify_keys.to_yaml.gsub("---\n", '')
      end
    end

    def exists?
      File.exist?(@project_path+"/"+@filename)
    end

    def deep_merge!(target, data)
      merger = proc{|key, v1, v2|
        Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      target.merge! data, &merger
    end

    def method_missing(name, *args, &block)
      @settings[name.to_sym] ||
      fail(NoMethodError, "unknown configuration root #{name}", caller)
    end
  end
end
