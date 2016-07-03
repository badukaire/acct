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


## usage

It is best to use the script from a wrapper shell script called `p.sh` :

```bash
$ python /path/to/script/p.sh myTrip
```

This will look for a file called `myTrip.txt` containing the
movements, will process them, and leave the output balance in a
file name `myTrip_bal.txt`. The parameter *myTrip* is the
_descriptor_ of the accounting and input and output names
are based on it.


## advanced usage

With the above example it is possible to start accounting. 

There are a few other features that can be useful.

In case a file named `myTrip_saldoIni.txt` exists, it will be
read and used as the initial saldo. This file has to be in
the same format as the balance file (the output), so that it
is easy to reuse balances of previous time periods.

In case you want to specify the date range of the movements, do 
it after the descriptor, like this :

```bash
$ python /path/to/script/p.sh myTrip 2016-10
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
used.

## account types

blah


# input formats

blah


# helper tools

blah



## TODO list

this is the TODO list, there may be more embedded in the scripts

[ ] script for formatting a badly formatted movements file
[ ] script for formatting a badly formatted saldo file
[X] generate report (income/expenses/cash)
[ ] add several simple test samples
[ ] try displaying initial output with config and info (sed)

