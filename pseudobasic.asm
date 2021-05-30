;10 INK PI:PAPER BIN:BORDER VAL "7":CLEAR VAL "25107"
;20 FOR A=23232 TO 23295:POKE A,3:NEXT A
;30 POKE VAL","23739",CODE "o";suppress to show tape headers on scr
;50 LOAD "PBD00-CODE" CODE:RANDOMIZE USR VAL "16384"

;255 REM EOF

;10 INK PI:PAPER BIN:BORDER VAL "7":CLEAR VAL "25107"
;------------------
		DB 0,10
		DW estrbas4-strbas4
strbas4 
		;DB #EA
		DB #D9,#A7,#3A,#DA,#C4,#0E,0,0,0,0,0,":"
		DB #E7,#B0,#22,"7",#22,":"
		DB #FD,#B0,#22,"25107",#22
		DB #D;INK PI:PAPER BIN:BORDER VAL "7":CLEAR VAL "25107"
estrbas4
;15 FOR A=22528 TO 23295:POKE A,3:NEXT A
		DB 0,20
		DW estrbas25-strbas25
strbas25
		DB #EB,"A=23232",#0E,0,0
		DW #5AC0
		DB 0,#CC,"23295",#0E,0,0
		DW #5AFF
		DB 0,#3A,#F4,"A,3",#0E,0,0,3,0,0,#3A
		DB #F3,"A",#D
estrbas25		
;------------------
;20 POKE VAL","23739",CODE "o";suppress to show tape headers on scr
		DB 0,30
		DW estrbas18-strbas18
strbas18
		;DB #EA
		DB #F4,#B0,#22,"23739",#22,",",#AF,#22,"o",#22,#D
estrbas18

;------------------

;50 LOAD "sflake16" CODE:RANDOMIZE USR VAL "25108"		
		DB 0,50
		DW estrbasba1-strbasba1
strbasba1 
		DB #EF,#22,"snow16",#22,#AF,#3A
		;DB #EA;REM
		DB #F9,#C0,#B0,#22,"25108",#22,#D
estrbasba1

;------------------
;REM EOF
		DB 0,255
		DW estrbas11-strbas11
strbas11 DB #EA,"EOF",#D
estrbas11

		DB #80,#D
