namespace eval ::dialog {
    
}


proc init_arr_addtask {} {
    upvar #0 add_task  add_task_
    global config
    array set add_task_ {
        day_number 1
        remind  "Never"
        hours   "hours"
        mins    "minutes"
        month   "January"
        lremind { "Once" "Dayly" "Weekly" "Monthly" "Never"}
        topic_var "New"
        wyear     ""
        handleCalendar ""
        choosed_day 1
        
    }
    foreach {ind value} [ db_get_taskgrop $config(dbPath)] {
        lappend lst $value
    }
    set add_task_(topic_lst)  $lst
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
        
    set hour_label   [label $lfr2.label_hour -text "Time event"  -bg white -fg red]
    set remind_label [label $lfr2.label_howoften -text "How often remind:"  -bg white -fg red]
    set etime_hour   [ttk::combobox $lfr2.time_hour -state readonly -textvariable add_task(hours)  -values [  genLst_inrange 0 24 ] -width 7]
    set etime_min    [ttk::combobox $lfr2.time_min  -state readonly -textvariable add_task(mins)    -values [genLst_inrange 0 60 ] -width 7 ]
    set reminder     [ttk::combobox $lfr2.reminder  -state readonly -textvariable add_task(remind)  -values $add_task(lremind) ]
    
    grid $hour_label -pady 2 -columnspan 2   -sticky w
    grid $etime_hour $etime_min -padx 1
    grid $remind_label -row 4 -pady 2 -columnspan 2 -sticky w  
    grid $reminder  -columnspan 2 -row 5
    #bind $etime_hour <<ComboboxSelected>>  { set value [$etime_hour get] ; if { ![string is digit $value] } {set hours 0}}
    #bind $etime_hour <<ComboboxSelected>>  { tk_messageBox -message "$hours"}
    #
    
    set label_topic [label $lfr.label_topic -text "Choose project name:" -bg white -fg green]
    set add_task(topic_var) [lindex $add_task(topic_lst) 0]
    set topic [ttk::combobox $lfr.topic -state readonly -textvariable add_task(topic_var) -values $add_task(topic_lst) -width 12 ]
    
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
    set value_year [clock format [clock seconds] -format %Y]
    for {set a 0 } {$a < 10} {incr a} {
        lappend lyear $value_year
        incr value_year
    }
    set add_task(wyear) [lindex $lyear 0]
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
    
    button $lfr3.cancel     -text "Cancel"    -command "destroy $w_topLevel"   -bg white  -width 10
    button $lfr3.continue   -text "Done"      -command "ev_onDone $w_topLevel" -bg white  -width 10
    button $lfr3.additional -text "Ext.Setup" -command "destroy $w_topLevel"   -bg white  -width 10
    pack $lfr3.cancel $lfr3.continue $lfr3.additional -side right -padx 3
    pack  $fst_layer  -expand 1 -fill both 
   
    
}
proc ev_onDone { widg } {
    global envar add_task gEvent
        
    set  result [list -title $add_task(ttitle_v) \
                -topic $add_task(topic_var) \
                -year $add_task(wyear) \
                -month  $add_task(month) \
                -day_number $add_task(choosed_day) \
                -mins $add_task(mins) \
                -hours $add_task(hours) \
    ]
    destroy $widg
    tk_messageBox -message  $result
    unset add_task
    set gEvent(created_task) $result
    #return result
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

proc private_day_cmd { ref_toWidg } {
    global add_task
    set add_task(choosed_day) [$ref_toWidg cget -text]
    foreach e  $add_task(handleCalendar)  {
        set color "white"
        if { $add_task(choosed_day) == [$e cget -text] } {
             set color "blue"
        }   
        $e configure -bg $color
    }
#    tk_messageBox -message [$ref_toWidg cget -text]
}

proc private_fill_calendar {dayReffs month year } {
    global add_task
    set startOfMonth [clock format [clock seconds] -format $month/01/$year]
    
    set startOfWeek  [clock format [clock scan "+0 month" -base [clock scan $startOfMonth] ] -format %u]
    set cntDay       [clock format [clock scan "+1 month -1 day" -base [clock scan $startOfMonth] ] -format %d]
    
    #tk_messageBox -message "startOfMonth = $startOfMonth  cntDay = $cntDay startOfWeek = $startOfWeek "
    set shift [expr { $startOfWeek - 1 } ]
    set lastday_in_month [expr { $shift + $cntDay - 1}]
    for {set i 0 } { $i < [llength $dayReffs]} {incr i} {
        if { $i <  $shift  || $i > $lastday_in_month } {
            #[lindex $dayReffs $i  ]  configure -state normal 
            [lindex $dayReffs $i  ]  configure -text "" -state disabled -bg white
        } else {
            set value [expr $i - $shift  + 1]
            if { $add_task(choosed_day) > $cntDay } {
                set value 1
                set add_task(choosed_day) $value
            
            }
            if { $add_task(choosed_day) == $value } {
                [lindex $dayReffs $i ]  configure -bg blue
            } else {
                [lindex $dayReffs $i ]  configure -bg white
            }   
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

proc dialog_add_proj {cmd_name } {
    set w_topLevel .dialog_add_proj
    catch {destroy $w_topLevel }
    toplevel $w_topLevel
    global  add_proj
    set add_proj  "New"
    
    wm title $w_topLevel "Add new project"
    #wm iconname $w_topLevel "unicodeout"
    
    # expected size of window  400x300    !!!
    wm minsize $w_topLevel 300 0
    wm resizable $w_topLevel 0 0
    set  fst_layer [frame $w_topLevel.fst_layer -bg white ]
    
    set lfr  [labelframe  $fst_layer.labelfr  -text "Create new project name" -fg blue -bg white]
    set lfr1 [labelframe  $fst_layer.labelfr1 -text "Make your choice" -fg blue -bg white ]
    set name [ttk::entry  $lfr.ent  -textvariable add_proj ]
    #tk_messageBox -message $add_proj(name_value)
    pack $name -fill x -padx 2 -pady 2
    pack $lfr $lfr1  -fill x -padx 2 -pady 2
    #pack $lfr1 -fill x
    
    button $lfr1.cancel     -text "Cancel"    -command "destroy $w_topLevel"   -bg white  -width 10
    button $lfr1.continue   -text "Accept"      -command "$cmd_name add_proj ; destroy .dialog_add_proj" -bg white  -width 10
    #button $lfr1.additional -text "Ext.Setup" -command "destroy $w_topLevel"   -bg white  -width 10
    pack $lfr1.cancel $lfr1.continue  -side right -padx 3 -pady 1
    pack  $fst_layer  -expand 1 -fill both
    #unset add_proj
   
}
    #MAIN frame
    #set  fst_layer [frame $w_topLevel.fst_layer -bg white ]
#for {set i 0} {$i < 24} {incr i} {lappend hour $i } ; set hour
#
#1
#private_fill_calendar 1 03 2016111111
#addTask
