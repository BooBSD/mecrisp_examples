\ MSP430 version
\ basis definitions needed

compiletoflash

100 constant delay	\ in ms

: nc ( name ) ( n1 n2 n3...nn n -- ) <builds dup allot 1+ 1 do here i - cflash! loop does> + c@ ;

binary

01000010	\ A
10000100	\ B
10100100	\ C
10000011	\ D
00000001	\ E
00100100	\ F
11000011	\ G
00000100	\ H
00000010	\ I
01110100	\ J
10100011	\ K
01000100	\ L
11000010	\ M
10000010	\ N
11100011	\ O
01100100	\ P
11010100	\ Q
01000011	\ R
00000011	\ S
10000001	\ T
00100011	\ U
00010100	\ V
01100011	\ W
10010100	\ X
10110100	\ Y
11000100	\ Z

decimal

26 nc letters

binary

11111101	\ 0
01111101	\ 1
00111101	\ 2
00011101	\ 3
00001101	\ 4
00000101	\ 5
10000101	\ 6
11000101	\ 7
11100101	\ 8
11110101	\ 9

decimal

10 nc digits

: led-on ( -- ) 1 p1out cbis! ;
: led-off ( -- ) 1 p1out cbic! ;

: dot ( -- ) led-on delay ms led-off delay ms ;
: dash ( -- ) led-on delay 3 * ms led-off delay ms ;

: msend ( mask -- )
  dup 7 and 0 do
    dup 128 i rshift and if
      dash
    else
      dot
    then
  loop drop delay 2 * ms ;
: mspace ( char -- ) drop delay 6 * ms ;
: mdigit ( char -- ) 48 - digits msend ;
: mletter ( char -- ) 65 - letters msend ;
: memit ( char -- )
  dup 32 = if
    mspace
  else
    dup 47 > over 58 < and if
      mdigit
    else
      32 bic dup 64 > over 91 < and if
        mletter
      then
    then
  then ;
: morse ( -- ) cr ." Type a message and press Enter: "
  query 10 parse
  cr ." Sending morse code... "
  dup c@ 0 do
    1+ dup c@ dup emit memit
  loop drop ;

compiletoram
