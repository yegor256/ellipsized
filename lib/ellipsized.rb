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
  # @param [String] gap The string to use as gap (default: '...')
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
  #   "Another very long string example".ellipsized(15, gap: "***")
  #   # => "Anoth***example"
  #
  # @example Edge cases
  #   "".ellipsized      # => ""
  #   "Short".ellipsized # => "Short"
  #   "xyz".ellipsized(0) # => ""
  #   "xyz".ellipsized(2, gap: "...") # => "xy"
  def ellipsized(max = 64, gap: '...')
    raise "Max length must be an Integer, while #{max.class.name} provided" unless max.is_a?(Integer)
    raise "Max length (#{max}) is negative" if max.negative?
    return '' if empty?
    return self if length <= max
    return '' if max.zero?
    return self[0..max - 1] if gap.length >= max

    head = tail = (max - gap.length) / 2
    head += 1 if head + tail + gap.length < max
    head = max if head > max
    "#{self[0, head]}#{gap}#{self[length - tail..]}"
  end
end
