# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), "../*.rb")].sort.each { |file| require file }

OpenStruct.class_eval do
  def to_hash
    each_pair.with_object({}) do |(key, value), hash|
      hash[key] = case value
                  when OpenStruct
                    value.to_hash
                  when Array
                    value.map!(&:to_hash)
                  else
                    value
                  end
    end
  end

  def set_nested_value(keys, value)
    keys = keys.split(" ") if keys.is_a?(String)
    create_nest(keys)
    *keys, final_key = keys
    to_set = keys.empty? ? self : dig(*keys)

    return unless to_set

    to_set[final_key] = value
  end

  def create_nest(keys)
    keys = keys.split(" ") if keys.is_a?(String)
    ostruct = self
    keys.each do |key|
      ostruct[key] = OpenStruct.new unless ostruct[key].is_a?(OpenStruct)
      ostruct = ostruct[key]
    end
    self
  end
end
