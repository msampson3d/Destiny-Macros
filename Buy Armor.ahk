; ----------------------------------------------------------------------------------------------------
; A sloppy attempt at automating the process of generating legendary shards by buying and selling armor.
; This is heavily based on another script a helpful user made for creating mod components
; I HARDLY KNOW WHAT I'M DOING. I'm sure there are better ways to do some of this stuff. I'll improve
; it if the procedure continues to work.
;
; ----------------------------------------------------------------------------------------------------

; ---------------------------------------------DISCLAIMER---------------------------------------------
; This was only tested with Warlock, but the armor positions should be the same for all classes.
; Mouse coordinates likely need to be modified to work for anything other than 2560 x 1440
; Any area of the script that may need to be modified by you will be notated with @@@
; ---------------------------------------------DISCLAIMER---------------------------------------------

; --------------------------------------------REQUIREMENTS---------------------------------------------
; Max out on glimmer
; Make sure your helmet slot is empty. This script does the crafting in that slot only
; --------------------------------------------REQUIREMENTS---------------------------------------------

#NoEnv
#SingleInstance Force
#KeyHistory 0
SetBatchLines -1
ListLines Off
SendMode Input

; ctrl+r to reload the script if it is running and you have made and saved changes to it
^r::Reload

; stop the script
~*F3::
keep_running = n
return

; start the script
~*F2::
WinActivate, Destiny 2

WinGetPos, X, Y, Width, Height, Destiny 2
CoordMode, Mouse, Window

keep_running = y

loop {
     if keep_running = n
          return

     ; Open inventory
     Send, {F1}

     ; Hit previous to navigate collections tab
     Sleep, 800
     Send, {a}

     ; One more time
     Sleep, 500
     Send, {a}

     ; Random commands to prevent the command failure
     MouseMove, 50, 0, 50, R

	 ; Go to armor tab
     Sleep, 1800
     armor_x := 1200
     armor_y := 500
     MouseMove, %armor_x%, %armor_y%, 100
     Sleep, 1000
     Click, %armor_x%, %armor_y%

	 ; Go to Leveling category
	loop 7 {
		Sleep, 500
		Send, {s}
		if keep_running = n
          return
	}

	 ; Go to next page
     Sleep, 1000
     ; @@@ next_x val may need to be nudged based on your resolution @@@
     next_x := 2400
     next_y := 750
     MouseMove, %next_x%, %next_y%, 100
     Sleep, 500
     Click, %next_x%, %next_y%

     ; Buy 9 helmets
     loop 10 {
          Sleep, 500
          ; @@@ to_buy may need to be modified base on resolution @@@
          to_buy_x := 950
          to_buy_y := 1150
          MouseMove, %to_buy_x%, %to_buy_y%, 100
          Click, Down, %to_buy_x%, %to_buy_y%
          Sleep, 3400
          Click, Up

          if keep_running = n
               return
     }

     ; Navigate back to inventory
     Sleep, 300
     Send, {Esc}

     Sleep, 500
     Send, {d}

     Sleep, 500
     Send, {d}

     ; Move cursor to helmet
     Sleep, 1500
     ; @@@ to_dismantle may need to be modified based on resolution @@@
     to_dismantle_x := 1850
     to_dismantle_y := 350
     MouseMove, %to_dismantle_x%, %to_dismantle_y%, 100

     ; Move a bit to right side
     Sleep, 1300
     to_move_x := 2000
     to_move_y := %to_dismantle_y%
     MouseMove, %to_move_x%, %to_move_y%, 100

     ; Start loop over 9 times to dismantle all the helmets you made
     loop 10 {
          Sleep, 500

          Send, {f down}
          Sleep, 2000
          Send, {f up}

          if keep_running = n
               return
     }
     ; Exit Inventory. I recommend being at Master Rahool
     Send, {ESC}
     Sleep, 1000

}


return
