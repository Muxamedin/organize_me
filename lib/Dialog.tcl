
proc init_arr_addtask {} {
    upvar #0 add_task  add_task_
    array set add_task_ {
        remind  "Once"
        hours   "hours"
        mins    "minutes"
        month   "January"
        lremind { "Once" "Dayly" "Weekly" "Monthly" "Never"}
        topic_var "New"
        wyear     ""
        handleCalendar ""
    }
}

#tk_messageBox -message [array names add_task] 

proc addTask { } {
    init_arr_addtask
    set w_topLevel .dialogwindow
    catch {destroy $w_topLevel }
    toplevel $w_topLevel
    
    wm title $w_topLevel "Add task"
    #wm iconname $w_topLevel "unicodeout"
    
    # expected size of window  400x300    !!!
    wm minsize $w_topLevel 400 300
    wm resizable $w_topLevel 0 0
    #MAIN frame
    set  fst_layer [frame $w_topLevel.fst_layer -bg white ]
    #labelframes
    #
    set lfr  [labelframe  $fst_layer.labelfr  -text "Configure new task" -fg blue -bg white]
    set lfr1 [labelframe  $fst_layer.labelfr1 -text "Calendar"  -bg white]
    set lfr2 [labelframe  $fst_layer.labelfr2 -text "Setting"  -bg white]
    set lfr3 [labelframe  $fst_layer.labelfr3 -text "Service buttons" -fg blue -bg white ]
    #variables
    global add_task
    global hours mins month wyear remind
    #first set up
    
    #global add_task
    
    set remind "Once"
    set hours  "hours"
    set mins   "minutes"
    set month "January"
    set lremind [list "Once" "Dayly" "Weekly" "Monthly" "Never"]
    
    set hour_label   [label $lfr2.label_hour -text "Time event"  -bg white -fg red]
    set remind_label [label $lfr2.label_howoften -text "How often remind:"  -bg white -fg red]
    set etime_hour   [ttk::combobox $lfr2.time_hour -state readonly -textvariable add_task(hours)  -values [  genLst_inrange 0 24 ] -width 7]
    #set etime_hour  [ttk::combobox $lfr2.time_hour -state readonly -textvariable hours  -values [ for {set i 0} {$i < 24} {incr i} {lappend hour $i } ; set hour ] -width 7]
    set etime_min    [ttk::combobox $lfr2.time_min  -state readonly -textvariable add_task(mins)    -values [genLst_inrange 0 60 ] -width 7 ]
    set reminder     [ttk::combobox $lfr2.reminder  -state readonly -textvariable add_task(remind)  -values $add_task(lremind) ]
    
    grid $hour_label -pady 2 -columnspan 2   -sticky w
    grid $etime_hour $etime_min -padx 1
    grid $remind_label -row 4 -pady 2 -columnspan 2 -sticky w  
    grid $reminder  -columnspan 2 -row 5
    #bind $etime_hour <<ComboboxSelected>>  { set value [$etime_hour get] ; if { ![string is digit $value] } {set hours 0}}
    #bind $etime_hour <<ComboboxSelected>>  { tk_messageBox -message "$hours"}
    #

    global topic_var 
    set topic_var "New"
    set label_topic [label $lfr.label_topic -text "Choose task group:" -bg white -fg green]
    set topic [ttk::combobox $lfr.topic -textvariable add_task(topic_var) -values [list New EC Nimbus Hometask Meeting] -width 12 ]
    
    global ttitle_v ttitle
    
    set ttitle_v "Ticket title"
    set add_task(ttitle_v) "Ticket title"
    set label_ttitle [label $lfr.label_ttitle -text "$ttitle_v (short issue description):"   -bg white -fg green  ]
    
    set ttitle [ttk::entry $lfr.ttitle -textvariable add_task(ttitle_v) -width 45]
    # need to switch off debug 
    # bind $ttitle  <Any-Key>	{  textHendler  $ttitle [list  %K %A %X %W %Y ] }
    grid $label_topic     -row 0 -column 0 -sticky e
    grid $topic   -pady 3 -row 1 -column 0 -sticky w

    grid $label_ttitle    -row 0 -column 2  
    grid $ttitle  -pady 3 -row 1 -column 2   -sticky ne
    #setup year widget
    set value_year [ expr { [clock format [clock seconds] -format %Y] - 2} ]
    for {set a 0 } {$a < 10} {incr a} {lappend lyear [incr value_year]  }
    set add_task(wyear) [lindex $lyear 1]
    #setup month widget
    set calendar_month [ttk::combobox $lfr1.month -state readonly -textvariable add_task(month)   -values [list January February March April May Jun July August September October November December ]  -width 10 ]
    set calendar_year  [ttk::combobox $lfr1.year -state readonly -textvariable add_task(wyear)   -values $lyear  -width 6 ]
    bind $calendar_month <<ComboboxSelected>>  { change_calendar  [list  .dialogwindow.fst_layer.labelfr1.month .dialogwindow.fst_layer.labelfr1.year ]}
    bind $calendar_year <<ComboboxSelected>>   { change_calendar  [list  .dialogwindow.fst_layer.labelfr1.month .dialogwindow.fst_layer.labelfr1.year]}        
    set calendar [frame $lfr1.calendar ]
    #create days for month in calendar
    #add_task(handleCalendar)
    set add_task(handleCalendar) [ private_drawCalendar_in $calendar private_day_cmd]
     
    #private_fill_calendar   $handleCalendar  [clock format [clock seconds] -format %m]  [clock format [clock seconds] -format %Y] 
    #create days for month in calendar
    private_fill_calendar   $add_task(handleCalendar)  [clock format [clock seconds] -format %m]   [clock format [clock seconds] -format %Y] 
    grid $calendar_month $calendar_year -padx 2
    grid $calendar -columnspan 2  -sticky nsew 
    grid rowconfigure $lfr1 1 -weight 1
    #grid columnconfigure $lfr1  -weight 1
    
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
proc genLst_inrange { { first 0} {last 100} } {
    for {set i $first} {$i < $last} {incr i} {lappend generatedLst $i }
    return $generatedLst
}
# return list of buttons handls
proc private_drawCalendar_in {inframe day_cmd} {
    set a 0
    set day_in_week [list Mo Tu We Th Fr Sa Su ]
    for {set index 0} {$index < 49 } {incr index} {
        if { $index < 7} {
            set text_ [lindex $day_in_week $index]
            set state "disabled"
        } else {
            set text_ [expr {$index - 6 } ]
            set state "normal"
        }
        set bt [button $inframe.$index -text $text_ -bg white -relief flat -overrelief groove -state $state -command "$day_cmd $inframe.$index "]
        grid $bt -row [expr {$index / 7}]  -column [expr { $index % 7}]  -sticky nsew
        if { $index > 6} { lappend sqButton_list $bt }
    }
    return $sqButton_list
}

proc private_day_cmd { ref_toWindg } {
 tk_messageBox -message [$ref_toWindg cget -text]
}

proc private_fill_calendar {dayReffs month year } {
    
    set startOfMonth [clock format [clock seconds] -format $month/01/$year]
    
    set startOfWeek  [clock format [clock scan "+0 month" -base [clock scan $startOfMonth] ] -format %u]
    set cntDay       [clock format [clock scan "+1 month -1 day" -base [clock scan $startOfMonth] ] -format %d]
    
    #tk_messageBox -message "startOfMonth = $startOfMonth  cntDay = $cntDay startOfWeek = $startOfWeek "
    set shift [expr { $startOfWeek - 1 } ]
    set lastday_in_month [expr { $shift + $cntDay - 1}]
    for {set i 0 } { $i < [llength $dayReffs]} {incr i} {
        if { $i <  $shift  || $i > $lastday_in_month } {
            [lindex $dayReffs $i  ]  configure -text "" -state disabled
        } else {
            set value [expr $i - $shift  + 1]
            [lindex $dayReffs $i ]  configure -text $value -state normal      
            
        }
    }
    
}
proc change_calendar { options } {
    global  add_task
    set hmonth [lindex $options 0]
    #tk_messageBox -message "$hmonth [$hmonth cget -value ] "   
    set nmonth [expr { [lsearch [$hmonth cget -value ] $add_task(month)] + 1} ]
    private_fill_calendar $add_task(handleCalendar) $nmonth $add_task(wyear) 
    #tk_messageBox -message " $month  "   
} 
#for {set i 0} {$i < 24} {incr i} {lappend hour $i } ; set hour
#
#1
#private_fill_calendar 1 03 2016111111
#addTask
