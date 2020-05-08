#! /bin/bash

backup() {
    if [ ! -d backup ]; then
        echo "no 'backup' directory!"
        exit -1
    fi
    for file in `find backup/ -type f`; do
        src_file=`echo $file | sed "s#backup#$HOME#"`
        dest_file=`readlink -f $file`
        cp $src_file $dest_file 2>/dev/null
    done
}

push() {
    if git checkout master; then
        git add .
        git commit -m "auto update"
        git push origin master
    else
        echo "cannot checkout master!"
        exit 1
    fi
}

pull(){
    if git checkout master; then
        git pull origin master
    else
        echo "cannot checkout master!"
        exit 1
    fi
}


update_local_config(){
    echo "updaing local config..."
    cp -r backup/. ~/
}

main(){
#if run as root; rerun as $SUDO_USER - fails if SUDO_USER is root
if [ $(id -u) -eq 0 ];then
    if ! [ -z $SUDO_USER ]; then
        exec sudo -H -u $SUDO_USER $0 "$@"
    else
        echo "cannot change to non-root user!"
        exit 1
    fi
fi

cd $(dirname $(realpath $0))

if [ $# -eq 0 ];then
    echo "no option given!"
    exit 1
fi
case $1 in
--push)
    backup
    push
    ;;
--pull)
    pull
    update_local_config
    ;;
    *)
    exit -1
    ;;
esac
exit 0
}

main "$@"
