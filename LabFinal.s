				area lab10_variables, data, readwrite
	
; -----GLOBAL VARIABLES-----
; A variable that keeps track of which easter eggs have been found
; 0x00 - none
; 0x01 - dresser
estr_egg		dcb 0x00

; A variable that keeps track of where the key is
; 0x00 - found
; 0x01 - dresser_top_random
; 0x02 - dresser_drawers_top_shirts
; 0x03 - dresser_drawers_top_pants
; 0x04 - dresser_drawers_bottom
; 0x05 - bed_over_jacket
; 0x06 - bed_over_blankets
; 0x07 - bed_under
key_loc			dcb 0x00

fail_tms		dcb 0x00

				area lab10, code, readonly

; global constants
talk_speed		dcd 0x10000		; 0x10000
sys_speed		dcd 0x10000		; 0x15000

; ----SCRIPT-----
; global text
no_key_msg		dcb "No keys.", 0x00
key_found_msg0	dcb "You found the", 0x00
key_found_msg1	dcb "keys!", 0x00
key_found_msg2	dcb "You head off to", 0x00
key_found_msg3	dcb "get to your", 0x00
key_found_msg4	dcb "class on time.", 0x00

; [MDL_entry] text
tst_string0		dcb "You enter your", 0x00
tst_string1		dcb "room...", 0x00
tst_string2		dcb "\"Crap I'm gonna ", 0x00
tst_string3		dcb "be late if I    ", 0x00
tst_string4		dcb "can't find my   ", 0x00
tst_string5		dcb "keys!\"", 0x00

; [MDL_chs] text
chs_msg0		dcb "Where would like", 0x00
chs_msg1		dcb "to check?", 0x00
chs_mnu			dcb "A:dresser  B:bed", 0x00

; [MDL_drsr] text
drsr_msg		dcb "A dresser...", 0x00
drsr_mnu		dcb "A:top  B:drawers", 0x00
drsr_t_msg0		dcb "There are a", 0x00
drsr_t_msg1		dcb "bunch of books", 0x00
drsr_t_msg2		dcb "and random crap.", 0x00
drsr_t_mnu		dcb "A:random crap", 0x00
drsr_t_a_msg0	dcb "There are some", 0x00
drsr_t_a_msg1	dcb "index cards and", 0x00
drsr_t_a_msg2	dcb "meaningless", 0x00
drsr_t_a_msg3	dcb "knick-knacks.", 0x00
drsr_t_b_msg_a0	dcb "It looks like", 0x00		; once you find the behind dresser easter egg
drsr_t_b_msg_a1	dcb "there's something", 0x00
drsr_t_b_msg_a2	dcb "behind the", 0x00
drsr_t_b_msg_a3	dcb "dresser...", 0x00
drsr_t_b_msg_a4	dcb "You move it", 0x00
drsr_t_b_msg_a5	dcb "aside.", 0x00
drsr_t_b_msg_a6	dcb "There is dog.", 0x00
drsr_t_b_msg_a7	dcb "\"bark.\"", 0x00
drsr_t_b_msg_a8	dcb "\"am dog.\"", 0x00
drsr_t_b_msg_a9	dcb "\"salutations.\"", 0x00
drsr_t_b_msg_b0	dcb "No dog anymore.", 0x00		; after you've found the behind dresser easter egg
drsr_d_msg0		dcb "There are two", 0x00
drsr_d_msg1		dcb "drawers, one on", 0x00
drsr_d_msg2		dcb "top and one", 0x00
drsr_d_msg3		dcb "below.", 0x00
drsr_d_mnu		dcb "A:top   B:bottom", 0x00
drsr_d_t_msg0	dcb "There are shirts", 0x00
drsr_d_t_msg1	dcb "and pants folded", 0x00
drsr_d_t_msg2	dcb "and stacked in  ", 0x00
drsr_d_t_msg3	dcb "the drawer.", 0x00
drsr_d_t_mnu	dcb "A:shirts B:pants", 0x00
drsr_d_t_s_msg0	dcb "You check under ", 0x00
drsr_d_t_s_msg1	dcb "the stacks of   ", 0x00
drsr_d_t_s_msg2	dcb "shirts.", 0x00
drsr_d_t_p_msg0	dcb "You check in    ", 0x00
drsr_d_t_p_msg1	dcb "between some of ", 0x00
drsr_d_t_p_msg2	dcb "the pants.", 0x00
drsr_d_b_msg0	dcb "So scandalous...", 0x00
drsr_d_b_msg1	dcb "This drawer is  ", 0x00
drsr_d_b_msg2	dcb "full of socks.", 0x00

; [MDL_bed] text
bed_msg0		dcb "Your bed. You've", 0x00
bed_msg1		dcb "always regretted", 0x00
bed_msg2		dcb "getting green   ", 0x00
bed_msg3		dcb "sheets.", 0x00
bed_mnu			dcb "A:over   B:under", 0x00
bed_o_msg0		dcb "Your jacket is  ", 0x00
bed_o_msg1		dcb "laying crumpled ", 0x00
bed_o_msg2		dcb "on the bed.", 0x00
bed_o_mnu		dcb "A:jckt  B:blnkts", 0x00
bed_o_j_msg0	dcb "You check all   ", 0x00
bed_o_j_msg1	dcb "the pockets...", 0x00
bed_o_b_msg0	dcb "You throw your  ", 0x00
bed_o_b_msg1	dcb "blankets on the ", 0x00
bed_o_b_msg2	dcb "floor in a      ", 0x00
bed_o_b_msg3	dcb "hurry.", 0x00
bed_u_msg0		dcb "You get on your ", 0x00
bed_u_msg1		dcb "knees to check  ", 0x00
bed_u_msg2		dcb "under your bed..", 0x00

tst_string6		dcb " YOU WIN        ", 0x00
tst_string7		dcb " CONGRATS!      ", 0x00

lose_msg0		dcb "Looks like you  ", 0x00
lose_msg1		dcb "ran out of time.", 0x00
lose_msg2		dcb "You'll never get", 0x00
lose_msg3		dcb "to class on time", 0x00
lose_msg4		dcb "now...", 0x00

tst_string8		dcb " YOU LOSE       ", 0x00
tst_string9		dcb " ...OOPS!       ", 0x00
				
				export __main
				
				; -----REGISTER VALUES-----
				; r0 holds the DATA PORT OFFSET for the LCD
				; r1 holds the EXTRA PORT OFFSET for the LCD
				; r2 holds the INPUT PORT OFFSET for receiving the buttons
				; r5-r7 are used for passing variables into functions
				; r10 and r11 are used for the basic text speeds
				; r12 is used for returning values out of functions
			
__main			proc
				
				; initial set up
				bl BTN_init
				bl LCD_init
				
				; establish the global values
				mov r5, #0x00
				mov r6, #0x00
				mov r7, #0x00
				ldr r10, =talk_speed
				ldr r11, =sys_speed
				
				ldr r3, =estr_egg
				mov r4, #0x00
				strb r4, [r3]
				
				ldr r3, =key_loc
				mov r4, #0x03
				strb r4, [r3]
				
				ldr r3, =fail_tms
				mov r4, #0x00
				strb r4, [r3]
				
				; begin main segment
				bl MDL_entry
				
				mov r5, #0x00
				bl LCD_clrln
				mov r5, #0x01
				bl LCD_clrln
				
tst_lbl			bl MDL_chs
				
				mov r5, #0x00
				bl LCD_clrln
				mov r5, #0x01
				bl LCD_clrln
				
				bl inpt_wait
				
				ldr r3, =fail_tms
				ldr r4, [r3]

				cmp r4, #0x04
				beq fail
				
				ldr r3, =key_loc
				ldr r4, [r3]
				cmp r4, #0x00
				bne tst_lbl
				
				; YOU WIN message
				ldr r5, =tst_string6
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string7
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				b stay
				
fail			; YOU LOSE message
				ldr r5, =lose_msg0
				ldr r6, [r10]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =lose_msg1
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =lose_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =lose_msg2
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =lose_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =lose_msg3
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =lose_msg3
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =lose_msg4
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr

				ldr r5, =tst_string8
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string9
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
stay 			b stay

				endp
				ltorg
				

; [MDL_entry] stands for MODULE entry. This
; is the function that handles the entrance of
; the room.
MDL_entry		function
				push {r3, r4, lr}
				
				; setting message
				ldr r5, =tst_string0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				
				mov r5, #0x00
				bl LCD_clr
				
				; starting dialogue
				; "Crap I'm gonna be late if I can't find my keys!"
				ldr r5, =tst_string2
				ldr r6, [r10]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string3
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =tst_string3
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string4
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =tst_string4
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =tst_string5
				ldr r6, [r10]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				
				pop {r3, r4, lr}
				bx lr
				endp
				ltorg

MDL_chs			function
				push {r3, r4, lr}
				
				ldr r5, =chs_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =chs_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; display menu
				ldr r5, =chs_msg1		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =chs_mnu			; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
			
				;  actual logic
chs0			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq chs1					; jump to option TOP
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq chs2					; jump to option DRAWERS
				
				bne chs0					; if not pressed
				
chs1			bl LCD_clr
				bl MDL_drsr
				b chs_end
				
chs2			bl LCD_clr
				bl MDL_bed
				
chs_end			pop {r3, r4, lr}
				bx lr
				endp

; [MDL_dresser] stands for MODULE dresser. This
; is the function that handles going to the
; dresser.
MDL_drsr		function
				push {r3, r4, lr}
				
				; Display dresser startup message
				ldr r5, =drsr_msg
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				bl inpt_wait
				
				; top or drawers
				;  display menu
				ldr r5, =drsr_mnu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
			
				;  actual logic
drsr0			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq drsr_t0					; jump to option TOP
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq.w drsr_d0				; jump to option DRAWERS
				
				bne drsr0					; if not pressed
				
				; top
				;  display message
drsr_t0			bl LCD_clr
				ldr r5, =drsr_t_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				;  display menu
				ldr r5, =drsr_t_msg2		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_mnu			; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				;  actual logic
drsr_t1			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq drsr_t_a0				; jump to option RANDOM CRAP
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq drsr_t_b0				; jump to HIDDEN OPTION
				
				bne drsr_t1					; if not pressed
				
				; top A
drsr_t_a0		bl LCD_clr
				ldr r5, =drsr_t_a_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_a_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_a_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_a_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_a_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_a_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x01
				bl chk_key
				pop {r5}
				b drsr_end
				
				; top B (easter egg)
				;  check for easter egg
drsr_t_b0		ldr r3, =estr_egg			; check for easter egg values
				ldr r4, [r3]
				and r4, #0x01				; mask for the dresser easter egg specifically
				cmp r4, #0x00
				beq drsr_t_b_a0				; jump to option NOT FOUND YET
				
				ldr r3, =estr_egg			; check for easter egg values
				ldr r4, [r3]
				and r4, #0x01				; mask for the dresser easter egg specifically
				cmp r4, #0x01
				beq.w drsr_t_b_b0			; jump to option ALREADY FOUND

				b lskip0
				ltorg
lskip0			
				
				;  easter egg not found yet
drsr_t_b_a0		bl LCD_clr
				ldr r5, =drsr_t_b_msg_a0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a3
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a4
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a4
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a5
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a5
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a6
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a6
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a7
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a7
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a8
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				ldr r5, =drsr_t_b_msg_a8
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_t_b_msg_a9
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; SET DRSR_EGG TO 0x01
				ldr r3, =estr_egg
				ldr r4, [r3]
				orr r4, #0x01
				str r4, [r3]
				
				; -----PATH END-----
				bl inpt_wait
				b drsr_end
				
				;  easter egg already found
drsr_t_b_b0		bl LCD_clr
				ldr r5, =drsr_t_b_msg_b0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				; -----PATH END-----
				bl inpt_wait
				b drsr_end
				
				; top_drawer or bottom_drawer
				;  display message
drsr_d0			bl LCD_clr
				ldr r5, =drsr_d_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				;  display menu
				ldr r5, =drsr_d_msg3		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_mnu			; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				;  actual logic
drsr_d1			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq drsr_d_t0				; jump to option TOP DRAWER
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq.w drsr_d_b0				; jump to option BOTTOM DRAWER
				
				bne drsr_d1					; if not pressed
				
				; top_drawer
drsr_d_t0		bl LCD_clr
				ldr r5, =drsr_d_t_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_t_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_t_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				;  display menu
				ldr r5, =drsr_d_t_msg3		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_mnu		; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				;  actual logic
drsr_d_t1		ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq drsr_d_t_s0				; jump to option SHIRTS
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq drsr_d_t_p0				; jump to option PANTS
				
				bne drsr_d_t1				; if not pressed
				
				; shirts
drsr_d_t_s0		bl LCD_clr
				ldr r5, =drsr_d_t_s_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_s_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_t_s_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_s_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x02
				bl chk_key
				pop {r5}
				b drsr_end
				
				; pants
drsr_d_t_p0		bl LCD_clr
				ldr r5, =drsr_d_t_p_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_p_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_t_p_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_t_p_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x03
				bl chk_key
				pop {r5}
				b drsr_end
				
				; bottom_drawer
drsr_d_b0		bl LCD_clr
				ldr r5, =drsr_d_b_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_b_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =drsr_d_b_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =drsr_d_b_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x04
				bl chk_key
				pop {r5}
				b drsr_end
				
				
drsr_end		pop {r3, r4, lr}
				bx lr
				endp
				ltorg
				
MDL_bed			function
				push {r3, r4, lr}
				
				ldr r5, =bed_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; display menu
				ldr r5, =bed_msg2		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_mnu		; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
			
				;  actual logic
bed0			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq bed_o0					; jump to option OVER
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq.w bed_u0				; jump to option UNDER
				
				bne bed0					; if not pressed
				ltorg
				
bed_o0			bl LCD_clr
				ldr r5, =bed_o_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_o_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; display menu
				ldr r5, =bed_o_msg2		; previous line
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_mnu		; actual menu
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
			
				;  actual logic
bed_o1			ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x20				; mask for button A specifically
				cmp r3, #0x00
				beq bed_o_j0				; jump to option JACKET
				
				ldr r3, [r2, #0x00]			; check for button inputs
				and r3, #0x10				; mask for button B specifically
				cmp r3, #0x00
				beq bed_o_b0				; jump to option BLANKETS
				
				bne bed_o1					; if not pressed
				
bed_o_j0		bl LCD_clr
				ldr r5, =bed_o_j_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_j_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x05
				bl chk_key
				pop {r5}
				b drsr_end

bed_o_b0		bl LCD_clr
				ldr r5, =bed_o_b_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_b_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_o_b_msg1
				mov r6, 0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_b_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_o_b_msg2
				mov r6, 0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_o_b_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x06
				bl chk_key
				pop {r5}
				b drsr_end
				
bed_u0			bl LCD_clr
				ldr r5, =bed_u_msg0
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_u_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl LCD_clr
				
				ldr r5, =bed_u_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =bed_u_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				bl inpt_wait
				bl LCD_clr
				
				; -----PATH END-----
				bl inpt_wait
				push {r5}
				mov r5, 0x07
				bl chk_key
				pop {r5}
				b bed_end
				
bed_end			pop {r3, r4, lr}
				bx lr
				endp

; [LCD_string] prints out a whole string of characters to
; the LCD screen on a particular line.
;  - r5 should be passed the base address in memory for the
;    string of characters.
;  - r6 should be passed the amount of delay to use
;    in-between displaying characters
;  - r7 should be passed which line to write the string to
;    (0 for top, 1 for bottom)
LCD_string		function
				push {r3, r4, lr}
				
				push {r5}
				mov r5, #0xC0
				bl LCD_cmd
				pop {r5}
				
				cmp r7, #0x00
				bne LCD_string0
				
				push {r5}
				mov r5, #0x80
				bl LCD_cmd
				pop {r5}
			
LCD_string0		ldrb r3, [r5], #0x01
				
				push {r5}
				mov r5, r3
				bl LCD_data
				pop {r5}
				
				ldrb r4, [r5]
				cmp r4, #0x00
				bne LCD_string0
				
				bl cleanup
				pop {r3, r4, lr}
				bx lr
				endp

; [LCD_clr] clears the whole LCD screen.
LCD_clr			function
				push {r5, lr}
				
				mov r5, #0x01
				bl LCD_cmd
				
				pop {r5, lr}
				bx lr
				endp

; [LCD_clrln] clears a single line on the LCD screen.
;  - r5 should be passed which line to be cleared
;    (0 for top, 1 for bottom)
LCD_clrln		function
				push {r3, r4, lr}
				
				mov r3, #0x80
				cmp r5, #0x00
				beq LCD_clrln0
				mov r3, #0xC0				; if r5 signals the bottom line
			
LCD_clrln0		push {r5}
				mov r5, r3
				bl LCD_cmd
				pop {r5}
				
				mov r4, #0x00
			
LCD_clrln1		push {r5}
				mov r5, #0x20
				bl LCD_data
				pop {r5}
				
				add r4, #0x01
				cmp r4, #0x10
				bne LCD_clrln1
				
				pop {r3, r4, lr}
				bx lr			
				endp

; [inpt_wait] is just a function that pauses the
; program until the player presses button A.
inpt_wait		function
				push {r3, r4, lr}
				
xx				ldr r3, [r2, #0x00]
				and r3, #0x20
				cmp r3, #0x00
				bne xx
				
				pop {r3, r4, lr}
				bx lr
				endp
					
; [chk_key] is a function that checks whether the
; player finds the keys or not. If they do, it will
; play the found keys dialogue and set =key_loc to
; FOUND.
;  - r5 should be passed the location flag for
;    wherever the player is at currently. This
;    will be checked against the =key_loc
;    global variable to see whether the keys
;    are in the given location.
chk_key			function
				push {r3, r4, r9, lr}
				
				ldr r3, =key_loc
				ldr r4, [r3]
				
				and r9, r5, r4				; mask the given location with the key location
				cmp r9, r4
				bne chk_key0				; if they aren't the same, skip to the end
				
				; set =key_loc to 0x00
				bic r4, #0xFF
				str r4, [r3]
				
				; play found keys messages
				push {r5}
				mov r5, #0x00
				bl LCD_clr
				ldr r5, =key_found_msg0		; 0-4
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =key_found_msg1
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				mov r5, #0x00
				bl LCD_clr
				
				ldr r5, =key_found_msg1
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =key_found_msg2
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				mov r5, #0x00
				bl LCD_clr
				
				ldr r5, =key_found_msg2
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =key_found_msg3
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				
				mov r5, #0x00
				bl LCD_clr
				
				ldr r5, =key_found_msg3
				mov r6, #0x00
				mov r7, #0x00
				bl LCD_string
				
				ldr r5, =key_found_msg4
				ldr r6, [r11]
				mov r7, #0x01
				bl LCD_string
				pop {r5}
				
				bl inpt_wait
				b chk_key_end
				
chk_key0		bl LCD_clr
				ldr r5, =no_key_msg
				ldr r6, [r11]
				mov r7, #0x00
				bl LCD_string
				
				ldr r3, =fail_tms
				ldr r4, [r3]
				add r4, #0x01
				str r4, [r3]
				
				bl inpt_wait
				
chk_key_end		pop {r3, r4, r9, lr}
				bx lr
				endp

; [BTN_init] initializes port 2 pins 2.4 and 2.5 to be INPUTS.
; These two pins should be wired up to buttons so we can
; receive user input.
BTN_init		function
				push {r3, lr}
				
				ldr r2, =0x40004C00
				add r2, #0x01
				
				mov r3, #0x00				; X X 0 0  X X X X = 0x00
											; Button A: 2.5 (mask of 0x20)
											; Button B: 2.4 (mask of 0x10)
				
				strb r3, [r2, #0x04]
				
				pop {r3, lr}
				bx lr
				endp

; [LCD_init] initializes ports 4 and 5 for use in controlling
; the LCD. After that, it sets up some initial settings,
; turns the LCD on, then clears the screen.
LCD_init		function
				push {r2, r3, lr}
				
				ldr r0, =0x40004C00			; Get the base address of GPIO pins
				add r0, #0x21				; Offsets us to the Port 4 base address (DATA PORT)
				
				ldr r1, =0x40004C00
				add r1, #0x40				; Offsets us to the Port 5 base address (EXTRA PORT)
				
				mov r2, #0xFF				; 1 1 1 1  1 1 1 1 = 0xFF
				mov r3, #0xFF				; 0 0 0 0  0 1 1 1 = 0x07
											; ENABLE = 5.2
											; RW     = 5.1
											; RS     = 5.0
											; 0 1 0 1  1 0 0 0 = 0x58
				
				strb r2, [r0, #0x04]		; Store the value(0xFF) to P4(DATA PORT) DATA DIRECTION BYTE
				strb r3, [r1, #0x04]		; Store the value(0x07) to P5(EXTRA PORT) DATA DIRECTION BYTE
				
				push {r5}
				mov r5, #0x38				; 8-bit data with 2 lines and a 5x7 character matrix
				bl LCD_cmd
				
				mov r5, #0x0E				; Turn on display and set cursor to blink
				bl LCD_cmd
				
				mov r5, #0x01				; Clears the LCD screen
				bl LCD_cmd
				pop {r5}
				
				pop {r2, r3, lr}
				bx lr
				endp
			

; [LCD_cmd] is a useful function that sends a given command to
; the LCD display.
;  - r5 should be passed the command to send to the LCD
LCD_cmd			function
				push {r3, r4, lr}
				
				bl chk_bf
				
				mov r3, #0x04				; 0  0  0  0   0  1  0  0 = 0x04 (1 to ENABLE)
											;                 E  RW RS
				
				strb r5, [r0, #0x02]		; send the command to the LCD
				strb r3, [r1, #0x02]		; set ENABLE to high
				
				push {r5}
				mov r5, #0x100
				bl delay
				pop {r5}
				
				mov r3, #0x00				; 0 0 0 0  0 0 0 0 = 0x00 (0 to ENABLE)
				strb r3, [r1, #0x02]
				
				pop {r3, r4, lr}
				bx lr						; return
				endp


; [LCD_data] is a useful function that sends a given ASCII
; character to the LCD and displays it.
;  - r5 should be passed the character to write to the
;    LCD screen.
;  - r6 should be passed the amount of time to delay
;    before writing the character
LCD_data		function
				push {r3, r4, lr}
				
				mov r4, #0x100				; the default delay amount
				cmp r6, #0x00				; check whether someone has passed in a delay value
				beq LCD_data0
				mov r4, r6
			
LCD_data0		bl chk_bf
				
				mov r3, #0x05				; 0 0 0 0  0 1 0 1 = 0x05 (1 to ENABLE)
				strb r5, [r0, #0x02]
				strb r3, [r1, #0x02]
				
				push {r5}
				mov r5, r4
				bl delay
				pop {r5}
				
				mov r3, #0x01				; 0 0 0 0  0 0 0 1 = 0x01 (0 to ENABLE)
				strb r3, [r1, #0x02]
				
				pop {r3, r4, lr}
				bx lr
				endp

; [chk_bf] initially meant to check the LCD's
; BUSY FLAG. No longer does that, instead just
; implements a short delay that accounts for
; the LCD's implementation time.
chk_bf			function
				push {r3, r4, r12, lr}
				
				push {r5}
				mov r5, #0x500
				bl delay
				pop {r5}
				
				pop {r3, r4, r12, lr}
				bx lr						; return
				
				endp

; [delay] is a really basic delay function
;  - r5 should be passed the number to count down
;    from over the course of the function.
delay			function
				push {r3, lr}
				
				mov r3, r5					; some big number for the delay
			
delay0			sub r3, #0x01
				cmp r3, #0x00				; if (r3 - 0) is not equal to 0...
				bne delay0					; ...repeat the loop
				
				pop {r3, lr}
				bx lr						; otherwise go back to where we left off
				endp

cleanup			mov r5, #0x00
				mov r6, #0x00
				mov r7, #0x00
				bx lr

				end