\ colour management
variable r 1 cells allot
variable g 1 cells allot
variable b 1 cells allot
h# 0f0f r ! \ CGA colours
h# 0ff0 g ! \ CGA colours
h# 0fff b ! \ CGA colours
r @ g @ b @ colors

\ square sprite
variable sq 4 cells allot
h# ff81 sq !
h# 8181 sq 1 cells + !
h# 8181 sq 2 cells + !
h# 81ff sq 3 cells + !
sq spritedata

\ position management
variable x 1 cells allot
variable y 1 cells allot
200 x !
200 y !
x @ y @ position

\ empty sprite for clearing screen
variable es 4 cells allot
0 es !
0 es 1 cells + !
0 es 2 cells + !
0 es 3 cells + !

\ move sprite on button press
: move-it ( -- )
    0 \ jvector seems to expect some kind of input?
    jbutton
    dup h# 10 < if
      drop
    else
      dup h# 10 = if \ up
        y @ 10 - y !
      then
      dup h# 20 = if \ down
        y @ 10 + y !
      then
      dup h# 40 = if \ left
        x @ 10 - x !
      then
      dup h# 80 = if \ right
        x @ 10 + x !
      then
      drop
    then ;

\ animate colours
: cycle-colours ( -- )
    es spritedata \ FIXME: overwriting with an empty sprite doesn't really feel like the best way to do this
    h# 41 sprite
    sq spritedata
    0 \ svector seems to expect some kind of input?
    r @ h# 111 + r !
    g @ h# 222 + g !
    b @ h# 333 + b !
    r @ g @ b @ colors
    x @ y @ position
    h# 41 sprite ;

' move-it jvector
' cycle-colours svector
