# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Replaces part of the text with a gap.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2025 Yegor Bugayenko
# License:: MIT
class String
  # Truncates a string to specified maximum length, inserting a gap in the middle
  # if necessary. The resulting string will never be longer than the specified
  # maximum length. The original string is returned if it is already shorter than
  # or equal to the maximum length.
  #
  # @param [Integer] max The maximum length of the resulting string
  # @param [String] gap The string to use as a gap (default: '...')
  # @param [Symbol] align The alignment can be :left, :center, or :right
  #   (default: :center)
  # @return [String] The truncated string with gap in the middle if necessary
  #
  # @example Basic usage with default parameters
  #   "Hello, world!".ellipsized
  #   # => "Hello, world!"
  #
  # @example Truncate a long string
  #   "This is a very long string that needs to be truncated".ellipsized(20)
  #   # => "This is...truncated"
  #
  # @example Custom gap
  #   "Another very long string example".ellipsized(15, '***')
  #   # => "Anoth***example"
  #
  # @example Custom align
  #   "Another very long string example".ellipsized(15, '...', :left)
  #   # => "...tring example"
  #
  # @example Edge cases
  #   "".ellipsized      # => ""
  #   "Short".ellipsized # => "Short"
  #   "xyz".ellipsized(0) # => ""
  #   "xyz".ellipsized(2, '...') # => "xy"
  def ellipsized(max = 64, gap = '...', align = :center)
    validate_arguments(max, gap, align)
    return '' if empty?
    return self if length <= max
    return '' if max.zero?

    gap = gap.to_s
    return self[0..max - 1] if gap.length >= max

    case align
    when :left
      "#{gap}#{self[length - max + gap.length..]}"
    when :center
      head = tail = (max - gap.length) / 2
      head += 1 if head + tail + gap.length < max
      head = max if head > max
      "#{self[0, head]}#{gap}#{self[length - tail..]}"
    when :right
      "#{self[0, max - gap.length]}#{gap}"
    end
  end

  private

  def validate_arguments(max, gap, align)
    raise "Max length must be an Integer, while #{max.class.name} provided" unless max.is_a?(Integer)
    raise "Max length (#{max}) is negative" if max.negative?
    raise "The gap doesn't implement to_s()" unless gap.respond_to?(:to_s)
    raise "Unsupported align: #{align}" unless %i[left center right].include?(align)
  end
end
