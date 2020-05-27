# frozen_string_literal: true

# Flatten an array of arbitrarily nested arrays of integers
# into a flat array of integers. e.g. [[1,2,[3]],4] -> [1,2,3,4],
# WITHOUT relying on Array#flatten

# Implementation
module ArrayUtils
  class << self
    def flatten_integers(array)
      raise ArgumentError, 'Suplied argument is not an array' unless array.is_a?(Array)
      process_all_items(array)
    end

    private

    def process_all_items(array)
      [].tap do |result|
        array.each { |item| result.push(*convert_single_item(item)) }
      end
    end

    def convert_single_item(item)
      if item.is_a?(Array)
        process_all_items(item)
      elsif item.is_a?(Integer)
        item
      else
        raise ArgumentError, "Unexpected array element: #{item.class}"
      end
    end
  end
end
