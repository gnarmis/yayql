# Yayql

Simple SQL Templating helper inspired by [Yesql](https://github.com/krisajenkins/yesql)

This is very rough prototype, but it can do this:

- Convert a weirdly named SQL file into a standard underscored ruby method (or do nothing if filename is invalid or nonexistant).
- Handle arbitrary parameters by using standard ERB templating and allowing you to pass in parameters. No checking of anything!!! It's hilariously unsafe. But it works.

See the examples down below.

I've learned that the essential parts of an actually working system are:

- defining a flexible and safe way to fit values into holes in an almost-SQL file
- dealing with this concept of a bare connection and passing this connection value around as state; be stateless otherwise
- don't be very particular about the kinds of databases you can work with. Be general.

## Build

- Install deps: `bundle install`
- Prepare the DB: `cat db/prepare_users_table.sql | sqlite3 db/dev.db` (yeah, I know; it's a prototype)
- Clear the DB: `rm db/dev.db`

Use the `sqlite3` CLI tool to interact with the DB directly

## Play

Example 1:

```
$ pry -r'lib/yayql.rb'
> make_query('queries/get_users.sql')
> get_users(Engine.connection)
```

Example 2:

```
$ pry -r'lib/yayql.rb'
# > make_query('queries/get_users_2.sql')
# > get_users_2(Engine.connection, {name: "'Dave'")
```
