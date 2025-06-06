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
    assert_equal('Мо...?', 'Москва, спалённая пожаром, французу отдана?'.ellipsized(6))
    assert_equal('app...na', 'apple and banana'.ellipsized(8))
    assert_equal('пр...г!', 'привет, друг!'.ellipsized(7))
  end

  def test_simple_left
    assert_equal('', ''.ellipsized(64, '...', :left))
    assert_equal('apple', 'apple'.ellipsized(64, '...', :left))
    assert_equal('...на?', 'Москва, спалённая пожаром, французу отдана?'.ellipsized(6, '...', :left))
    assert_equal('...anana', 'apple and banana'.ellipsized(8, '...', :left))
    assert_equal('...руг!', 'привет, друг!'.ellipsized(7, '...', :left))
  end

  def test_simple_right
    assert_equal('', ''.ellipsized(64, '...', :right))
    assert_equal('apple', 'apple'.ellipsized(64, '...', :right))
    assert_equal('Мос...', 'Москва, спалённая пожаром, французу отдана?'.ellipsized(6, '...', :right))
    assert_equal('apple...', 'apple and banana'.ellipsized(8, '...', :right))
    assert_equal('прив...', 'привет, друг!'.ellipsized(7, '...', :right))
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

  def test_with_very_small_window_left
    assert_equal('', 'The Godfather'.ellipsized(0, '...', :left))
    assert_equal('T', 'The Godfather'.ellipsized(1, '...', :left))
    assert_equal('Th', 'The Godfather'.ellipsized(2, '...', :left))
    assert_equal('The', 'The Godfather'.ellipsized(3, '...', :left))
    assert_equal('...r', 'The Godfather'.ellipsized(4, '...', :left))
    assert_equal('...er', 'The Godfather'.ellipsized(5, '...', :left))
    assert_equal('...her', 'The Godfather'.ellipsized(6, '...', :left))
    assert_equal('...ther', 'The Godfather'.ellipsized(7, '...', :left))
    assert_equal('...ather', 'The Godfather'.ellipsized(8, '...', :left))
  end

  def test_with_very_small_window_right
    assert_equal('', 'The Godfather'.ellipsized(0, '...', :right))
    assert_equal('T', 'The Godfather'.ellipsized(1, '...', :right))
    assert_equal('Th', 'The Godfather'.ellipsized(2, '...', :right))
    assert_equal('The', 'The Godfather'.ellipsized(3, '...', :right))
    assert_equal('T...', 'The Godfather'.ellipsized(4, '...', :right))
    assert_equal('Th...', 'The Godfather'.ellipsized(5, '...', :right))
    assert_equal('The...', 'The Godfather'.ellipsized(6, '...', :right))
    assert_equal('The ...', 'The Godfather'.ellipsized(7, '...', :right))
    assert_equal('The G...', 'The Godfather'.ellipsized(8, '...', :right))
  end

  def test_with_empty_gap
    assert_equal('', 'Encapsulation'.ellipsized(0, ''))
    assert_equal('E', 'Encapsulation'.ellipsized(1, ''))
    assert_equal('En', 'Encapsulation'.ellipsized(2, ''))
    assert_equal('Enn', 'Encapsulation'.ellipsized(3, ''))
    assert_equal('Enon', 'Encapsulation'.ellipsized(4, ''))
    assert_equal('Encon', 'Encapsulation'.ellipsized(5, ''))
    assert_equal('Encion', 'Encapsulation'.ellipsized(6, ''))
  end

  def test_with_empty_gap_left
    assert_equal('', 'Encapsulation'.ellipsized(0, '', :left))
    assert_equal('n', 'Encapsulation'.ellipsized(1, '', :left))
    assert_equal('on', 'Encapsulation'.ellipsized(2, '', :left))
    assert_equal('ion', 'Encapsulation'.ellipsized(3, '', :left))
    assert_equal('tion', 'Encapsulation'.ellipsized(4, '', :left))
    assert_equal('ation', 'Encapsulation'.ellipsized(5, '', :left))
    assert_equal('lation', 'Encapsulation'.ellipsized(6, '', :left))
  end

  def test_with_empty_gap_right
    assert_equal('', 'Encapsulation'.ellipsized(0, '', :right))
    assert_equal('E', 'Encapsulation'.ellipsized(1, '', :right))
    assert_equal('En', 'Encapsulation'.ellipsized(2, '', :right))
    assert_equal('Enc', 'Encapsulation'.ellipsized(3, '', :right))
    assert_equal('Enca', 'Encapsulation'.ellipsized(4, '', :right))
    assert_equal('Encap', 'Encapsulation'.ellipsized(5, '', :right))
    assert_equal('Encaps', 'Encapsulation'.ellipsized(6, '', :right))
  end

  def test_with_replacement
    assert_equal(
      'This .. skip ..indow',
      'This story is very long to fit into a small window'.ellipsized(20, '.. skip ..')
    )
  end

  def test_with_replacement_left
    assert_equal(
      '.. skip ..all window',
      'This story is very long to fit into a small window'.ellipsized(20, '.. skip ..', :left)
    )
  end

  def test_with_replacement_right
    assert_equal(
      'This story.. skip ..',
      'This story is very long to fit into a small window'.ellipsized(20, '.. skip ..', :right)
    )
  end

  def test_arguments_permutations
    assert_equal('app...na', 'apple and banana'.ellipsized(8))
    assert_equal('app...na', 'apple and banana'.ellipsized(8, '...'))
    assert_equal('app...na', 'apple and banana'.ellipsized('...', 8))
    assert_equal('app...na', 'apple and banana'.ellipsized(8, :center))
    assert_equal('app...na', 'apple and banana'.ellipsized(:center, 8))
    assert_equal('app...na', 'apple and banana'.ellipsized(8, '...', :center))
    assert_equal('app...na', 'apple and banana'.ellipsized(8, :center, '...'))
    assert_equal('app...na', 'apple and banana'.ellipsized('...', 8, :center))
    assert_equal('app...na', 'apple and banana'.ellipsized('...', :center, 8))
    assert_equal('app...na', 'apple and banana'.ellipsized(:center, 8, '...'))
    assert_equal('app...na', 'apple and banana'.ellipsized(:center, '...', 8))
  end
end
