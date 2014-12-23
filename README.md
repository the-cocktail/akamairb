# Akamairb

Simple command-line tool for managing Akamai cache purges.

## Installation

Install it yourself as:

    $ gem install akamairb

## Usage

### Setup:

 Akamairb needs a special file `.akamai.yml` in your home directory.

 The format of the `.akamai.yml` file is pretty straighforward

     user: YOUR_USER
     pass: YOUR_PASSWORD

### Commands:
  
 * akamai help [COMMAND]  # Describe available commands or one specific command
 * akamai purge URLS      # purge urls from Akamai
 * akamai show ID         # show progress of a purge

### Params:

 * --debug                # Show raw response from akamai

## Contributing

1. Fork it ( http://github.com/<my-github-username>/akamairb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## THANKS

This tool is shamelessly inspired in Juan Lupion's [tacoma](https://github.com/pantulis/tacoma)
