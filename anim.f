\ colour management
variable r 1 cells allot
variable g 1 cells allot
variable b 1 cells allot
h# 0f0f r ! \ CGA colours
h# 0ff0 g ! \ CGA colours
h# 0fff b ! \ CGA colours
r @ g @ b @ colors

\ square sprite
variable sq 16 cells allot
variable sqframe 1 allot \ sprite current frame number
\ frame 0
h# ff81 sq !
h# 8181 sq 1 cells + !
h# 8181 sq 2 cells + !
h# 81ff sq 3 cells + !
\ frame 1
sq 1 cells + @ sq 4 cells + !
sq 2 cells + @ sq 5 cells + !
sq 3 cells + @ sq 6 cells + !
sq @ sq 7 cells + !
\ frame 2
sq 2 cells + @ sq 8 cells + !
sq 3 cells + @ sq 9 cells + !
sq @ sq 10 cells + !
sq 1 cells + @ sq 11 cells + !
\ frame 3
sq 3 cells + @ sq 12 cells + !
sq @ sq 13 cells + !
sq 1 cells + @ sq 14 cells + !
sq 2 cells + @ sq 15 cells + !

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

\ move sprite on button press TODO: smooth motion
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

\ draw blank sprite at current position
: blank-sprite ( -- )
    es spritedata \ blank sprite FIXME: overwriting with an empty sprite doesn't really feel like the best way to do this
    h# 41 sprite ;

\ draw square sprite given frame number
: animate-square ( -- )
    sqframe c@ 4 /mod nip cells sq + spritedata
    h# 41 sprite ;

\ animate colours
: cycle-colours ( -- )
    0 \ svector seems to expect some kind of input?
    r @ h# 111 + r !
    g @ h# 222 + g !
    b @ h# 333 + b !
    r @ g @ b @ colors
    blank-sprite
    x @ y @ position
    sqframe c@ 1+ 16 /mod drop sqframe c!
    animate-square ;

' move-it jvector
' cycle-colours svector
