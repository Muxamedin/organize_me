
#!/usr/bin/tclsh \
    exec  wish "$0" ${1+ "$@"}

#package require Tcl 8.5
package require Tk
#package require Thread
#package require sqlite3
# getting path to the directory where was started application
set run_Directory [file join [pwd] [file dirname [info script]]]   
lappend auto_path [file dirname [info script] ]

# option of main window 
set windowparams {
    title "Scheduler & Planner"
    minsize {400 400}
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

#
proc exitProc {} {
   tk_messageBox -message "Thank you for using our app. You've choosed action for exit."   
   #here should be actions before exit - saving data , closing files
   exit
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
     When you typing you can use  arrows\n  - Key-down go to listbox dictionary\n  - Key-left to choose from dictionary listbox
     Enter or Double-button-1 choose from list box by selected position "
}
proc editPreflight_xml {} {
    tk_messageBox -message "Eddition xml file "
}
# when you will choose from menu wich report do you whant to see - you will get text template spesialy for your choise
proc chooseTemplate { temlatenumber } {
	global frameText
	global debug_console 	 ; # консоль выполнения действий
    
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
	$debug_console delete 1.0 end  ; # clear console pane
			#tk_messageBox -message "temlatenumber=$temlatenumber"
	if { $temlatenumber == 1 || $temlatenumber == 5 } {
			$debug_console insert insert "\[$date(time24)\] -> Chose: Dayly \n"		    
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(dayY) (d/y) - $date(nWeek) (w/y)\n$date(date)\n\t\t\t Dayly raport:\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"	
	}
	if { $temlatenumber == 2 || $temlatenumber == 5 } {
			$debug_console insert insert "\[$date(time24)\] -> Chose: Weekly \n"
			$frameText insert insert    "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(dayY) (d/y) - $date(nWeek) (w/y)\n$date(date)\n\t\t\t Weekly Plans:\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"	
	}
	if { $temlatenumber == 3 || $temlatenumber == 5} {
            $debug_console insert insert   "\[$date(time24)\] -> Chose: Plans Weekly \n"
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(nDayWeek).w - $date(nMonth).m $date(year).y\n\t\t\t Week plans: \n\t\t\n\n\t Task 1) ... priority (P0) ... subscription ... {}     \n\nInProgress from previous week:\n\nProblems:  \n"
	}
	if { $temlatenumber == 4 || $temlatenumber == 5} {
            $debug_console insert insert   	"\[$date(time24)\] -> Chose: Plans \n"
			$frameText insert insert "--------------------------------------------------------------------------------\n"
			$frameText insert insert "$date(nMonth).m $date(year).y\n\t\t\tMonth plans:\n\nCompleted:\n\t1) ...\n\nInProgress:\n\nProblems:  \n"
	}
		
		
}
# read dictionary global "wDictList"
set run_Directory [file join [pwd] [file dirname [info script]]]   ; # path to directory where was run application editor
set file_Dir [file join $run_Directory wordsFromFile ]   ; #
set file_path [file join $file_Dir en_GB_my.dic ]
proc load_words_from_file {file_} {
    #tk_messageBox -message "$file_path"
    if { ! [ catch { open $file_ r } fId ] } {
	    #global wDictList
	    #tk_messageBox -message "all ok file opened"
	    set count 0
	    foreach line [split [read $fId] \n] {
			lappend words_list $line
			# puts "$count $line"
			incr count
	    }
	    close $fId
        return $words_list
	    #tk_messageBox -message "$wDictList"
    } else {
		tk_messageBox -message "Error: $fId \n May be $file_ is busy or absent."
        exit
    }
}
proc addTask { } {
    set w_topLevel .dialogwindow
    catch {destroy $w_topLevel }
    toplevel $w_topLevel
    set  fst_layer [frame $w_topLevel.fst_layer -bg white ]
    wm title $w_topLevel "Add task"
    #wm iconname $w_topLevel "unicodeout"
    #positionWindow $w
    wm minsize $w_topLevel 400 300
    wm resizable $w_topLevel 0 0
    #wm geometry $w_topLevel +600+500
    set lfr  [labelframe  $fst_layer.labelfr -text "Configure new task" -fg blue -bg white]
    set lfr1 [labelframe  $fst_layer.labelfr1 -text "Calendar"  -bg white]
    set lfr2 [labelframe  $fst_layer.labelfr2 -text "Setting"  -bg white]
    set lfr3 [labelframe  $fst_layer.labelfr3 -text "Service buttons" -fg blue -bg white ]
    #set but [button $lfr.but -text "Some" ]
    set lable1 [label $lfr1.lab -text "calendar" ]
    #set lable2 [label $lfr2.lab -text "Time" ]
    
    global hours
    global mins
    global month wyear
    global remind
    set remind "Once"
    set hours  "hours"
    set mins   "minutes"
    set month "January"
    
    set lremind [list "Once" "Dayly" "Weekly" "Monthly" "Never"]
    
    set hour_label [label $lfr2.label_hour -text "Time event"  -bg white -fg red]
    set remind_label [label $lfr2.label_howoften -text "How often remind:"  -bg white -fg red]
    set etime_hour [ttk::combobox $lfr2.time_hour -state readonly -textvariable hours  -values [ for {set i 0} {$i < 24} {incr i} {lappend hour $i } ; set hour ] -width 7]
    set etime_min [ttk::combobox $lfr2.time_min -state readonly -textvariable mins   -values [ for {set i 0} {$i < 60} {incr i} {lappend minutes $i } ; set minutes ] -width 7 ]
    #set lable3 [label $lfr3.lab  ]
    #
   # pack $etime_hour $etime_min -side left  -padx 1 -anchor n
    set reminder [ttk::combobox $lfr2.reminder -state readonly -textvariable remind   -values $lremind ]
    #pack $reminder  -side left -anchor e
    #
    grid $hour_label -pady 2 -columnspan 2   -sticky w
    grid $etime_hour $etime_min -padx 1
    grid $remind_label -row 4 -pady 2 -columnspan 2 -sticky w  
    grid $reminder  -columnspan 2 -row 5
    #bind $etime_hour <<ComboboxSelected>>  { set value [$etime_hour get] ; if { ![string is digit $value] } {set hours 0}}
    #bind $etime_hour <<ComboboxSelected>>  { tk_messageBox -message "$hours"}
    #
    #set etime_min [ttk::combobox $lfr2.time_min  -textvariable mins   -values [ for {set i 0} {$i < 60} {incr i} {lappend minutes $i } ; set minutes ] -width 8 ]
    global topic_var 
    set topic_var "New"
    set label_topic [label $lfr.label_topic -text "Choose task group:" -bg white -fg green]
    set topic [ttk::combobox $lfr.topic -textvariable topic_var -values [list New EC Nimbus Hometask Meeting] -width 12 ]
    
    global ttitle_v ttitle
    set ttitle_v "Ticket title"
    set label_ttitle [label $lfr.label_ttitle -text "$ttitle_v (short issue description):"   -bg white -fg green  ]
    
    set ttitle [ttk::entry $lfr.ttitle -textvariable ttitle_v -width 45]
    # need to switch off debug 
    # bind $ttitle  <Any-Key>	{  textHendler  $ttitle [list  %K %A %X %W %Y ] }
    grid $label_topic     -row 0 -column 0 -sticky e
    grid $topic   -pady 3 -row 1 -column 0 -sticky w

    grid $label_ttitle    -row 0 -column 2  
    grid $ttitle  -pady 3 -row 1 -column 2   -sticky ne
  
    set value_year [ expr { [clock format [clock seconds] -format %Y] - 2} ]
    for {set a 0 } {$a < 10} {incr a} {lappend lyear [incr value_year]  }
    set wyear [lindex $lyear 1]
    set calendar_month [ttk::combobox $lfr1.month -state readonly -textvariable month   -values [list January February March April May Jun July August September October November December ]  -width 10 ]
    set calendar_year  [ttk::combobox $lfr1.year -state readonly -textvariable wyear   -values $lyear  -width 6 ]
    set calendar [frame $lfr1.calendar ]
    #create days for month in calendar
    set a 0
    set day_in_week [list Mo Tu We Th Fr Sa Su ]
    set day_in_month {}
    for {set index 0} {$index < 49 } {incr index} {
        if { $index < 7} {
            set text_ [lindex $day_in_week $index]
        } else {
            set text_ [expr {$index - 6 } ]
        }
        set bt [button $calendar.$index -text $text_ -bg white -relief flat -overrelief groove]
        grid $bt -row [expr {$index / 7}]  -column [expr { $index % 7}]  -sticky nsew 
    }
        
    
    #create days for month in calendar
    #pack [label $calendar.b -text "my"] 
    grid $calendar_month $calendar_year -padx 2
    grid $calendar -columnspan 2  -sticky nsew 
    grid rowconfigure $lfr1 1 -weight 1
    
    pack $lfr  -fill x
    pack $lfr3 -fill x    -side bottom -padx 2 -ipady 4
    pack $lfr1 -fill both -side left   -padx 2 -expand 1
    pack $lfr2 -fill y    -side right  -padx 2
    
    button $lfr3.cancel     -text "Cancel"    -command "destroy $w_topLevel" -bg white  -width 10
    button $lfr3.continue   -text "Done"      -command "destroy $w_topLevel" -bg white  -width 10
    button $lfr3.additional -text "Ext.Setup" -command "destroy $w_topLevel" -bg white  -width 10
    pack $lfr3.cancel $lfr3.continue $lfr3.additional -side right -padx 3
    pack  $fst_layer  -expand 1 -fill both 
   
    
}
set wDictList [load_words_from_file $file_path]
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
        
    }
    Pluggins {
        "edit .preflight (Flow tool)" {
            -command editPreflight_xml
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
# window setup
proc setup-window {w params} {
    wm title $w [dict get $params title]
    wm resizable $w {*}[dict get $params resizable]
    wm minsize $w {*}[dict get $params minsize]
    $w config -bg white
}
#	pin menu to window \
menu -  dictionary contans menu's setup\
w    -  main window \
args -   \ 
#frame .menu_frame -borderwidth 5
#pack  .menu_frame -side top -fill x 
 
proc build-menu {menu w args } {
    
    dict with args {
        set options [dict filter $menu key -*]
        if {[dict exists $options -command]} {
            $w add command -command [dict get $options -command] -label $label
        } else {
            if {[dict exists $options -name]} {
                set name [dict get $options -name]
            }
            set m [menu $w.$name -tearoff 0]
            #menu $m -tearoff 0
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
    #setting color for menu
    $w config -activebackground black  -activeforeground white -background white
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
    global top_frame 	 ; # верхний фрайм
    global realword
    #set maska_
    #set realword $maska
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
		# coordinates where to place listbox
		place $lb -x [expr {$wordStruct(coordX) + 15 }] -y [expr {$wordStruct(coordY) + 25}] 
		set count 0
		foreach item $filteredList {
			incr count
			$lb insert $count "$count. $item "
        }
		bind $frameText <Key-Down> { focus $lb}
		#bind $frameText <Key-space>   {  destroy $lb ; bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} }    
		bind $lb <Key-Right>   {focus $frameText ;  set check [ $lb curselection]; cleverComplite $check ; after 5 {destroy $lb}   }
		bind $lb <Key-Return>   {  set check [ $lb curselection]; cleverComplite  $check ; destroy $lb   }
		bind $lb <Double-Button-1>   {  set check [ $lb curselection] ;   cleverComplite $check ; destroy $lb    }
		bind $lb <Key-Escape>   {focus $frameText  }
		bind $lb <Key-space>   {focus $frameText ;  set check [ $lb curselection]; cleverComplite $check ; after 5 {destroy $lb}   }
	}
}
proc toUserStyletyping { mask word} {
    set lengs [string length $mask]
    return [string replace $word 0 [expr {$lengs - 1}] $mask]
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
    global top_frame
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
	#bind $top_frame  <Key-Return>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
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
     set insertWordFromLb [toUserStyletyping $wordStruct(word) $insertWordFromLb]
     $frameText insert  insert $insertWordFromLb
     #tk_messageBox -message
     focus $frameText
     bind $top_frame  <Key-Left>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
     bind $frameText <Key-Down> {}
     bind $top_frame  <Key-Left> {}
     
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
	global  debug_console
	#global  debug_console2
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
	$debug_console delete 1.0 end
	# service information	
	$debug_console insert insert  "K=[lindex $largs 0] A=[lindex $largs 1] x=[lindex $largs 2] W=[lindex $largs 3]" ; # test message
	set a [$winHendle bbox insert] 
	set wordStruct(coordX) [lindex $a 0]
	set wordStruct(coordY) [lindex $a 1]
	$debug_console insert insert "\ncoord of char: wordStruct(coordX) = $wordStruct(coordX) , wordStruct(coordY)= $wordStruct(coordY)\n"
    	# chars or symbols
	if {  [ regexp {[\w]}  [lindex $largs 1] matchCh]  } {
	    # current number of symbol in the string
	    set wordStruct(charPosition)     [ lindex [split [$winHendle index insert] .] 1 ]
	    # get current number of string 
	    set wordStruct(charLinePosition) [ lindex [split [$winHendle index insert] .] 0 ]
	    set wordStruct(char) [lindex $largs 1]
	    #test  
	    $debug_console insert insert "\n -> line: wordStruct(charLinePosition) = $wordStruct(charLinePosition)"
	    #end test 
	    if { $wordStruct(charPosition) == 0 } {
		    set wordStruct(word) $wordStruct(char)
		    $debug_console insert insert " stringLine :  -> $wordStruct(word)  \t"
            
		} else {
		    for { set i 0  } { $i < $wordStruct(charPosition) } { incr i }  {
		    # get string from the begining to current symbol 
		    set stringLine [ $winHendle get  "insert linestart" insert]
		    # get symbol before current symbol
		    set var [ $winHendle get  "insert -[expr {$i + 1}] char"]
		    #test  
		    $debug_console insert insert "$stringLine : $var -> $wordStruct(charPosition) -- $i \t"
		    #end test 
		    # if symbol is not char
		    if {  [ regexp {\W} $var ss ]  } {
		        set var1 [ $winHendle get  "$wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]"  insert ]
			#end test 
			set wordStruct(charIndex) [ expr { [ expr { $wordStruct(charPosition)- $i } ] - 0 } ]
		        set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
			$debug_console insert insert "\nwordStruct(word)--+-- $wordStruct(word)"
			#main call for working with list from dictionary
			findWordsFromList $wordStruct(word)
		        break
		    }
		    # if we gets to begin of string 
		    if { $i == [ expr { $wordStruct(charPosition) - 1 }  ]  } {
			set var1 [ $winHendle get  "insert linestart"  insert ]
			set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
		        $debug_console insert insert "\nfrom line start--+-> $wordStruct(word) "		
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
	    $debug_console insert insert " word: [ $winHendle get "insert wordstart" "insert wordend"] ( [$winHendle index "insert wordstart"] [$winHendle index insert] [$winHendle index  "insert wordend"]  )  $wordStruct(charPosition) $wordStruct(firstCharWord)"
	    #$debug_console insert insert "[ $winHendle sget -text  ]"
	    set	wordStruct(prevChar) $wordStruct(char)     ; # 
	}
	# обработка печатных символов 	  
	if { ! [ regexp {[A-Za-z0-9]}  [lindex $largs 1] matchCh]  } {
		set wchar [lindex $largs 0]
	    	$debug_console insert end " $wchar"
		set Tab Tab
		if { $wchar == $Tab } {
		    $debug_console insert end " \[ [$winHendle index insert]\]$wchar ----!!!!"
		}
		
	    }

} 
#----------------------------------------------------------------------------------------------------
# init of application
proc initW {} { 

	global windowparams  ; # windows property
	global userconfig    ; # user configuration
	global menu 		 ; # 
	global top_frame 	 ; # 	
	global bottom_frame	 ; # 
	global debug_console 	 ; # console
	global debug_console 	 ; # aditional console
	global stringCounter ; # щетчик строк или для дополнительных изображений
	global  frameText 	 ; # text handle	
	global lb 			 ; # listbox handle

	setup-window . $windowparams
	if {[dict get $userconfig menubar]} {
   		build-menu $menu .
	}
	#---------------------------------------------------------
	set bottom_frame [frame  .slfr -bg  #99FF33  ] 
	pack $bottom_frame  -fill x -side bottom -expand 0 
	#---------------------------------------------------------
    #paned window for tree and text frame
   	set top_frame [panedwindow .topfr -orient vertical -bg green  ]
    pack $top_frame  -expand yes -fill both  
	#---------------------------------------------------------
    # handles for top and bottom pane of paned frame
    set top_ofpaned    [frame $top_frame.top ]
    set bottom_ofpaned [frame $top_frame.bottom]
    #---------------------------------------------------------
    global col 	; #aray for setting tree colums
    set col(date) "date"
    set col(desc) "description"
    set col(summary) "summary"
    set col(created) "created"
    set col(started) "started"
    set col(owner)   "owner"
    set col(state)   "done|progerss|future"
    # columns list
    set list_col [list $col(date)    $col(desc) $col(summary) $col(created) $col(started) $col(state)  $col(owner)]
    # creat tree
    set tree [ttk::treeview  $top_ofpaned.tree -columns $list_col -yscroll  "$top_ofpaned.tree.vsb  set" -xscroll "$top_ofpaned.tree.hsb set" ]
	# create scroll bar
    ttk::scrollbar $tree.vsb -orient vertical -command "$tree yview"
	ttk::scrollbar $tree.hsb  -orient horizontal -command "$tree xview"
    # add text to columns head
    foreach i $list_col {
        $tree heading $i -text $i  -anchor center 
    }
    # setting  width for every column
    $tree column #0 -width 200
    $tree column $col(date) -width 70 
    $tree column $col(summary) -width 50
    $tree column $col(created) -width 50
    $tree column $col(started) -width 50
    $tree column $col(state) -width 50
    $tree column $col(owner) -width 50
    $tree column $col(desc) -width 250
    # create frame for managing tree
    set toolBar_toTree [frame $top_ofpaned.buttons_toTree -bg "white"]
    # create buttons 
    set addTask    [button $toolBar_toTree.but_addTask -text "Add Task"    -command { addTask }       -bg "white"]
    set addSubTask [button $toolBar_toTree.but_addSTask -text "Add subTask" -command { addTask }       -bg "white"]
    set share      [button $toolBar_toTree.but_share -text "Share"    -command { addTask }       -bg "white"]
    #set addTask    [button $toolBar_toTree.but_addTask -text ""    -command { addTask }       -bg "white"]
    set reorder    [button $toolBar_toTree.but_reorder -text "Reorder"     -command { reorderTaskby } -bg "white"]
    # add buttons to manage frame
    pack $reorder $share $addSubTask $addTask    -side right -padx 3
    pack $toolBar_toTree  -fill x -side top
    # packing tree frame
    pack  $tree -expand yes -fill both 
    # packing scrols
    pack $tree.vsb -fill y -side right
    pack $tree.hsb -fill x -side bottom
    # create tree nodes
    $tree insert {} end -id "Current year" -text " [clock format [clock seconds] -format %Y] <- current year "  -values [list "[clock format [clock seconds] -format %Y]" "" "456"] -open 1 
    $tree insert "Current year" end -id "Current month" -text "[clock format [clock seconds] -format %b] <-current month"    -values [list "[clock format [clock seconds] -format %B]" "Tree of tasks for current month" "" "" "" "" ""] -open 1
    $tree insert "Current month" end -id "Current week" -text "current week"  -values [list  "week: [clock format [clock seconds] -format %W]" "" "tasks"] -open 1 
    $tree insert "Current week" end -id "Current day" -text "[clock format [clock seconds] -format %A] <-current day" -values [list "" "" "" "" "" "" "mike"] 
    $tree insert "Current day" end -text "edit items in tree" -values [list "" "" "" "" "" "" "mike"]
    $tree insert "Current day" end -text "save tree info" -values [list "" "" "" "" "" "" "mike"]
    $tree insert "Current day" end -text "load tree from file" -values [list "" "" "" "" "" "" "mike"]
    $tree  insert "" end -id Progress -text "Progress" -values [list "" "Tasks in progress" "" "" "" "" ""]   -open 0
    $tree  insert "" end -id Done -text "Done" -values [list "" "Already done tasks" "" "" "" "" ""]  -open 0
    $tree insert Done end  -text "sub Direct"
    $tree  insert "" end -id NEW -text "NEW"  -values [list "" "Not assigned and not processed tasks" "" "" "" "" ""]
    $tree insert NEW end  -text "task manager" -values [list "" "create mechanism for sorting tasks by data and priority" "" "" "" "" ""] 
    # test adding items to Progress node 
    for {set i 0 } { $i < 10 } {incr i} {
        $tree insert Progress end  -text "In progress on - $i"   -values [list "" "" "" "" "" "" "User name"]
    }
    # test adding items to Done node
    for {set i 0 } { $i < 10 } {incr i} {
        $tree insert Done end  -text "sub Done - $i"  -values [list "" "" "" "" "" "" "mike"]
    }
    
    
	set frameText [text $bottom_ofpaned.fTE  -font "scripts 12"  -fg black -bg Cornsilk  -yscrollcommand { .yscrollbar   set } -tabs 50  ]
    scrollbar .yscrollbar -command { $bottom_ofpaned.fTE } -orient vertical
	scrollbar $frameText.scrin -command {$frameText yview}
    
	set stringCounter [text $bottom_ofpaned.strCnt  -font curier -fg black -bg Cornsilk -width 3 -state disabled  ]	
	 
	pack  $frameText      -side right  -expand yes -fill both -pady { 1 1 } -padx { 0 1 }
    pack  $frameText.scrin  -fill y -side right
	pack  $stringCounter  -side left  -expand 0 -fill y -pady { 1 1 }
	pack  .yscrollbar   -side bottom  -expand 0 -fill x -padx { 1 1 }
	$top_frame add $top_ofpaned -minsize 250
    $top_frame add $bottom_ofpaned -minsize 1i
    #$top_frame  paneconfigure $top_ofpaned -minsize 150
    
	#---------------------------------------------------------	

	set debug_console  [text .slfr.infCon   -font "tahoma 8" -fg red  -height 7  -tabs 50 ]

	set leftConsole_onBottomFrame [labelframe .slfr.infCon2  -text "Calendar"   -font tahoma -fg black  -height 7  -width 250   ]

	pack $debug_console   -side left  -padx {1 0}  -pady {1 1}  -fill x  -expand yes
	pack $leftConsole_onBottomFrame  -side left  -pady {1 1}  -fill y   
	#---------------------------------------------------------
	bind $bottom_frame  <Enter>   { %W config -bg blue  }
	bind $bottom_frame  <Leave>   { %W config -bg white }
	bind $top_frame	  <Enter>   { %W config -bg grey  }
	bind $top_frame    <Leave>   { %W config -bg white }
	bind $frameText  <Any-Key>	{  textHendler  $frameText [list  %K %A %X %W %Y ] }
    	
}
#--------------------#--------------------------------------------------------------------------------------------------------------------------
# описание точки входа в приложен:ие 
proc main {} {
# стартовая настройка окна приложения
	initW
# работа приложения
#console show
}
#-----------------------------------------------------------------------
# вызов приложения - рабочий программы
main


 