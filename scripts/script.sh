#!/bin/sh

LANG="Shell"

echo "Content-Type: text/html"
echo ""
echo "<html><head><title>$LANG</title></head><body><h1>Hello world!</h1><p>I am a $LANG Script :)</p></body></html>"
echo ""
echo "<h2>Ls in root dir:</h2>"
echo "<pre>$(ls -lah /)</pre>"