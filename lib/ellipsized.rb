# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Replaces part of the text with ellipsis.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2025 Yegor Bugayenko
# License:: MIT
class String
  # Truncates a string to specified maximum length, inserting ellipsis in the middle
  # if necessary. The resulting string will never be longer than the specified
  # maximum length. The original string is returned if it is already shorter than
  # or equal to the maximum length.
  #
  # @param [Integer] max The maximum length of the resulting string
  # @param [String] ellipsis The string to use as ellipsis (default: '...')
  # @return [String] The truncated string with ellipsis in the middle if necessary
  #
  # @example Basic usage with default parameters
  #   "Hello, world!".ellipsized
  #   # => "Hello, world!"
  #
  # @example Truncate a long string
  #   "This is a very long string that needs to be truncated".ellipsized(20)
  #   # => "This is...truncated"
  #
  # @example Custom ellipsis
  #   "Another very long string example".ellipsized(15, ellipsis: "***")
  #   # => "Anoth***example"
  #
  # @example Edge cases
  #   "".ellipsized      # => ""
  #   "Short".ellipsized # => "Short"
  #   "xyz".ellipsized(0) # => ""
  #   "xyz".ellipsized(2, ellipsis: "...") # => "xy"
  def ellipsized(max = 64, ellipsis: '...')
    return '' if empty?
    return self if length <= max
    return '' if max.zero?
    return self[0..max - 1] if ellipsis.length >= max

    head = tail = (max - ellipsis.length) / 2
    head += 1 if head + tail + ellipsis.length < max
    head = max if head > max
    "#{self[0, head]}#{ellipsis}#{self[length - tail..]}"
  end
end
