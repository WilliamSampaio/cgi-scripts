#!/bin/sh

echo "Content-Type: text/html"
echo ""
echo "<html><body><h1>Hello world!</h1><p>I am a SHELL Script :)</p></body></html>"
echo ""
echo "<h2>Ls in root dir:</h2>"
echo "<pre>$(ls -lah /)</pre>"