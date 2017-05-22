# Listing

## Requirements

* [Elixir and Phoenix](http://www.phoenixframework.org/docs/installation)
* a Postgres DB

## Running

- Run  `mix deps.get` to get dependencies from hex
- Configure the db connection inside listing/apps/listing_web/config/dex.exs and set the host and credentials  
`username: "postgres", 
 password: "passwd",  
 host: "host" 
`
- Create the table for the app and populate it with data: `mix ecto.setup`
- Start the server: ´mix phoenix.server´
- Open a browser and go to [http://localhost:4000](http://localhost:4000)
