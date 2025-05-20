# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative '../lib/ellipsized'

# Test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2025 Yegor Bugayenko
# License:: MIT
class TestEllipsized < Minitest::Test
  def test_simple
    assert_equal('', ''.ellipsized)
    assert_equal('apple', 'apple'.ellipsized)
    assert_equal('Мо...а', 'Москва спаленная пожаром французу отдана'.ellipsized(6))
    assert_equal('app...na', 'apple and banana'.ellipsized(8))
    assert_equal('пр...г!', 'привет, друг!'.ellipsized(7))
  end
end
