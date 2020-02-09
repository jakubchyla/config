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

update_remote_repo() {
    if git checkout master; then
        git add .
        git commit -m "auto update" && git push origin master
    else
        echo "cannot checkout master!"
        exit 1
    fi
}

update_local_repo(){
    if git checkout master; then
        git pull origin master
    else
        echo "cannot checkout master!"
        exit 1
    fi
}


update_local_config(){
    cp -r backup/. ~/
}

#if run as root; rerun as jakchyla
if [ $(id -u) -eq 0 ];then
    if [ -z $SUDO_USER ]; then
        exec sudo -H -u $SUDO_USER $0 "$@"
    else
        echo "cannot change to non-root user!"
        exit 1
    fi
fi

cd $(dirname $(realpath $0))

if [ $# -eq 0 ];then
    backup
    update_remote_repo
else
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        backup-local)
        backup
        shift
        ;;
        backup)
        backup
        update_remote_repo
        shift
        ;;
        update-remote-repo)
        update_remote_repo
        shift
        ;;
        update-local-repo)
        update_local_repo
        shift
        ;;
        update-local-config)
        update_local_config
        shift
        ;;
        *)
        exit -1
        ;;
    esac
done
fi
