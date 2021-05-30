;- 04.06.2020 - : --- https://rmda.su ----------- __ --------------------;
;    _______  _/| __ ______    ____    ;;     ___/ /_____   ____  ____   ;
;   /  __   //  |/  \\   _  \ /    \   ;;   /  .  //  .  \/  ___//  . \  ;
;  /   _/ _//        \\  \\  \\  \  \  ;;  /  /  //  /  //  /   /  /  /  ;
;  \___\   \\___\/___//______//__/\__\ ;; |_____//  ___//__/    \____/   ;
;       \__/                           ;;       /__/                     ;
;----- intro 256 byte: "SNOWFLAKE16" ------ telegram: @dvitvitskiy ------;
        device zxspectrum48
table   equ #63
attr    equ #5800
cycle   equ 16
        org #6214 ; decrease if add code (use cls ? #6214 : #6222)
begin_file: ; self-documenting code
start:  push iy ; for returning to basic
        ; ld a, 5               ; cls
        ; ld hl,attr            ; cls
        ; ld de,attr + 1        ; cls
        ; ld bc,768 - 1         ; cls
        ; ld (hl),a             ; cls
        ; ldir                  ; cls
        ld c, 3
loop5:  ld b, cycle
loop4:  ld ix, fractal
        push bc
        call main    
        ld a, c
        rra
        call nc, main    
        ld a, (split+1)
        add 128 ; left or right fractal
        ld (split+1), a
        ld a, (grain+1)
        dec a
small   dec a
        ld (grain+1), a
        ld ixl, 4
        call main    
        ld a, c
        rra
        call c, main    
        pop bc
        djnz loop4
        xor a 
        ld (small), a
        ld (flash), a ; disable blinking after first iteration
        dec c
        jr nz, loop5
        pop iy
        ret ; end
main:   ld a,cycle
loop_i: dec a
        ld iyl, a
        ld b,cycle
loop_j: and %00010000 ; disable beeper - %00000000
        out (#fe),a
        ld a, b
        dec a
        ld iyh, a
flash   rra
        jr nc, grain
        ld hl,attr          ;        ld hl,attr+#c3
        ld de,attr + 1      ;        ld de,attr+#c3 + 1
        ld bc,768 - 1       ;        ld bc,442 - 1
        and %00000110
        add %01000001    ; bright -> true
        ld (hl),a
        ldir
grain:  ld a, 15
        and %00001111
        out (#fe),a
        inc a
        ld b, a
loop_k: push bc
        dec b
        ld a, b
        add ixl
        ld l, a
        ld h, table
        call coords     ; (hl) -> de
        ld bc, de       ; b = ky, c = kx
        ld a,iyh        ;
        ld l, a         ;
        call coords     ; (hl) -> de
        ld a, d         ;
        rla             ;
        rla             ;
        ld h, a         ;
        ld a, e         ;
        rla             ;
        rla             ;
        ld l, a         ;
        add hl, bc      ;
        ld bc, hl       ; 4 * j + k
        ld a, iyl       ;
        add ixl         ;
        ld l, a         ;
        ld h, table     ;
        call coords     ; (hl) -> de
        ld a, d         ;
        rla             ;
        rla             ;
        rla             ;
        rla             ;
        add b           ;
        ld d, a         ; y -> b = 16 * i + 4 * j + k
        ld a, e         ;
        rla             ;
        rla             ;
        rla             ;
        rla             ;
        add c           ;
split:  add 246         ;
        ld e, a         ; x -> c = 16 * i + 4 * j + k
        call point      ; D - y, E - x
        pop bc
        djnz loop_k
        ld a, iyh
        inc a
        ld b, a
        djnz loop_j
        ld a, iyl
        cp 0
        jr nz, loop_i    
        ret
point:  LD	A,#AF ; fast point: D - y, E - x
	SUB	D
	LD	D,A
	AND	A
	RRA
	SCF
	RRA
	AND	A
	RRA
	XOR	D
	AND	#F8
	XOR	D
	LD	H,A
	LD	A,E
	RLCA
	RLCA
	RLCA
	XOR	D
	AND	#C7
	XOR	D
	RLCA
	RLCA
	LD	L,A
        LD	A,E
	AND	#07
	LD	B,A
	INC	B
	LD	A,#FE
LOOP	RRCA
	DJNZ	LOOP	
	LD	B,#FF
	XOR	B
	LD	B,A
	LD	A,(HL)
	XOR	B
	LD	(HL),A
	RET	
coords: ld a, (hl)
        and %00001111
        ld d, a
        ld a, (hl)
        and %11110000
        rra
        rra
        rra
        rra
        ld e, a
        ret
        org table * #100 ; table must start at #00
fractal db #22, #52, #55, #25
fracta2 db #31, #63, #46, #14
        db #32, #53, #45, #24
        db #33, #43, #44, #34
        db #12, #26, #51, #65

end_file:
len_file equ end_file-begin_file

; pseudobasicaddr equ #FE00
; 		ORG pseudobasicaddr
; debugbasic                
; 		MODULE mai_bas		
; 		INCLUDE "pseudobasic.asm"
; 		ENDMODULE
; eofbasic

    display "code size: ", /d, len_file
    display "code start: ", /d, table * #100 - (len_file - 20)
    savesna "snow16.sna", begin_file
    savebin "snow16.C", begin_file, len_file
    savehob "snow16.$C", "snow16.C", begin_file, len_file

        include	 TapLib.asm
        MakeTape ZXSPECTRUM48, "snow16.tap", "snow16", begin_file, len_file, begin_file

;     EMPTYTAP "snow16.tap"
;     SAVETAP "snow16.tap",BASIC,"snow16",debugbasic,eofbasic-debugbasic,10
;     SAVETAP "snow16.tap",CODE,"snow16",begin_file, len_file
