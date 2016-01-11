package require sqlite3
# proc created new db
# if db from path exists - trying to open and create backup for db 
proc db_create {db_path } {
if { ! [file exists $db_path]} {
	# creating new base
		if { [catch { sqlite3 dbcmd $db_path } Err] } {
			tk_messageBox -message "Can't create new DB at start. $db_path Error : $Err"
			return 0
		}
	} else {
		#create back_up in tmp folder 
		if { ! [ catch { sqlite3 dbcmd $db_path } Err] } {
		     dbcmd backup  main [file join [file dirname $db_path ] bckp_[file tail $db_path] ]
 
		} else {
				tk_messageBox -message "Can't open data base $db_path. Database can be damaged. Error : $Err.\n Try to restore database from backup db "
				return 0
		}
	}
	
	dbcmd close
	return 1
}

proc db_restore { db_path } {
	if { ! [ catch { sqlite3 dbcmd $db_path } Err] } {
		     dbcmd restore  main [file join [file dirname $db_path ] bckp_[file tail $db_path] ]
 
		} else {
				tk_messageBox -message "Can't open data base $db_path when trying to  restore db. Database can be damaged. Error : $Err.\n Try to restore database from backup file [file join [file dirname $db_path ] bckp_[file tail $db_path] ] "
				return 0
		}
	dbcmd close	
	return 1
}
# restore data base from enother one
proc db_restore_from {db_path from} {
	if { ! [ catch { sqlite3 dbcmd $db_path } Err] } {
		    if {  [catch { dbcmd restore  main $from} err] } {
		     	if {! [file exists $from] } {
		     		tk_messageBox -message "Can't find $from. "
		     	} else {
		     		tk_messageBox -message "ERROR : $err\n Database can be damaged."
		     	}
		     	return 0
		    } else {
		    	dbcmd close
		    }

	} else { tk_messageBox -message "ERROR : $Err \n Can't open $db_path in restorefromdb process" }
	return 1
}
## "Procedure creates tables \
db_id - argument - handle for db access"
proc db_first_structure { db_id } {
	$db_id eval {CREATE TABLE ttext(text_id  INTEGER PRIMARY KEY , ticket_uri text, ticket_text TEXT, modification DATE )}
	$db_id eval {CREATE TABLE tcomment(id INTEGER PRIMARY KEY , text_id INTEGER , comment_text TEXT, modification DATE )}
	for {set i 0} {$i < 10} {incr i} {
		#set ion "some text"
		set cnt $i
		set text  "My string $cnt"
		set uri "EC-$cnt" 
		set text_info "$uri -- $text -- $i"
		$db_id eval {INSERT INTO ttext VALUES( NULL , $uri, $text , $text_info ) }	
		#tk_messageBox -message "$i"
	}
	set ltable [$db_id eval {SELECT * FROM ttext}]
## test message 
	tk_messageBox -message  $ltable 

	#tk_messageBox -message  "[$db_id eval {SHOW TABLES}]"
} 

set path "D:/1/mytest.db"
file delete -force $path
db_create {$path } 
sqlite3 dbcmd $path
db_first_structure dbcmd
dbcmd  close

exit