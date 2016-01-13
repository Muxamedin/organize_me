
namespace eval dbase {}
array set tables {
                tasks          { "id  INTEGER PRIMARY KEY AUTOINCREMENT"  "key varchar(100) NOT NULL" "title varchar(255) NOT NULL" "description text DEFAULT \' \' " "points int(11) DEFAULT 0" "status_id int(11) DEFAULT 1" "deadline DATE DEFAULT 0" "created_at DATE DEFAULT 0" "edited_at DATE DEFAULT 0" }
                statuses       { " id INTEGER PRIMARY KEY ASC" " name text NOT NULL" }
                comments       { "id INTEGER PRIMARY KEY ASC" "task_id int(11) DEFAULT 0" "content_id text NOT NULL" "created_at int(11) DEFAULT 0" "edited_at int(11) DEFAULT 0"}
                commits        { "id INTEGER PRIMARY KEY ASC" "content text NOT NULL" "date int(11) DEFAULT 0" "on_tasks text NOT NULL" "type_id int(11) DEFAULT 1" "created_at int(11) DEFAULT 0"}
                commit_types   { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL" "periodic_id int(11) DEFAULT 0"}
                periodics      { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL"}
                settings       { "id INTEGER PRIMARY KEY ASC" "key varchar(255) NOT NULL" "value varchar(255) NOT NULL" "type_id int(11) DEFAULT 1"}
                settings_types { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL"}
                schedules      { "id INTEGER PRIMARY KEY ASC" "event_type_id int(11) NOT NULL" "chat_room_id int(11) NOT NULL"  "time int(11) DEFAULT 0" "periodic_id int(11) DEFAULT 0"}
                event_types    { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL"}
                chat_rooms     { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL" "chat_id int(11) DEFAULT 0" "chat_oui int(11) DEFAULT 0"}
                admin_ka       { "id INTEGER PRIMARY KEY ASC" "user_name varchar(255) NOT NULL" "pswd varchar(255) NOT NULL" "mail varchar(255) NOT NULL" "key varchar(255) NOT NULL"}
                chats        { "id INTEGER PRIMARY KEY ASC" "name varchar(255) NOT NULL"}
}

package require sqlite3
# proc created new db
# if db from path exists - trying to open and create backup for db 
proc db_create { db_path } {
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
proc db_restore_from { db_path from } {
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
	tk_messageBox -message  "$ltable \n [llength $ltable]"
}

proc fill_db_onstart { db_id } {
    $db_id eval { INSERT INTO statuses VALUES( NULL, "privet" )}
    $db_id eval { INSERT INTO statuses VALUES( NULL, "privet 2" ) }
    $db_id eval { INSERT INTO statuses VALUES( NULL, "privet 3" ) }
    $db_id eval { INSERT INTO statuses VALUES( NULL, "privet 4" ) }
    $db_id eval {INSERT INTO tasks VALUES( NULL, "NEW" , "Title of ticket", "Title of ticket This is big description of task  lets think about it togather" , "" , "" , 12 , "12:12:12", 12) }
    $db_id eval {INSERT INTO tasks VALUES( NULL, "NEW" , "Title of ticket", "Title of ticket This is big description of task  lets think about it togather" , "" , 2 , 12 , "12:12:12", 12) }
}

proc create_db_tables { db_id } {
	global tables
	foreach item  [array names tables ]  {
		set table_command [join $tables($item) " , "]
        set tablename $item
        append str_cmd "CREATE TABLE $tablename"
        append str_cmd "("
        append str_cmd $table_command
        append str_cmd ")"
		$db_id eval  $str_cmd
        unset str_cmd
    }
}

proc get_db_testreq {db_id} {
    set ltable [$db_id eval "SELECT * FROM tasks"]
	tk_messageBox -message  "$ltable"
}

set path "G:/proj/TextRedactor/usr/store/mytest.db"
#file delete -force $path
#db_create $path  
sqlite3 dbcmd $path
#---
get_db_testreq dbcmd
#---
dbcmd close

exit