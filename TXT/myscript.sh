#!/bin/bash

# Copyright (C) 2021 dnswd
# My useful bash script

printf "\nStarting myscript.sh\n\n"

# Code below is copied from https://github.com/cbkadal/os211/blob/master/TXT/myscript.sh
# Credit to Mr. Rahmat M. Samik-Ibrahim

# =============== BEGIN COPIED CODE ===================
# Copyright (C) 2020-2021 Cicak Bin Kadal
# https://www.youtube.com/watch?v=KAXK07ni9gU

# This free document is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# REV05 Sat 27 Mar 00:12:28 WIB 2021
# REV04 Mon 15 Mar 19:27:52 WIB 2021
# REV03 Sun 14 Mar 18:21:27 WIB 2021
# REV02 Fri 12 Mar 13:40:58 WIB 2021
# REV01 Tue 13 Oct 10:37:14 WIB 2020
# START Mon 28 Sep 21:05:04 WIB 2020

# ATTN:
# You new to set "REC2" with your own Public-Key Identity!
# Check it out with "gpg --list-key"

# Modified by: Dennis (dnswd)

REC2="dennisaw2000@gmail.com" # "cbk@dummy"
REC1="operatingsystems@vlsm.org"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

[ -d $HOME/RESULT ] || mkdir -p $HOME/RESULT
pushd $HOME/RESULT
for II in W?? ; do
    [ -d $II ] || continue
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo ""
    echo "=== CONTENTS OF /RESULT/$II/ ==="
    ls -altr ./$II
    echo "=== END CONTENTS ==="
    echo "tar cfj $TARFILE $II/"
    tar cfj $TARFILE $II/
    echo "gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
    echo ""
done
popd

rm -f $HOME/RESULT/fakeDODOL
for II in $HOME/RESULT/myW*.tar.bz2.asc ; do
   echo "Check and move $II..."
   [ -f $II ] && mv -f $II .
done

echo -e "\nrm -f $SHA $SHA.asc"
rm -f $SHA $SHA.asc

echo -e "\nsha256sum $FILES > $SHA"
sha256sum $FILES > $SHA

echo -e "\nsha256sum -c $SHA"
sha256sum -c $SHA

echo -e "\ngpg -o $SHA.asc -a -sb $SHA"
gpg -o $SHA.asc -a -sb $SHA

echo -e "\ngpg --verify $SHA.asc $SHA"
gpg --verify $SHA.asc $SHA

# exit 0


# =============== END COPIED CODE ===================

# Check for untracked/uncommited files first
# echo "Starting program at $(date)"

printf "\nChecking for untracked files...\n"
UNTRACKED=$( git ls-files --exclude-standard --others | wc -l)
if [[ $UNTRACKED -ne 0 ]]; then
	echo "Found $UNTRACKED untracked or uncommited files"
	>&2 echo "Don't forget to add them!"
	>&2 echo "========================="
	>&2 echo $(git ls-files --exclude-standard --others)
	>&2 echo "========================="
    else
	printf "Your tree is clean, please commit your changes\n"
fi

printf "\nFound $(git ls-files --exclude-standard -m | wc -l) files pending for commit.\n"

exit 0

