# Akashiyaki

Automation for AKASHI https://ak4.jp .

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'akashiyaki'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install akashiyaki

## Library

```rb
require "akashiyaki"

client = Akashiyaki::Client.new(company_id, login_id, password)
client.start_work
client.finish_work
client.start_break
client.finish_break
```

## CLI

Akashiyaki includes `ak4` command that is a CLI tool to access AKASHI.

Basic usage:

```bash
ak4 work start
ak4 work finish

ak4 break start
ak4 break finish
```

When `ak4` is given no account information, it asks you about your account:

```bash
$ ak4 work finish
Company ID: mycompany
Login ID: myid
Password: %
```

If you think it's too much bother to enter account information everytime,  you can save your account as a configuration file `~/.config/ak4/account.yaml` (or `~/.config/ak4/account.json`):

```yaml
company: mycompany
id: myid
password: mypassword
```

`ak4` reads account information from `$XDG_CONFIG_HOME` directory.

If you don't want to save your password, you can save only company ID and login ID:

```yaml
company: mycompany
id: myid
```

So `ak4` asks you about only password when executed.

You can also use command options:

```bash
Options:
      [--config=CONFIG]
  -c, [--company=COMPANY]
  -i, [--id=ID]
  -p, [--password=PASSWORD]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nownabe/akashiyaki.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
