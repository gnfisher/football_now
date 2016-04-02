# FootballNow

Football Now brings you all the information you need from top Football leagues in Europe.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'football_now'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install football_now

## Usage

## Installing PhantomJS

You need at least PhantomJS 1.8.1. There are no other external dependencies (you don't need Qt, or a running X server, etc.)

### Mac

  * Homebrew: `brew install phantomjs`
  * MacPorts: `sudo port install phantomjs`
  * Manual install: [Download this](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip)

### Linux

  * Download the [32 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2) or [64 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2) binary.
  * Extract the tarball and copy `bin/phantomjs` into your `PATH`

### Windows

  * Download the [precompiled binary](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip) for Windows

### Manual compilation

Do this as a last resort if the binaries don't work for you. It will take quite a long time as it has to build WebKit.

  * Download the [source tarball](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-source.zip)
  * Extract and cd in
  * `./build.sh`
  * (See also the [PhantomJS building guide](http://phantomjs.org/build.html).)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gnfisher/football_now.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO

 - Add ability to delete cached HTML pages
