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

  def test_with_very_small_window
    assert_equal('', 'The Godfather'.ellipsized(0))
    assert_equal('T', 'The Godfather'.ellipsized(1))
    assert_equal('Th', 'The Godfather'.ellipsized(2))
    assert_equal('The', 'The Godfather'.ellipsized(3))
    assert_equal('T...', 'The Godfather'.ellipsized(4))
    assert_equal('T...r', 'The Godfather'.ellipsized(5))
    assert_equal('Th...r', 'The Godfather'.ellipsized(6))
    assert_equal('Th...er', 'The Godfather'.ellipsized(7))
    assert_equal('The...er', 'The Godfather'.ellipsized(8))
  end

  def test_with_replacement
    assert_equal(
      'This .. skip ..indow',
      'This story is very long to fit into a small window'.ellipsized(20, ellipsis: '.. skip ..')
    )
  end
end
