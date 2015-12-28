require "yaml"

module Speedflow
  module Configuration
    extend self

    attr_accessor :project_path, :settings

    @FILENAME = ".sf.yml"
    @project_path = "."
    @settings = {}

    def load!(options = {})
      newsets = YAML::load_file(@project_path+"/"+@FILENAME).deep_symbolize
      if options[:env] && newsets[options[:env].to_sym]
        newsets = newsets[options[:env].to_sym]
      end
      deep_merge!(@settings, newsets)
    end

    def save!
      settings = Speedflow::Utils.deep_stringify_keys(@settings).to_yaml.gsub("---\n", '')
      File.open(@project_path+"/"+@FILENAME, 'w') do |file|
        file.write settings
      end
    end

    def exists?
      File.exist?(@project_path+"/"+@FILENAME)
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
