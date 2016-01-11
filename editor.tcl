#!/usr/bin/tclsh

#exec  wish "$0" ${1+ "$@"}

#package require Tcl 8.5
#package require Tk
#package require Thread
#package require sqlite3
set run_Directory [file join [pwd] [file dirname [info script]]]   
lappend auto_path [file dirname [info script] ]
# option of main window 
set windowparams {
    title "Scheduler & Planner"
    minsize {800 600}
    resizable {1 1}
}
# user configuration of main window
set userconfig {
    menubar yes
}
# procedure  of menu -  
proc newFile { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc planing { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc RoadMap { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc includeDB { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc openFile { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc newProject { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc merge_prj { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc dell_prj { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc login { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc sStatus { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}

proc copy { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc cut { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc paste { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc dell { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc chooseLenguage { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc spellChecker { } {
	tk_messageBox -message "This is empty procedure - soon it will be work "
}
proc about { } {
    tk_messageBox -message "Simple application for easy typing text reports \n  Code by Mike Bily ( 2014 ) \n  "
}
proc help { } {
    tk_messageBox -message " Hot keys :
     ctrl + a - select all
     ctrl + c - copy selected
     ctrl + v - insert from booffer
     ctrl + h - deletes string after curssor
     When you tiping you can use  arrows\n  - Key-down go to listbox dictionary\n  - Key-left to choose from dictionary listbox
     Enter or Double-button-1 choose from list box by selected position "
}
# when you will choose from menu wich report do you whant to see - you will get text template spesialy for your choise
proc chooseTemplate { temlatenumber } {
	global frameText
	global infoConsol 	 ; # консоль выполнения действий 	
	set date(start) [clock seconds]
	set date(date) [clock format $date(start) -format %D]
	set date(time24) [clock format $date(start) -format %H]
	set date(dayY) [clock format $date(start) -format %j]
	set date(nMonth) [clock format $date(start) -format %m]
	set date(time) [clock format $date(start) -format %T]
	set date(nWeek) [clock format $date(start) -format %W]
	set date(nDayWeek) [clock format $date(start) -format %u]
	set date(year) [clock format $date(start) -format %Y]
	set date(workDOrNot) work
	$frameText  delete 1.0 end  ; # clear text pane
	$infoConsol delete 1.0 end  ; # clear console pane
			#tk_messageBox -message "temlatenumber=$temlatenumber"
	if { $temlatenumber == 1 || $temlatenumber == 5 } {
			$infoConsol insert insert "\[$date(time24)\] -> Chose: Dayly \n"		    
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(dayY) (d/y) - $date(nWeek) (w/y)\n$date(date)\n\t\t\t Dayly raport:\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"	
	}
	if { $temlatenumber == 2 || $temlatenumber == 5 } {
			$infoConsol insert insert "\[$date(time24)\] -> Chose: Weekly \n"
			$frameText insert insert    "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(dayY) (d/y) - $date(nWeek) (w/y)\n$date(date)\n\t\t\t Weekly Plans:\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"	
	}
	if { $temlatenumber == 3 || $temlatenumber == 5} {
		 $infoConsol insert insert   "\[$date(time24)\] -> Chose: Plans Weekly \n"
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(nDayWeek).w - $date(nMonth).m $date(year).y\n\t\t\t Week plans: \n\t\t\n\n\t Task 1) ... priority (P0) ... subscription ... {}     \n\nInProgress from previous week:\n\nProblems:  \n"
	}
	if { $temlatenumber == 4 || $temlatenumber == 5} {
		 $infoConsol insert insert   	"\[$date(time24)\] -> Chose: Plans \n"
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(nMonth).m $date(year).y\n\t\t\tMonth plans:\n\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"
	}
		
		
}
# read dictionary global "wDictList"
set run_Directory [file join [pwd] [file dirname [info script]]]   ; # path to directory where was run application editor
set file_Dir [file join $run_Directory wordsFromFile ]   ; #
set file_path [file join $file_Dir en_GB_my.dic ]

#tk_messageBox -message "$file_path"
if { ! [ catch { open $file_path r } fId ] } {
	    global wDictList
	    #tk_messageBox -message "all ok fole opened"
	    set count 0
	    foreach line [split [read $fId] \n] {
			lappend wDictList $line
			# puts "$count $line"
			incr count
	    }
	    close $fId
	    #tk_messageBox -message "$wDictList"
	} else {
		tk_messageBox -message "Error: $fId \n May be $file_path is busy or upsen."
	}
# setting up menu
set menu {
	File {
        "New file" {
            -command newFile
        }
        "Open file" {
            -command openFile
        }
        "Include DB" {
            -command includeDB
        }
        "RoadMap" {
            -command RoadMap
        }
        "Planing file" {
            -command planing
        }
        Exit {
            -command exitProc
        }
    }
    Project {
        "Create new project" {
            -command newProject
        }
        "Merge projects" {
            -command merge_prj
        }
        DeletePrj {
            -command dell_prj
        }
    }
    Connection {
        "Log in" {
            -command login
        }
        "Log out" {
            -command logout
        }
        "Send status" {
            -command sStatus
        }
        "Send status" {
            -command sStatus
        }
    }
    Edit {
        Copy {
            -command copy
        }
        Paste {
            -command paste
        }
        Cut {
            -command cut
        }
        Delete {
            -command dell
        }
    }
    View {
        "Language" {
            -command chooseLenguage
        }
        SpellChecker {
            -command spellChecker
        }
        "Console tcl " {
            -command {exec tclsh }
        }
        "Standart editor" {
            -command spellChecker
        }
        "Show editor console" {
            -command {exec tclsh}
        }
    }
    Tools {
        Template_dayly {
            -command {chooseTemplate 1}

        }
	Template_wekly {
            -command {chooseTemplate 2}

        }
        Template_weklyPlans {
            -command {chooseTemplate 3}
        }
        Template_month_plans {
            -command {chooseTemplate 4}
        }
        Template_All {
            -command {chooseTemplate 5}
        }
    }
    Help {
        About {
            -command about
        }
        Help {
            -command help
        }
    }
    -name menu
}
# window setupe
proc setup-window {w params} {
    wm title $w [dict get $params title]
    wm resizable $w {*}[dict get $params resizable]
    wm minsize $w {*}[dict get $params minsize]
}
#	pin menu to window \
menu -  dictionary contans menu's setupe\
w    -  main window \
args -   \ 
#frame .menu_frame -borderwidth 5
#pack  .menu_frame -side top -fill x 
 
proc build-menu {menu w args} {
    dict with args {
        set options [dict filter $menu key -*]
        if {[dict exists $options -command]} {
            $w add command -command [dict get $options -command] -label $label
        } else {
            if {[dict exists $options -name]} {
                set name [dict get $options -name]
            }
            set m [menu $w.$name]
            foreach {k v} $menu {
                if {![string match -* $k]} {
                    build-menu $v $m label $k name [incr i]
                }
            }
            if {[llength $args]} {
                $w add cascade -menu $m -label $label
            } else {
                $w configure -menu $m
            }
            return $m
        }
    }
    $w config -activebackground white -activeforeground blue 
}

# old proc - depricated
proc  getListByMask { srclist mask } {
    global filteredList
    set filteredList [ lsearch -all -inline $srclist $mask ]
    return $filteredList
 }
proc findWordsFromList { maska} {
    global wDictList
    global lb
    global frameText
    global wordStruct
    global filteredList
    global topframe 	 ; # верхний фрайм
    #set maska_ 
    set mas [string tolower $maska]
    append  mas *
    #set filteredList_ [ lsearch -all -inline $wDictList $mas ]
    set filteredList [lsort [ lsearch -all -inline $wDictList $mas ]]  			;# mach list
    if { [llength $filteredList] > 0 } {
    	# size creates listbox  
    	# if listbox item < 28 - autosize
    	# else creates listbox 28x28chars
    	if {[llength $filteredList] < 28} {
    		set lb [ listbox $frameText.s -foreground blue	 -bg white -height 0 -width 0  ]
    		} else {
    			set lb [ listbox $frameText.s -foreground blue	 -bg white -height 28 -width 28 ]		
    		}
    	
		$lb insert 0 "w = [llength $filteredList] - \[press arrow down \]"
		# coordinates where to plase listbox
		place $lb -x [expr {$wordStruct(coordX) + 15 }] -y [expr {$wordStruct(coordY) + 25}] 
		set count 0
		foreach item $filteredList {
			incr count
			$lb insert $count "$count. $item "
        }
		bind $frameText <Key-Down> { focus $lb}
		bind $frameText <Key-space>   {  destroy $lb ; bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} }    
		bind $lb <Key-Right>   {focus $frameText ;  set check [ $lb curselection]; cleverComplite $check ; after 5 {destroy $lb}   }
		bind $lb <Key-Return>   {  set check [ $lb curselection]; cleverComplite $check ; destroy $lb   }
		bind $lb <Double-Button-1>   {  set check [ $lb curselection] ;   cleverComplite $check ; destroy $lb    }
		bind $lb <Key-Escape>   {focus $frameText  }
		bind $lb <Key-space>   {focus $frameText ;  set check [ $lb curselection]; cleverComplite $check ; after 5 {destroy $lb}   }
	}
}
# procedure compliter
# compliting next part of word \
when chosed word from list box  it printed to text from firs char of word - after first part of word was deleted\
choosing from listbox : Enter, Double-button-1, arrow-right,\
discard list box : space , escape
# rOneWord numder of listbox row
proc cleverComplite { rOneWord } {
    global filteredList
    global frameText
    global wordStruct
    global topframe
    global lb
    set varSh $wordStruct(charIndex)
   # tk_messageBox -message "$varSh $wordStruct(charPosition) $wordStruct(charLinePosition) [$frameText index 1.0]- [ string length $wordStruct(word)]"
    #set i [ $frameText index "insert - 1 lines"]
    set sh  [expr { $wordStruct(charPosition) - [ string length $wordStruct(word)] } ]
    set sh [expr { $sh - 1}]
    if { $rOneWord == 0  } {
	focus $frameText
	#after 1 { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
	bind $frameText  <Key-Left>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
	#bind $topframe  <Key-Return>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
	bind $frameText <Key-space> {}
	bind $frameText <Key-Down> {}
	bind $frameText  <Key-Left> {}
	bind $frameText <Key-Return> {}

    } 
    # number of row != 0 
    if { $rOneWord > 0  } {
    	#tk_messageBox -message wordstart
    	#kill first chars of word
     $frameText delete "insert - [ string length $wordStruct(word)] char"  insert
     set insertWordFromLb [lindex $filteredList [ expr {$rOneWord - 1}]  ]
     $frameText insert  insert $insertWordFromLb
     #tk_messageBox -message
     focus $frameText
     bind $topframe  <Key-Left>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
     bind $frameText <Key-Down> {}
     bind $topframe  <Key-Left> {}
     
    } 
    
}

#keyboard handler
# winHendle - path to text
# largs     - list of args \
# largs 0	    - %K  \ 
# largs 1	    - %A  \
# largs 2	    - %x  \
# largs 3	    - %W  \

set wordStruct(prevChar) {}
set wordStruct(lwords) {}
set wordStruct(prevCharPosition) {}
set wordStruct(charPosition) {}
set wordStruct(charLinePosition) {}
set wordStruct(coordX) {}
set wordStruct(coordY) {}
set wordStruct(curSymPos) {}
set wordStruct(endSymPos) {}

proc textHendler { winHendle largs  } {
	global  stringCounter
	global  infoConsol
	global  infoConsol2
	global  frameText
	global  lb
	#--
	global wordStruct			; # array -info about word
	set wordStruct(char) {}			; # to clear
	set wordStruct(word) {}			; # to clear
	set wordStruct(charPosition) {}		; # to clear
	set wordStruct(firstCharWord) {}	; # to clear
	set wordStruct(coordX) {}
    set wordStruct(coordY) {}
	set wordStruct(curSymPos) {}
	set wordStruct(endSymPos) {}
	set wordStruct(charIndex) {}
	#--tk_messageBox -message $frameText	
	# delete listbox from text
	if {[ info exists lb ]} { destroy $lb
	    bind $frameText	<Key-space> {}
	    bind $frameText	<Key-Up> {}
	    bind $frameText	<Key-Down> {}
	}
	# hendle  non char symbol
	# clear console text
	$infoConsol delete 1.0 end
	# service information	
	$infoConsol insert insert  "K=[lindex $largs 0] A=[lindex $largs 1] x=[lindex $largs 2] W=[lindex $largs 3]" ; # test message
	set a [$winHendle bbox insert] 
	set wordStruct(coordX) [lindex $a 0]
	set wordStruct(coordY) [lindex $a 1]
	$infoConsol insert insert "\ncoord of char: wordStruct(coordX) = $wordStruct(coordX) , wordStruct(coordY)= $wordStruct(coordY)\n"
    	# chars or symbols
	if {  [ regexp {[\w]}  [lindex $largs 1] matchCh]  } {
	    # curren number of symbol in the string
	    set wordStruct(charPosition)     [ lindex [split [$winHendle index insert] .] 1 ]
	    # get current number of string 
	    set wordStruct(charLinePosition) [ lindex [split [$winHendle index insert] .] 0 ]
	    set wordStruct(char) [lindex $largs 1]
	    #test  
	    $infoConsol insert insert "\n -> line: wordStruct(charLinePosition) = $wordStruct(charLinePosition)"
	    #end test 
	    if {$wordStruct(charPosition) == 0 } {
		    set wordStruct(word) $wordStruct(char)
		    $infoConsol insert insert " stringLine :  -> $wordStruct(word)  \t"
		} else {
		    for { set i 0  } { $i < $wordStruct(charPosition) } { incr i }  {
		    # get string from the begining to current symbol 
		    set stringLine [ $winHendle get  "insert linestart" insert]
		    # get symbol before current symbol
		    set var [ $winHendle get  "insert -[expr {$i + 1}] char"]
		    #test  
		    $infoConsol insert insert "$stringLine : $var -> $wordStruct(charPosition) -- $i \t"
		    #end test 
		    # if symbol is not char
		    if {  [ regexp {\W} $var ss ]  } {
		        set var1 [ $winHendle get  "$wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]"  insert ]
			#end test 
			set wordStruct(charIndex) [ expr { [ expr { $wordStruct(charPosition)- $i } ] - 0 } ]
		        set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
			$infoConsol insert insert "\nwordStruct(word)--+-- $wordStruct(word)"
			#main call for working with list from dictionary
			findWordsFromList $wordStruct(word)
		        break
		    }
		    # if we gets to begin of string 
		    if { $i == [ expr { $wordStruct(charPosition) - 1 }  ]  } {
			set var1 [ $winHendle get  "insert linestart"  insert ]
			set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
		        $infoConsol insert insert "\nfrom line start--+-> $wordStruct(word) "		
		    }
		 if { $wordStruct(word) != ""  } {
		    #set wordStruct(startPosition) [ $wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]]
			set wordStruct(endPosition) [$winHendle index insert]
			#main call for working with list from dictionary
		    findWordsFromList $wordStruct(word)
		       
		    }
		}
		
	    }
	    set wordStruct(firstCharWord) [ regexp { [^\w ] } $wordStruct(word) mmatch1]
	    $infoConsol insert insert " word: [ $winHendle get "insert wordstart" "insert wordend"] ( [$winHendle index "insert wordstart"] [$winHendle index insert] [$winHendle index  "insert wordend"]  )  $wordStruct(charPosition) $wordStruct(firstCharWord)"
	    #$infoConsol insert insert "[ $winHendle sget -text  ]"
	    set	wordStruct(prevChar) $wordStruct(char)     ; # 
	}
	# обработка печатных символов 	  
	if { ! [ regexp {[A-Za-z0-9]}  [lindex $largs 1] matchCh]  } {
		set wchar [lindex $largs 0]
	    	$infoConsol insert end " $wchar"
		set Tab Tab
		if { $wchar == $Tab } {
		    $infoConsol insert end " \[ [$winHendle index insert]\]$wchar ----!!!!"
		}
		
	    }

} 
#----------------------------------------------------------------------------------------------------
# init of application
proc initW {} { 

	global windowparams  ; # windows property
	global userconfig    ; # user configuration
	global menu 		 ; # 
	global topframe 	 ; # 	
	global slaveframe	 ; # 
	global infoConsol 	 ; # console
	global infoConsol2 	 ; # aditional console
	global stringCounter ; # щетчик строк или для дополнительных изображений
	global  frameText 	 ; # text handle	
	global lb 			 ; # listbox handle

	setup-window . $windowparams
	if {[dict get $userconfig menubar]} {
   		build-menu $menu .
	}
	#---------------------------------------------------------
	set slaveframe [frame  .slfr -bg  #99FF33  ] 
	pack $slaveframe  -fill x -side bottom -expand 0 
	#---------------------------------------------------------
	set topframe [frame  .topfr -bg green -padx 1 ]
	pack $topframe  -expand yes -fill both  
	#---------------------------------------------------------
	#set frameText [text .fr1.fTE -bg #0066CC ]	
	scrollbar .yscrollbar -command {.topfr.fTE } -orient vertical
	set frameText [text .topfr.fTE  -font "tahoma 12"  -fg black -bg Cornsilk  -yscrollcommand { .yscrollbar   set } -tabs 50  ]	  
	scrollbar .topfr.fTE.scrin -command {.topfr.fTE yview}

	set a [ttk::treeview  .topfr.tree -columns {cnt id ticket comments }  -show headings -yscroll  ".topfr.vsb set" -xscroll ".topfr.hsb set" ]
	ttk::scrollbar .topfr.vsb -orient vertical -command ".topfr.tree yview"
	ttk::scrollbar .topfr.hsb  -orient horizontal -command ".topfr.tree xview"
	#foreach i [glob *] {
       # .topfr.tree insert  [list $i]
    #}
	pack  $a -fill x
    
	set stringCounter [text .topfr.strCnt  -font curier -fg black -bg Cornsilk -width 3 -state disabled  ]	
	#pack .topfr.tree .topfr.hsb  .topfr.vsb -fill y -side right  
	pack  $frameText      -side right  -expand yes -fill both -pady { 1 1 } -padx { 0 1 }
	pack  $stringCounter  -side right  -expand 0 -fill y -pady { 1 1 }
	pack .topfr.fTE.scrin  -fill y -side right
	
	#---------------------------------------------------------	

	set infoConsol  [text .slfr.infCon   -font "tahoma 8" -fg red  -height 7  -tabs 50 ]

	set infoConsol2 [labelframe .slfr.infCon2  -text "Debug:"   -font tahoma -fg black  -height 7  -width 350   ]

	pack $infoConsol   -side left  -padx {1 0}  -pady {1 1}  -fill x  -expand yes
	pack $infoConsol2  -side left  -pady {1 1}  -fill y   
	#---------------------------------------------------------
	bind $slaveframe  <Enter>   { %W config -bg blue  }
	bind $slaveframe  <Leave>   { %W config -bg white }
	bind $topframe	  <Enter>   { %W config -bg grey  }
	bind $topframe    <Leave>   { %W config -bg white }
	bind $frameText  <Any-Key>	{  textHendler  .topfr.fTE [list  %K %A %X %W %Y ] }
    	
}
#--------------------#--------------------------------------------------------------------------------------------------------------------------
# описание точки входа в приложен:ие 
proc main {} {
# стартовая настройка окна приложения
	initW
# работа приложения
console show
}
#-----------------------------------------------------------------------
# вызов приложения - рабочий программы
main


 