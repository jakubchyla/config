#! /bin/bash

backup() {
for file in `find backup/ -type f`; do
    src_file=`echo $file | sed "s#backup#$HOME#"`
    dest_file=`readlink -f $file`
    cp $src_file $dest_file 2>/dev/null
done
}

update_remote_repo() {
    git add .
    git commit -m "auto update" && git push
}

update_local_repo(){
    git pull
}


update_local_config(){
    cp -r backup/. ~/
}

#if run as root; rerun as jakchyla
if [ $(id -u) -eq 0 ];then
    exec sudo -H -u jakchyla $0 "$@"
fi

cd $(dirname $(realpath $0))

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
    esac
done
