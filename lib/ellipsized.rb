# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Replaces part of the text with ellipsis.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2025 Yegor Bugayenko
# License:: MIT
class String
  # @param [Integer] max The maximum length of the string, expected
  # @return [String] The text with ellipsis inside (if necessary)
  def ellipsized(max = 64)
    return '' if empty?
    return self if length <= max

    head = tail = (max - 3) / 2
    head += 1 if head + tail + 3 < max
    "#{self[0, head]}...#{self[length - tail..]}"
  end
end
