#!/bin/sh

username=""
first=""
last=""

if [ $# -eq 0 ] ; then
	echo -e "---Error----\n-u  username\n-f  first-name\nlast-name";
fi
while [ "$1" != "" ]; do
    case $1 in
        -u | --username )		shift
                                username=$1
                                ;;
        -f | --first )    		shift
								first=$1
                                ;;
        -l | --last )           shift
                                last=$1
                                ;;
        * )						echo -e "---Error----\n-u  username\n-f  first name\n-l  last name"
								exit 1

    esac
    shift
done

if [ $username ]; 
then
    ./getData.sh | SSHSearch.pl $username
else 
    if (!$username || !$last) 
    then
        echo "Need both first and last name"
        exit
    fi

    echo -e "Searching.\c"
    fing_out=`finger $last`
    echo -e ".\c"
    #echo "$OUTPUT"
    grepped=`echo "$fing_out" | egrep -i "$last" | egrep -i "$first"`
    #echo "$grepped"
    
    if [[ $grepped =~ ^(Login:.)([a-z]*) ]]
    then 
        username=${BASH_REMATCH[2]};

        echo -e ".\c"
        ./getData.sh | SSHSearch.pl $username
    fi
fi



