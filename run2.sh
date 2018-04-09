#!/bin/sh

export PATH=/root/cis520/pintos/src/utils:/root/cis520/usr/local/bin:$PATH
export BXSHARE=/root/cis520/usr/local/share/bochs

clear
clear

make

echo Entering directory /build ...
cd build

# Stop for the user to press the enter key
echo "0: Run page-merge-seq"
echo "1: Check page-merge-seq"
echo "2: Run page-linear"
echo "3: Check page-linear"
echo "4: Run page-parallel"
echo "5: Check page-parallel"
echo "6: Run page-merge-par"
echo "7: Check page-merge-par"
echo "8: Run page-merge-stk"
echo "9: Check page-merge-stk"
read -n1 -rp 'Select 0 - 9 ...' inputkey </dev/tty 
echo "" # new line hack


if [[ $inputkey == "0" || $inputkey == "1" ]]; then

echo Compiling page-merge-seq.c ...
gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/page-merge-seq.o tests/arc4.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/page-merge-seq

    if [[ $inputkey == "0" ]]; then
    
    echo Running page-merge-seq ...
    pintos -v -k -T 600 --bochs  --filesys-size=2 -p tests/vm/page-merge-seq -a page-merge-seq -p tests/vm/child-sort -a child-sort --swap-size=4 -- -q  -f run page-merge-seq
    
    else 
    
    echo Checking page-merge-seq ...
    pintos -v -k -T 600 --bochs  --filesys-size=2 -p tests/vm/page-merge-seq -a page-merge-seq -p tests/vm/child-sort -a child-sort --swap-size=4 -- -q  -f run page-merge-seq < /dev/null 2> tests/vm/page-merge-seq.errors > tests/vm/page-merge-seq.output

    perl -I../.. ../../tests/vm/page-merge-seq.ck tests/vm/page-merge-seq tests/vm/page-merge-seq.result
        
    fi
fi


if [[ $inputkey == "2" || $inputkey == "3" ]]; then

echo Compiling page-linear.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/page-linear.c -o tests/vm/page-linear.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/page-linear.d

gcc -fno-omit-frame-pointer -c ../../tests/arc4.c -o tests/arc4.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/page-linear.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/page-linear.o tests/lib.o tests/main.o lib/user/entry.o tests/arc4.o libc.a -o tests/vm/page-linear

    if [[ $inputkey == "2" ]]; then
    
    echo Running page-linear ...
    pintos -v -k -T 300 --bochs --filesys-size=2 -p tests/vm/page-linear -a page-linear --swap-size=4 -- -q  -f run page-linear

    else 
    
    echo Checking page-linear ...
    pintos -v -k -T 300 --bochs --filesys-size=2 -p tests/vm/page-linear -a page-linear --swap-size=4 -- -q  -f run page-linear < /dev/null 2> tests/vm/page-linear.errors > tests/vm/page-linear.output
    # pintos -v -k -T 300 --bochs --mem=8  --filesys-size=2 -p tests/vm/page-linear -a page-linear --swap-size=4 -- -q  -f run page-linear < /dev/null 2> tests/vm/page-linear.errors > tests/vm/page-linear.output

    perl -I../.. ../../tests/vm/page-linear.ck tests/vm/page-linear tests/vm/page-linear.result
        
    fi
fi
