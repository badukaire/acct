# acct : a text-based accounting script

Small python script for the accounting of small communities (or
even businesses). It can be used to know how much money each person
owns to each other on a trip, or in a sports-office team.

The input consists of columnized text with the amount, date and 
debit and credit accounts. See format and accounts below.

The output is a balance with the detailed saldos for each account and
also account categories.

A balance can be used as input for the script so it is considered
as the initial balance for a set of movements, so that the movements
and balances are registered monthly, weekly or yearly.

It is also possible to specify a date range of the movements to
process and ignore those beyond it.

The script has been designed with the expectation of being able
to be used from a web form.

Note: this script was started to be written before knowing
that a similar and indeed more mature project called
[plain text accounting](http://plaintextaccounting.org/)
and [ledger](http://ledger-cli.org/) existed.

## usage

It is best to use the script from a wrapper shell script called `p.sh` :

```bash
$ python /path/to/script/p.sh ourTrip
```

This will look for a file called `ourTrip.txt` (`.txt` extension
added) containing the movements, will process them, and leave the
output balance in a file name `ourTrip_bal.txt`. The parameter
*ourTrip* is the _descriptor_ of the accounting set, and input
and output names are based upon it.


## advanced usage

With the above example it is possible to start accounting. 

There are a few other features that can be useful.

In case a file named `ourTrip_saldoIni.txt` exists, it will be
read and used as the initial saldo. This file has to be in
the same format as the balance file (the output), so that it
is easy to reuse balances of previous time periods.

In case you want to specify the date range of the movements, do 
it after the descriptor, like this :

```bash
$ python /path/to/script/p.sh ourTrip 2016-10
```

This would process only the movements in the file from October
1st to October 31st, 2016.

The date range can be given as the year, the year and month, and year
month and date. It is possible to give 2 dates separating them
with a colon. When 2 dates are given they have to be in the same format.

Some examples of date ranges (hopefully self-explanatory) could
be : 2016, 2016-04, 2016-04:2016-05, 2016-04-02:2016-04-08


# the accounts

Since this is an accounting script, the concept of accounts is
required. Each account has a type and an identifier. The type is
1 letter and an underscore ('\_'), and is the prefix of the
account name. For example, *C_SHARED* is an account of type 
'C' (cash) and identifier 'SHARED'.

## account types

The account types allowed by the script are as follows:

- **C** : Cash
- **I** : Income
- **X** : eXpenses
- **D** : Debts (unpaid transactions)
- **S** : Stock
- **Z** : external record (unrelated to the group)

For each one of these account types, a balance including all
the accounts of the same type is calculated. This way it is
possible to know the amount of remaining cash, how much has
been spent, how much money has come in ...


# input formats

There are 2 type of file formats, one for the movements and
another for the balance. In both formats, the content after
a hash sign ('\#') is ignored and can be used as comments.
Blank lines are also ignored, therefore both comment and
blank lines are encouraged to improve readability.

# items format

Each line on the files is formed by *items* or
components. Each one has a well-defined format:

* accounts : the account name, as described above, with
a max lenght of 12. Example : `S_TEAM`
* amounts : positive floating-point number with 2 decimal
figures. On the balance file may be of course negative).
Examples: 80.00, -3.21
* date : yyyy-mm-dd, the dates are specified up to the
day, in ISO format

The first item must be in column 1 of the line, the others
have more flexibility.


## movements file

The movements file contains blank-separated items
that are, in this order:

* debit account
* credit account
* amount
* date (optional)

Each item must be in its format. The recommended positions
are:

* credit account : column 13
* amount decimal dot : column 32
* date : column 37

Example lines:

```
D_MARC      I_ANNA           40.00  2016-06-19 # Anna pays Marc's meal
```



## balance file

This file is both output and input, and as such its output can
be reused as input (initial balance) for another set of
movements. The balance file has another type of unused line,
lines starting with the equal sign ('\='). The generated
balance files have one at both the start and end of file

The format is the account name, followed by at least 1 blank,
then a colon, followed by at least 1 blank, and then the amount.

```
S_TEAM      :   -180.00
```

As in the example above, it is recommended that the colon
is in column 13, and the decimal dot on column 21. Lines
with different positions may be read but it is not
guaranteed.


# helper tools

There is a script to improve the alignment and therefore
the readability of a movements file. It can even help turn 
readable a non-readable movement file.

The script is called `r.sh`. It modifies the input file, so
make sure to make a copy if you are unsure about losing data.



## TODO list

this is the TODO list, there may be more embedded in the scripts

[ ] use transaction instead of movement in doc
[ ] use transaction instead of movement in scripts
[ ] script for formatting a badly formatted movements file
[ ] script for formatting a badly formatted saldo file
[ ] generate categories balance (income/expenses/cash)
[ ] add several simple test samples
[ ] try displaying initial output with config and info (sed)
[ ] make mov date optional

