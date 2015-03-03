# Rails CAS Server

# Setup

Generate a Rails app and add to the Gemfile:

```
gem 'rails_cas_server', github: 'gregmolnar/rails_cas_server'

```

Then mount the engine to "/":

```
mount RailsCasServer::Engine, at: "/"
```

Then run the following command:

```
bin/rails g rails_cas_server:install
```

## Protocol

https://www.apereo.org/cas/protocol

## Licence

This project uses MIT-LICENSE.
