\ MSP430 version
\ Basis definitions needed!
\ Exemple for PIR motion sensor

compiletoflash

8 constant PIR			\ Port P1.3

: ?motion ( -- )
  PIR p1ifg cbit@ if		\ IRQ port test
    PIR p1ifg cbic!		\ Reset IRQ flag
    PIR p1ies cbit@ if		\ IRQ front test
      ." NO MOTION"
    else
      ." MOTION!"
    then cr PIR p1ies cxor!	\ Toggle IRQ front
  then
;

: init ( -- )
  init				\ Init previous init
  eint				\ Global IRQ enable
  PIR p1ie cbis!		\ Enable IRQ for PIR port
  ['] ?motion irq-port1 !	\ Insert IRQ hook
;

compiletoram
