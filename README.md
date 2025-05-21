# Adds a `.ellipsized` method to `String`

[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/ellipsized)](https://www.rultor.com/p/yegor256/ellipsized)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![rake](https://github.com/yegor256/ellipsized/actions/workflows/rake.yml/badge.svg)](https://github.com/yegor256/ellipsized/actions/workflows/rake.yml)
[![PDD status](https://www.0pdd.com/svg?name=yegor256/ellipsized)](https://www.0pdd.com/p?name=yegor256/ellipsized)
[![Gem Version](https://badge.fury.io/rb/ellipsized.svg)](https://badge.fury.io/rb/ellipsized)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/ellipsized.svg)](https://codecov.io/github/yegor256/ellipsized?branch=master)
[![Yard Docs](https://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/github/yegor256/ellipsized/master/frames)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/ellipsized)](https://hitsofcode.com/view/github/yegor256/ellipsized)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/ellipsized/blob/master/LICENSE.txt)

It makes a string fit into a required length by replacing
part of it in the middle with an ellipsis:

```ruby
require 'ellipsized'
puts 'Hello, dear world!'.ellipsized(16)
```

Prints:

```text
Hello, ...world!
```

You can also specify the ellipsis:

```ruby
puts 'How are you doing?'.ellipsized(14, ellipsis: '.. skip ..')
```

Prints:

```text
Ho.. skip ..g?
```

That's it.

## How to contribute

Read
[these guidelines](https://www.yegor256.com/2014/04/15/github-guidelines.html).
Make sure your build is green before you contribute
your pull request. You will need to have
[Ruby](https://www.ruby-lang.org/en/) 3.0+ and
[Bundler](https://bundler.io/) installed. Then run:

```bash
bundle update
bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.
