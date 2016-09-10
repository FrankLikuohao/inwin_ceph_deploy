#!/bin/bash 
function quit {
   exit
}  
function e {
	echo $1 
}  
#e Hello
#e in_frank_common.sh
#quit

#clear file
newfile() {
	local FILE=$1
	if [ -f $FILE ];
	then
   		\rm -rf $FILE
    		touch $FILE 
	else
    		touch $FILE 
	fi
}
#get first host host:/dev/sdb:/dev/sdd ....
get_first_element_by() {
#splite $ANSWER out by ":" to get the first element for ssh 
local ANSWER=$1
splitmark=$2

slpiteArrary=(${ANSWER//$splitmark/ })
firsthost=${slpiteArrary[0]}
#return string  by using  result=$()
echo $firsthost
}	
get_first_element_collumn() {
#splite $ANSWER out by ":" to get the first element for ssh 
local ANSWER=$1
splitmark=':'

slpiteArrary=(${ANSWER//$splitmark/ })
firsthost=${slpiteArrary[0]}
#return string  by using  result=$()

echo  $firsthost
}	
#scp program and exec remote and remove the program
function remote_ssh_para {
local host=$1
local program=$2
local parameters=$3
scp ./$program $host:~	
ssh -t $host sudo chmod a+x  $program 
ssh -t $host "~/$program $parameters"
ssh -t $host sudo "\rm -f $program"
}

#scp program and exec remote and remove the program
function remote_ssh {
local host=$1
local program=$2

scp ./$program $host:~	
ssh -t $host sudo chmod a+x  $program 
ssh -t $host "~/$program"
ssh -t $host sudo "\rm -f $program"
}

print2null() {
	$1 > /dev/null 2>&1
}
#study
get_conf_bool() {
	get_conf "$@"

	eval "val=$"$1
	[ "$val" = "0" ] && export $1=0
	[ "$val" = "false" ] && export $1=0
	[ "$val" = "1" ] && export $1=1
	[ "$val" = "true" ] && export $1=1
}
get_conf() {
	var=$1
	def=$2
	key=$3
	shift; shift; shift

	if [ -z "$1" ]; then
	    [ "$verbose" -eq 1 ] && echo "$CCONF -c $conf -n $type.$id \"$key\""
	    eval "$var=\"`$CCONF -c $conf -n $type.$id \"$key\" || eval echo -n \"$def\"`\""
	else
	    [ "$verbose" -eq 1 ] && echo "$CCONF -c $conf -s $1 \"$key\""
	    eval "$var=\"`$CCONF -c $conf -s $1 \"$key\" || eval echo -n \"$def\"`\""
	fi
}
get_name_list() {
    orig="$*"

    # extract list of monitors, mdss, osds defined in startup.conf
    allconf="$local "`$CCONF -c $conf -l mon | egrep -v '^mon$' || true ; \
	$CCONF -c $conf -l mds | egrep -v '^mds$' || true ; \
	$CCONF -c $conf -l osd | egrep -v '^osd$' || true`

    if [ -z "$orig" ]; then
	what="$allconf"
	return
    fi

    what=""
    for f in $orig; do
	type=`echo $f | cut -c 1-3`   # e.g. 'mon', if $item is 'mon1'
	id=`echo $f | cut -c 4- | sed 's/\\.//'`
	case $f in
	    mon | osd | mds)
		for d in $allconf; do
		    if echo $d | grep -q ^$type; then
			what="$what $d"
		    fi
		done
		;;
	    *)
		if ! echo " " $allconf $local " " | egrep -q "( $type$id | $type.$id )"; then
		    echo "$0: $type.$id not found ($conf defines" $allconf", /var/lib/ceph defines" $local")"
		    exit 1
		fi
		what="$what $f"
		;;
	esac
    done
}
pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH=$PATH:$1
           else
              PATH=$1:$PATH
           fi
        fi


# Path manipulation
if [ `id -u` = 0 ]; then
        pathmunge /sbin
        pathmunge /usr/sbin
        pathmunge /usr/local/sbin
fi
}


#e exit_frank_common.sh
