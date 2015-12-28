module Speedflow
  module Utils
    extend self

    def transform_hash(original, options={}, &block)
      original.inject({}){|result, (key,value)|
        value = if (options[:deep] && Hash === value)
                  transform_hash(value, options, &block)
                else
                  if Array === value
                    value.map{|v| transform_hash(v, options, &block)}
                  else
                    value
                  end
                end
        block.call(result,key,value)
        result
      }
    end

    # Convert keys to strings
    def stringify_keys(hash)
      self.transform_hash(hash) {|hash, key, value|
        hash[key.to_s] = value
      }
    end

    # Convert keys to strings, recursively
    def deep_stringify_keys(hash)
      self.transform_hash(hash, :deep => true) {|hash, key, value|
        hash[key.to_s] = value
      }
    end
  end
end
