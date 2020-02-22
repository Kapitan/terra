#!/bin/bash

function hwinfo {

    srcfile="ssh_servers.list"
    srctmpfile="ssh_servers.tmp"

    if [ -n "$(cat $srcfile)" ] && [ -f $srcfile ]
    then
        cat /dev/null > $srctmpfile
        for address in $(cat $srcfile)
        do
            ping -c 1 -W 1 $address &> /dev/null
            if [ $? -eq 0 ]; then printf "$address\n" >> $srctmpfile; else :; fi
        done
    else :
    fi

    if [[ -n $(cat $srctmpfile) ]] && [ -f $srctmpfile ]
    then
        if [ $(cat $srctmpfile|wc -l) -ge "1" ]
        then
            case $1 in
            mem)
            echo $(cat $srctmpfile | xargs -I NAME echo "ssh NAME \"free -m\";")
            ;;
            cpu)
            echo $(cat $srctmpfile | xargs -I NAME echo "ssh NAME \"cat /proc/cpuinfo\";")
            ;;
            *)
            echo "Use cpu or mem"
            ;;
            esac

        else
            case $1 in
            mem)
            echo "ssh $(cat $srctmpfile) \"free -m\""
            ;;
            cpu)
            echo "ssh $(cat $srctmpfile) \"cat /proc/cpuinfo\""
            ;;
            *)
            echo "Use cpu or mem"
            ;;
            esac
        fi
    else
        printf "file ${srctmpfile} doesn't exist or empty...\n"
    fi
}


hwinfo $1