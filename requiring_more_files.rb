REQUIRING MORE FILES

Having everything in one file doesn’t scale well. Let’s add some more code to this gem.

% cat lib/hola.rb
class Hola
  def self.hi(language = "english")
    translator = Translator.new(language)
    translator.hi
  end
end

class Hola::Translator
  def initialize(language)
    @language = language
  end

  def hi
    case @language
    when "spanish"
      "hola mundo"
    else
      "hello world"
    end
  end
end
This file is getting pretty crowded. Let’s break out the Translator into a separate file. As mentioned before, the gem’s root file is in charge of loading code for the gem. The other files for a gem are usually placed in a directory of the same name of the gem inside of lib. We can split this gem out like so:

% tree
.
├── hola.gemspec
└── lib
    ├── hola
    │   └── translator.rb
    └── hola.rb
The Translator is now in lib/hola, which can easily be picked up with a require statement from lib/hola.rb. The code for the Translator did not change much:

% cat lib/hola/translator.rb
class Hola::Translator
  def initialize(language)
    @language = language
  end

  def hi
    case @language
    when "spanish"
      "hola mundo"
    else
      "hello world"
    end
  end
end
But now the hola.rb file has some code to load the Translator:

% cat lib/hola.rb
class Hola
  def self.hi(language = "english")
    translator = Translator.new(language)
    translator.hi
  end
end

require 'hola/translator'
Gotcha: For newly created folder/file, do not forget to add one entry in hola.gemspec file, as shown-

% cat hola.gemspec
Gem::Specification.new do |s|
...
s.files       = ["lib/hola.rb", "lib/hola/translator.rb"]
...
end
without the above change, new folder would not be included into the installed gem.

Let’s try this out. First, fire up irb:

% irb -Ilib -rhola
irb(main):001:0> Hola.hi("english")
=> "hello world"
irb(main):002:0> Hola.hi("spanish")
=> "hola mundo"
We need to use a strange command line flag here: -Ilib. Usually RubyGems includes the lib directory for you, so end users don’t need to worry about configuring their load paths. However, if you’re running the code outside of RubyGems, you have to configure things yourself. It’s possible to manipulate the $LOAD_PATH from within the code itself, but that’s considered an anti-pattern in most cases. There are many more anti-patterns (and good patterns!) for gems, explained in this guide.

If you’ve added more files to your gem, make sure to remember to add them to your gemspec’s files array before publishing a new gem! For this reason (among others), many developers automate this with Hoe, Jeweler, Rake, Bundler, or just a dynamic gemspec .

Adding more directories with more code from here is pretty much the same process. Split your Ruby files up when it makes sense! Making a sane order for your project will help you and your future maintainers from headaches down the line.
