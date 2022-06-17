# Mithraic-Events

Mithraic Events aims to provide a convenient and easy process for working with HTTParty and other facilities to help you in API testings.

## Installation

Add  Mithraic-Events to your `Gemfile`:

```bash
gem 'mithraic_events', '~> 0.1.1'
```

or

```ruby
gem 'mithraic_events'
```

Install:

```bash
bundle install
```

## Usage

GET

```bash
get("#{url_token}members/me/?key={{api_key}}&token={{token}}"
```

POST

```bash
post("{url_token}boards/?name=comaed&key={{api_key}}&token={{token}}&defaultLists=false")
```

PUT

```bash
put("{url_token}/cards/:id?idList={{doneListId}}&key={{trelloKey}}&token={{trelloToken}}")
```

PATCH

```bash
patch("{url_token}/checklists/:id/:field?value=bottom")
```

DELETE

```bash
delete("{url_token}/boards/:id?key={{trelloKey}}&token={{trelloToken}}")
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/callyca/mithraic_events>. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
