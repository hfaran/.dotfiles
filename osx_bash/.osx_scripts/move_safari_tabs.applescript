tell application "Safari"
	set w to window 1
	set namelist to name of tabs of window 1
	repeat with i from 1 to (count namelist)
		set item i of namelist to (i & " " & (item i of namelist)) as text
	end repeat
	set answer to choose from list namelist with multiple selections allowed
	if answer is false then return
	make new document
	repeat with i in (reverse of answer)
		move tab ((word 1 of i) as integer) of w to beginning of tabs of window 1
	end repeat
	delete tab -1 of window 1
end tell
