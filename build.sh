gcc -o lemon-js -O2 lemon-js.c
chmod +x lemon-js
./lemon-js examples/calculator-js.y

gcc -o lemon -O2 lemon.c
chmod +x lemon
./lemon examples/calculator-c.y
gcc -o examples/calculator-c -O2 examples/calculator-c.c
