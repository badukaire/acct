# extracts saldos from a balance report from p.py

F=$1
AA=`grep -n "==================" $F | tail -1 | cut -d: -f1`

  S=$AA

sed -n "$S,$ p" $F

