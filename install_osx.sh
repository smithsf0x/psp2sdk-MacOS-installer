#!/bin/bash

#// smithsf0x

err_ident=null

install_psp2sdk(){
    export PATH=$DEVKITARM/bin:$PATH
    if [ "$" == "--show" ] 
        then
            ./autogen.sh --prefix=$PSP2SDK
            cd src && make install
            cd ..
            cd tools && make install
        else
            
            echo -ne "|Running autogen.sh with Prefix:   "
            ./autogen.sh --prefix=$PSP2SDK >& /dev/null && err_ident=$?
            if [ err_ident ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
            fi

            echo -ne "|Making and Installing PSP2SDK:    "
            cd src && make install >& /dev/null && err_ident=$?
            if [ err_ident ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
            fi

            cd ..
            echo -ne "|Making and Installing psp2-fixup: "
            cd tools && make install >& /dev/null && err_ident=$?
            if [ err_ident ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
            fi
    fi
}

install_psp2sdk
echo "|------------------------------|"
echo "| Thanks to doobz for his help |"
echo "|----------~FINISHED~----------|"