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
  # @param [Array] args The mix of possible arguments passed to the method:
  #  [Integer] max The maximum length of the resulting string (default: 64)
  #  [String] gap The string to use as a gap (default: '...')
  #  [Symbol] align The alignment can be :left, :center, or :right
  #    (default: :center)
  #  Since the three arguments have different types, we can distinguish them by
  #  type. Based on that, the following permutations can be defined, 3! = 6:
  #    s.ellipsized(10, '...', :right)
  #    s.ellipsized(10, :right, '...')
  #    s.ellipsized('...', 10, :right)
  #    s.ellipsized('...', :right, 10)
  #    s.ellipsized(:right, '...', 10)
  #    s.ellipsized(:right, 10, '...')
  #  Keep in mind, any argument may be omitted:
  #    s.ellipsized(10, '...', :right)
  #    s.ellipsized(10, :right)
  #    s.ellipsized('...')
  #    s.ellipsized(10)
  #    s.ellipsized(:right)
  #  All of the above are valid use cases.
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
  def ellipsized(*args)
    raise "Unsupported number of arguments: #{args.length}" if args.length > 3

    max = gap = align = nil
    args.each do |arg|
      raise "Unsupported argument type: #{arg}" unless [
        Integer,
        String,
        Symbol
      ].include?(arg.class)

      case arg
      when Integer
        max = arg
        raise "Max length (#{max}) is negative" if max.negative?
        return '' if max.zero?
      when String
        gap = arg
      when Symbol
        align = arg
        raise "Unsupported align: #{align}" unless
          %i[left center right].include?(align) # rubocop:disable Performance/CollectionLiteralInLoop
      end
    end
    max ||= 64
    gap ||= '...'
    align ||= :center

    return '' if empty?
    return self if length <= max
    return self[0..(max - 1)] if gap.length >= max

    case align
    when :left
      "#{gap}#{self[(length - max + gap.length)..]}"
    when :center
      head = tail = (max - gap.length) / 2
      head += 1 if head + tail + gap.length < max
      head = max if head > max
      "#{self[0, head]}#{gap}#{self[-tail, tail]}"
    when :right
      "#{self[0, max - gap.length]}#{gap}"
    end
  end
end
