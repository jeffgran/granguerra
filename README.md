Wedding website

to get csv of guests:

    $ heroku pg:psql

    psql> \copy guests to 'out.csv' csv header
