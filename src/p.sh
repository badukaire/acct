#!/bin/bash

# TODO : check if git installed before running git command

ME=$0
[ $# -lt 1 ] && {
  echo "need to have at least a file descriptor (without .txt)"
  exit 1
}
FF=$1
[ $# -gt 1 ] && {
  DATE="-d $2"
  echo "using $2 as date range"
}

F_INIS=${FF}_saldoIni.txt
F_MOVS=${FF}.txt
F_OUT=${FF}_out.txt
F_BAL=${FF}_bal.txt
F_RPT=${FF}_rpt.txt

type git && {
  URL=`git remote -v | grep fetch | grep github | cut -f 2 | cut -d" " -f 1`
  echo "using code from ${URL}"
}

PP=`dirname $ME`
echo working on folder $PP

[ -f $F_MOVS ] || {
  echo "FATAL: transactions file $F_MOVS NOT found, aborting ..."
  exit 1
}
echo "processing transactions file $F_MOVS ..."

[ -f $F_INIS ] && {
  echo "using initial saldo file $F_INIS"
  echo "python $PP/p.py -i $F_INIS $DATE $F_MOVS"
  python $PP/p.py -i $F_INIS $DATE $F_MOVS | sed '1,/====/ d' >$F_OUT
  RES=$?
} || {
  echo "NOT using initial saldo file ($F_INIS not found)"
  echo "python $PP/p.py $DATE $F_MOVS"
  python $PP/p.py $DATE $F_MOVS | sed '1,/====/ d' >$F_OUT
  RES=$?
}

[ $RES -eq 0 ] || {
  echo "ERROR processing transactions file ${F_MOVS}, quitting ..."
  exit 1
}
echo "transactions file $F_MOVS processed OK"
echo "tmp output in $F_OUT"

bash $PP/b.sh $F_OUT >$F_BAL
echo "balance in $F_BAL"

bash $PP/r.sh $F_OUT >$F_RPT
echo "report in $F_RPT"

