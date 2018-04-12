WRITING TESTS


Testing your gem is extremely important. Not only does it help assure you that your code works, but it helps others know that your gem does its job. When evaluating a gem, Ruby developers tend to view a solid test suite (or lack thereof) as one of the main reasons for trusting that piece of code.

Gems support adding test files into the package itself so tests can be run when a gem is downloaded.

In short: TEST YOUR GEM! Please!

Minitest is Ruby’s built-in test framework. There are lots of tutorials for using it online. There are many other test frameworks available for Ruby as well. RSpec is a popular choice. At the end of the day, it doesn’t matter what you use, just TEST!

Let’s add some tests to Hola. This requires adding a few more files, namely a Rakefile and a brand new test directory:

% tree
.
├── Rakefile
├── bin
│   └── hola
├── hola.gemspec
├── lib
│   ├── hola
│   │   └── translator.rb
│   └── hola.rb
└── test
    └── test_hola.rb
The Rakefile gives you some simple automation for running tests:

% cat Rakefile
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
Now you can run rake test or simply just rake to run tests. Woot! Here’s a basic test file for hola:

% cat test/test_hola.rb
require 'minitest/autorun'
require 'hola'

class HolaTest < Minitest::Test
  def test_english_hello
    assert_equal "hello world",
      Hola.hi("english")
  end

  def test_any_hello
    assert_equal "hello world",
      Hola.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "hola mundo",
      Hola.hi("spanish")
  end
end
Finally, to run the tests:

% rake test
(in /Users/qrush/Dev/ruby/hola)
Loaded suite
Started
...
Finished in 0.000736 seconds.

3 tests, 3 assertions, 0 failures, 0 errors, 0 skips

Test run options: --seed 15331
It’s green! Well, depending on your shell colors. For more great examples, the best thing you can do is hunt around GitHub and read some code.
