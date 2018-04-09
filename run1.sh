#!/bin/sh

export PATH=/root/cis520/pintos/src/utils:/root/cis520/usr/local/bin:$PATH
export BXSHARE=/root/cis520/usr/local/share/bochs

clear
clear

make

echo Entering directory /build ...
cd build

# Stop for the user to press the enter key
echo "0: Run mmap-unmap"
echo "1: Check mmap-unmap"
echo "2: Run mmap-write"
echo "3: Check mmap-write"
echo "4: Run mmap-overlap"
echo "5: Check mmap-overlap"
echo "6: Run mmap-clean"
echo "7: Check mmap-clean"
echo "8: Run mmap-exit"
echo "9: Check mmap-exit"
read -n1 -rp 'Select 0 - 9 ...' inputkey </dev/tty 
echo "" # new line hack

if [[ $inputkey == "0" || $inputkey == "1" ]]; then

echo Compiling mmap-unmap.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/mmap-unmap.c -o tests/vm/mmap-unmap.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/mmap-unmap.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-unmap.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-unmap

    if [[ $inputkey == "0" ]]; then
    
    echo Running mmap-unmap ...
    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-unmap -a mmap-unmap -p ../../tests/vm/sample.txt -a sample.txt --swap-size=4 -- -q  -f run mmap-unmap

    else 
    
    echo Checking mmap-unmap ...

    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-unmap -a mmap-unmap -p ../../tests/vm/sample.txt -a sample.txt --swap-size=4 -- -q  -f run mmap-unmap < /dev/null 2> tests/vm/mmap-unmap.errors > tests/vm/mmap-unmap.output
    
    perl -I../.. ../../tests/vm/mmap-unmap.ck tests/vm/mmap-unmap tests/vm/mmap-unmap.result
        
    fi
fi


if [[ $inputkey == "2" || $inputkey == "3" ]]; then

echo Compiling mmap-write.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/mmap-write.c -o tests/vm/mmap-write.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/mmap-write.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-write.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-write

    if [[ $inputkey == "2" ]]; then
    
    echo Running mmap-write ...
    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-write -a mmap-write --swap-size=4 -- -q  -f run mmap-write

    else 
    
    echo Checking mmap-write ...

    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-write -a mmap-write --swap-size=4 -- -q  -f run mmap-write < /dev/null 2> tests/vm/mmap-write.errors > tests/vm/mmap-write.output

    perl -I../.. ../../tests/vm/mmap-write.ck tests/vm/mmap-write tests/vm/mmap-write.result
        
    fi
fi


if [[ $inputkey == "4" || $inputkey == "5" ]]; then

echo Compiling mmap-overlap.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/mmap-overlap.c -o tests/vm/mmap-overlap.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/mmap-overlap.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-overlap.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-overlap

    if [[ $inputkey == "4" ]]; then
    
    echo Running mmap-overlap ...
    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-overlap -a mmap-overlap -p tests/vm/zeros -a zeros --swap-size=4 -- -q  -f run mmap-overlap

    else 
    
    echo Checking mmap-overlap ...

    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-overlap -a mmap-overlap -p tests/vm/zeros -a zeros --swap-size=4 -- -q  -f run mmap-overlap < /dev/null 2> tests/vm/mmap-overlap.errors > tests/vm/mmap-overlap.output

    perl -I../.. ../../tests/vm/mmap-overlap.ck tests/vm/mmap-overlap tests/vm/mmap-overlap.result

    fi
fi


if [[ $inputkey == "6" || $inputkey == "7" ]]; then

echo Compiling mmap-clean.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/mmap-clean.c -o tests/vm/mmap-clean.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/mmap-clean.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-clean.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-clean

    if [[ $inputkey == "6" ]]; then
    
    echo Running mmap-clean ...
    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-clean -a mmap-clean -p ../../tests/vm/sample.txt -a sample.txt --swap-size=4 -- -q  -f run mmap-clean

    else 
    
    echo Checking mmap-clean ...

    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-clean -a mmap-clean -p ../../tests/vm/sample.txt -a sample.txt --swap-size=4 -- -q  -f run mmap-clean < /dev/null 2> tests/vm/mmap-clean.errors > tests/vm/mmap-clean.output
    
    perl -I../.. ../../tests/vm/mmap-clean.ck tests/vm/mmap-clean tests/vm/mmap-clean.result
        
    fi
fi


if [[ $inputkey == "8" || $inputkey == "9" ]]; then

echo Compiling mmap-exit.c ...
gcc -fno-omit-frame-pointer -c ../../tests/vm/mmap-exit.c -o tests/vm/mmap-exit.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/mmap-exit.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-exit.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-exit

echo Compiling child-mm-wrt.c ...

gcc -fno-omit-frame-pointer -c ../../tests/vm/child-mm-wrt.c -o tests/vm/child-mm-wrt.o -g -msoft-float -O -march=i686 -fno-stack-protector -nostdinc -I../.. -I../../lib -I../../lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers  -MMD -MF tests/vm/child-mm-wrt.d

gcc -fno-omit-frame-pointer  -Wl,--build-id=none -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/child-mm-wrt.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/child-mm-wrt

    if [[ $inputkey == "8" ]]; then
    
    echo Running mmap-exit ...
    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-exit -a mmap-exit -p tests/vm/child-mm-wrt -a child-mm-wrt --swap-size=4 -- -q  -f run mmap-exit
    
    else 
    
    echo Checking mmap-exit ...

    pintos -v -k -T 60 --bochs  --filesys-size=2 -p tests/vm/mmap-exit -a mmap-exit -p tests/vm/child-mm-wrt -a child-mm-wrt --swap-size=4 -- -q  -f run mmap-exit < /dev/null 2> tests/vm/mmap-exit.errors > tests/vm/mmap-exit.output

    perl -I../.. ../../tests/vm/mmap-exit.ck tests/vm/mmap-exit tests/vm/mmap-exit.result

    fi
fi

