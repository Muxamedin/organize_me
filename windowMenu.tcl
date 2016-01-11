#!/usr/bin/tclsh

#exec  wish "$0" ${1+ "$@"}


package require Tcl 8.5
package require Tk
#package require Thread
#package require sqlite3
set run_Directory [file join [pwd] [file dirname [info script]]]   ; #
lappend auto_path [file dirname [info script] ]

set windowparams {
    title "Scheduler & Planner"
    minsize {800 600}
    resizable {1 1}
}

set userconfig {
    menubar yes
}

proc newFile { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc planing { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc RoadMap { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc includeDB { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc openFile { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc newProject { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc merge_prj { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc dell_prj { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc login { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc sStatus { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}

proc copy { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc cut { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc paste { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc dell { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc chooseLenguage { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc spellChecker { } {
	tk_messageBox -message "This is empty preocedure - son it will be work "
}
proc about { } {
    tk_messageBox -message "Simple application for easy typing text reports \n  Code by Mike Bily ( 2014 ) \n  "
}
proc help { } {
    tk_messageBox -message " Hot keys : \n control+a - select all \n control+c - copy selected
    \n control+v - insert from booffer
    \n control+h - delete string after curssor
     "
}
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
	$frameText  delete 1.0 end
	$infoConsol delete 1.0 end
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
set run_Directory [file join [pwd] [file dirname [info script]]]   ; #
set file_Dir [file join $run_Directory wordsFromFile ]   ; #
set file_path [file join $file_Dir en_US_my.dic ]
#set wDictList {}
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
	}

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
            -command tclsh
        }
        "Standart editor" {
            -command spellChecker
        }
        "Show editor console" {
            -command tclsh
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
# настройка окна 
proc setup-window {w params} {
    wm title $w [dict get $params title]
    wm resizable $w {*}[dict get $params resizable]
    wm minsize $w {*}[dict get $params minsize]
}
 
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
    $w config -activebackground red -activeforeground blue -background green 
}
proc  getListByMask { srclist mask } {
    global filteredList
    set filteredList [ lsearch -all -inline $srclist $mask ]
    return $filteredList
 }
proc findWordsFromList { maska} {
    global wDictList
    global lb
    global  frameText
    global wordStruct
    global filteredList
    
    global topframe 	 ; # верхний фрайм
    set maska_ [string tolower $maska]
    set mas $maska_
    append  mas *
    set filteredList [lsort [ getListByMask $wDictList $mas ]]  			;#рабочий список
    
    set lb [ listbox $frameText.s -foreground blue -bg gray ] 
    place $lb -x [expr {$wordStruct(coordX) + 10 }] -y [expr {$wordStruct(coordY) + 10}] 
    $lb insert 0 $wordStruct(word)
    set count 0
    foreach item $filteredList {
		incr count
		$lb insert $count "$count. $item "
        }
    bind $frameText <Key-Down> { focus $lb}
    # { clewerComplete $returnListBox }
    bind $frameText <Key-space>   {  destroy $lb ; bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} }    
    bind $lb <Key-Right>   {  set check [ $lb curselection] ;  cleverComplite $check   }
    
}
proc cleverComplite { rOneWord } {
    global filteredList
    global frameText
    global wordStruct
    global topframe
    global lb
    #tk_messageBox -message "$rOneWord "
    set varSh $wordStruct(charIndex)
    #tk_messageBox -message "$varSh $wordStruct(charPosition)  [$frameText index insert] [ string length $wordStruct(word)]"
    set sh  [expr { $wordStruct(charPosition) - [ string length $wordStruct(word)] } ]
    set sh [expr { $sh - 1}]
    if { $rOneWord == 0  } {
	focus $frameText
	bind $topframe  <Key-Left>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
	#catch { destroy $lb }
	bind $frameText <Key-space> {}
	bind $frameText <Key-Down> {}
    }
    if { $rOneWord > 0  } {
     $frameText delete "insert - [ string length $wordStruct(word)] char"  insert
     #tk_messageBox -message  "-------"
     set insertWordFromLb [lindex $filteredList [ expr {$rOneWord - 1}]  ]
     $frameText insert  insert $insertWordFromLb
     focus $frameText
     bind $topframe  <Key-Left>  { focus $frameText ;  bind $frameText <Key-space> {} ; bind $frameText <Key-Down> {} ; destroy $lb  }
     #destroy $lb
     #bind $frameText <Key-space> {}
     bind $frameText <Key-Down> {}
     #   tk_messageBox -message 
     # $frameText delete $wordStruct(curSymPos) insert
    }
    
}

#обработчик работы нажатия клавиш клавиатуры
# winHendle - путь к текст компоненте
# largs     - список переданых параметров \
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
	global lb
	#--
	global wordStruct			; # массив для работы со словом
	set wordStruct(char) {}			; # очистить
	set wordStruct(word) {}			; # очистить
	set wordStruct(charPosition) {}		; # очистить
	set wordStruct(firstCharWord) {}	; # очистить
	set wordStruct(coordX) {}
        set wordStruct(coordY) {}
	set wordStruct(curSymPos) {}
	set wordStruct(endSymPos) {}
	set wordStruct(charIndex) {}
	#--
	# обработка занка препинания
	if {[ info exists lb ]} { destroy $lb
	bind $frameText	<Key-space> {}
	bind $frameText	<Key-Up> {}
	bind $frameText	<Key-Down> {}
	}
	
	$infoConsol delete 1.0 end	
	$infoConsol insert insert  "K=[lindex $largs 0] A=[lindex $largs 1] x=[lindex $largs 2] W=[lindex $largs 3]" ; # test message
	set a [$frameText bbox insert] 
	set wordStruct(coordX) [lindex $a 0]
        set wordStruct(coordY) [lindex $a 1]
	#tk_messageBox -message "$wordStruct(coordY) $wordStruct(coordX) [$frameText bbox insert] "
	# смотрим символы
	if {  [ regexp {[\w]}  [lindex $largs 1] matchCh]  } {
	    # получить  текущий номер симола в строке
	    set wordStruct(charPosition)     [ lindex [split [$winHendle index insert] .] 1 ]
	    # получить  текущий номер строки
	    set wordStruct(charLinePosition) [ lindex [split [$winHendle index insert] .] 0 ]
	    set wordStruct(char) [lindex $largs 1]
	    #test оладка 
	    $infoConsol insert insert "\n -> line: $wordStruct(charLinePosition) index : $wordStruct(charPosition)"
	    #end test оладка
	    if {$wordStruct(charPosition) == 0 } {
		    set wordStruct(word) $wordStruct(char)
		    $infoConsol insert insert " stringLine :  -> $wordStruct(word)  \t"
		} else {
		    for { set i 0  } { $i < $wordStruct(charPosition) } { incr i }  {
		    # получить всю строку от начала до текущего символа
		    set stringLine [ $winHendle get  "insert linestart" insert]
		    # получить символ перед текущим индексом
		    set var [ $winHendle get  "insert -[expr {$i + 1}] char"]
		    #test оладка 
		    $infoConsol insert insert "$stringLine : $var -> $wordStruct(charPosition) -- $i \t"
		    #end test оладка
		    # если символ пробел или знак препинания
		    if {  [ regexp {\W} $var ss ]  } {
		        #test отладка 
		        #$infoConsol insert insert "[expr {$wordStruct(charPosition)- [ expr {$i + 1}]  } ]\t"
			#set wordStruct(curSymPos) [ $wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ] ]
		        set var1 [ $winHendle get  "$wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]"  insert ]
			#$winHendle insert "$wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]" 
		        #end test отладка
			set wordStruct(charIndex) [ expr { [ expr { $wordStruct(charPosition)- $i } ] - 0 } ]
		        set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
			$infoConsol insert insert "\n--+-- $wordStruct(word)"
			findWordsFromList $wordStruct(word)
		        break
		    }
		    # если добежали до начала строки 
		    if { $i == [ expr { $wordStruct(charPosition) - 1 }  ]  } {
			set var1 [ $winHendle get  "insert linestart"  insert ]
			set wordStruct(word)  $var1
		        append wordStruct(word) $wordStruct(char)
		        $infoConsol insert insert "\nfrom line start--+-> $wordStruct(word) "		
		    }
		 if { $wordStruct(word) != ""  } {
		    #set wordStruct(startPosition) [ $wordStruct(charLinePosition).[expr {$wordStruct(charPosition)- $i } ]]
			set wordStruct(endPosition) [$winHendle index insert]
		       findWordsFromList $wordStruct(word)
		       
		    }
		}
		
	    }
	    set wordStruct(firstCharWord) [ regexp { [^\w ] } $wordStruct(word) mmatch1]
	    $infoConsol insert insert " word: [ $winHendle get "insert wordstart" "insert wordend"] ( [$winHendle index "insert wordstart"] [$winHendle index insert] [$winHendle index  "insert wordend"]  )  $wordStruct(charPosition) $wordStruct(firstCharWord)"
	    set	wordStruct(prevChar) $wordStruct(char)     ; # полученый символ храним в для след обработки
	 }
	if { ! [ regexp {[A-Za-z0-9]}  [lindex $largs 1] matchCh]  } {
	    
	    set wchar [lindex $largs 0]
	    		$infoConsol insert end " $wchar"
		set Tab Tab
		if { $wchar == $Tab } {
		    $infoConsol insert end " \[ [$winHendle index insert]\]$wchar ----!!!!"
		}
		
	}

} 

proc initW {} { 

	global windowparams  ; # параметры окна
	global userconfig    ; # пользовательские настройки 
	global menu 		 ; # 
	global topframe 	 ; # верхний фрайм	
	global slaveframe	 ; # нижний фрайм
	global infoConsol 	 ; # консоль выполнения действий 	
	global infoConsol2 	 ; # правая консоль (дополнительная)
	global stringCounter ; # щетчик строк или для дополнительных изображений
	global  frameText
	global lb

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
	set frameText [text .topfr.fTE  -font "tahoma 10"  -fg blue -yscrollcommand { .yscrollbar   set } -tabs 50  ]	  
	scrollbar .topfr.fTE.scrin -command {.topfr.fTE yview}
	#pack .topfr.scrin
	set stringCounter [text .topfr.strCnt  -font curier -width 5 -state disabled  ]	  
	pack  $frameText      -side right  -expand yes -fill both  -pady { 1 1 } -padx { 0 1 }
	pack  $stringCounter  -side right  -expand 0 -fill y -pady { 1 1 }
	pack .topfr.fTE.scrin  -fill y -side right
	#---------------------------------------------------------	

	set infoConsol  [text .slfr.infCon    -bg #9999CC  -font "tahoma 8" -fg green  -height 7  -tabs 50 ]

	set infoConsol2 [labelframe .slfr.infCon2  -text "Information:" -bg #9999CC  -font tahoma -fg black  -height 7  -width 350   ]

	pack $infoConsol   -side left  -padx {1 0}  -pady {1 1}  -fill x  -expand yes
	pack $infoConsol2  -side left  -pady {1 1}  -fill y   
	#$infoConsol2 config -state disabled
	#---------------------------------------------------------
	bind $slaveframe  <Enter>   { %W config -bg blue  }
	bind $slaveframe  <Leave>   { %W config -bg green }
	bind $topframe	  <Enter>   { %W config -bg red   }
	bind $topframe    <Leave>   { %W config -bg green }
	
    # bind $frameText   <B1-Motion>   { .topfr.fTE insert end "(x=%x y=%y X=%X Y=%Y) "  }
    bind $frameText  <Any-Key>	{  textHendler  .topfr.fTE [list  %K %A %X %W %Y ] }
        
}
#--------------------#--------------------------------------------------------------------------------------------------------------------------
# 
proc main {} {
# 
	initW
# 
}
#-----------------------------------------------------------------------
# 
main


 