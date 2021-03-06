#!/bin/bash

#// smithsf0x

err_ident=null

err_flag=0

argument=$1

install_psp2sdk(){
    export PATH=$DEVKITARM/bin:$PATH
    if [ "$argument" == "-show" ] 
        then
            ./autogen.sh --prefix=$PSP2SDK
            cd src && make install
            cd ..
            cd tools && make install
            clear
        else
            echo -ne "|Running autogen.sh with Prefix:     "
            ./autogen.sh --prefix=$PSP2SDK >& /dev/null
            err_ident=$?
            if [ $err_ident == 0 ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
                    err_flag=1
            fi

            echo -ne "|Making and Installing PSP2SDK:      "
            cd src >& /dev/null && make install >& /dev/null
            err_ident=$?
            if [ $err_ident == 0 ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
                    err_flag=1
            fi

            echo -ne "|Making and Installing psp2-fixup:   "
            cd ../tools >& /dev/null && make install >& /dev/null
            err_ident=$?
            if [ $err_ident == 0 ]
                then
                    echo "DONE"
                else
                    echo "ERROR"
                    err_flag=1
            fi
    fi
}

install_psp2sdk
echo "|------------------------------|"
echo "| Thanks to doobz for his help |"
if [ $err_flag == 1 ]
    then
        echo "|-----------~ERROR~------------|"
        echo "|  Run 'install_osx.sh -show'  |"
    else
        echo "|----------~FINISHED~----------|"
fi
echo "|______________________________|"