YOUR FIRST GEM

I started with just one Ruby file for my hola gem, and the gemspec. You’ll need a new name for yours (maybe hola_yourusername) to publish it. Check the Patterns guide for basic recommendations to follow when naming a gem.

% tree
.
├── hola.gemspec
└── lib
    └── hola.rb
Code for your package is placed within the lib directory. The convention is to have one Ruby file with the same name as your gem, since that gets loaded when require 'hola' is run. That one file is in charge of setting up your gem’s code and API.

The code inside of lib/hola.rb is pretty bare bones. It just makes sure that you can see some output from the gem:

% cat lib/hola.rb
class Hola
  def self.hi
    puts "Hello world!"
  end
end
The gemspec defines what’s in the gem, who made it, and the version of the gem. It’s also your interface to RubyGems.org. All of the information you see on a gem page (like jekyll’s) comes from the gemspec.

% cat hola.gemspec
Gem::Specification.new do |s|
  s.name        = 'hola'
  s.version     = '0.0.0'
  s.date        = '2010-04-28'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ["Nick Quaranto"]
  s.email       = 'nick@quaran.to'
  s.files       = ["lib/hola.rb"]
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license       = 'MIT'
end
The description member can be much longer than you see in this example. If it matches /^== [A-Z]/ then the description will be run through RDoc’s markup formatter for display on the RubyGems web site. Be aware though that other consumers of the data might not understand this markup.

Look familiar? The gemspec is also Ruby, so you can wrap scripts to generate the file names and bump the version number. There are lots of fields the gemspec can contain. To see them all check out the full reference.

After you have created a gemspec, you can build a gem from it. Then you can install the generated gem locally to test it out.

% gem build hola.gemspec
Successfully built RubyGem
Name: hola
Version: 0.0.0
File: hola-0.0.0.gem

% gem install ./hola-0.0.0.gem
Successfully installed hola-0.0.0
1 gem installed
Of course, the smoke test isn’t over yet: the final step is to require the gem and use it:

% irb
>> require 'hola'
=> true
>> Hola.hi
Hello world!
If you’re using an earlier Ruby than 1.9.2, you need to start the session with irb -rubygems or require the rubygems library after you launch irb.

Now you can share hola with the rest of the Ruby community. Publishing your gem out to RubyGems.org only takes one command, provided that you have an account on the site. To setup your computer with your RubyGems account:

$ curl -u qrush https://rubygems.org/api/v1/api_key.yaml >
~/.gem/credentials; chmod 0600 ~/.gem/credentials

Enter host password for user 'qrush':
If you’re having problems with curl, OpenSSL, or certificates, you might want to simply try entering the above URL in your browser’s address bar. Your browser will ask you to login to RubyGems.org. Enter your username and password. Your browser will now try to download the file api_key.yaml. Save it in ~/.gem and call it ‘credentials’

Once this has been setup, you can push out the gem:

% gem push hola-0.0.0.gem
Pushing gem to RubyGems.org...
Successfully registered gem: hola (0.0.0)
In just a short time (usually less than a minute), your gem will be available for installation by anyone. You can see it on the RubyGems.org site or grab it from any computer with RubyGems installed:

% gem list -r hola

*** REMOTE GEMS ***

hola (0.0.0)

% gem install hola
Successfully installed hola-0.0.0
1 gem installed
It’s really that easy to share code with Ruby and RubyGems.
