# omnis hello-world
helloworld.lbs is a (very) simple [Omnis Studio](https://www.omnis.net) library which can be used as the basis of an application using the Platform Independent Systems' [infrastructure](https://github.com/PISL/omnis-infra) library.

### Dependencies

[Omnis Studio 8.1](https://www.omnis.net) or later

The [omnis-infra](https://github.com/PISL/omnis-infra) library.

A PostgreSQL installation with two databases named helloworld and stb.  The first holds the data for the application and the second a basic set of string table entries to test the application. These databases can be created by running the [helloworld.sql](db/helloworld.sql) script against your Postgres instance.

NB.  The above databases come from a PostgreSQL 11 instance.

### Installation

Clone the [omnis-infra](https://github.com/PISL/omnis-infra) repository.

Clone this repository.

Copy the infra and helloworld libraries to your desired location (or [import from JSON](src)).

Copy the [helloworld](lib/helloworld.libini) file to the same location as the helloworld library.

Create the database from the [SQL script](db/helloworld.sql).

`psql -h dbServer -p port -d dbToConnectTo -U userName -a -f /path/to/helloworld.sql`

The SQLite [initialisation database](lib/helloworld.libini) is set up to expect the application databases to be running on localhost port 5432.  If this differs from your installation, you will need to open the file with an SQLite DB tool or an Omnis SQL Browser session and edit the appropriate rows:

```
update inidb set db_value = 'YourPgServer' where db_key = 'Host';
update inidb set db_value = portnumber where db_key = 'port'
```

### Usage
- Open infra.lbs
- Modify the initial value of local variables lcUserName and lcPassword in tkSuper.$buildStringTable() to "console" and "cxcxcxc" respectively.
- Open helloworld.lbs
- To try the remote forms, select rjsBusinessApp and "Test Form"

NB. There is a document [here](https://github.com/PISL/omnis-infra/blob/master/resources/How_rjsInfraMenu_works.md) which gives an overview of the jsClient menu system that we use in the forms.

