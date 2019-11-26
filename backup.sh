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

if [[ "$BACKUP_DIR" = "" ]]; then
    echo "BACKUP_DIR not set!"
    exit -1
fi
cd $BACKUP_DIR

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        backup)
        backup
        shift
        ;;
        update_remote_repo)
        update_remote_repo
        shift
        ;;
        update_local_repo)
        update_local_repo
        shift
        ;;
        update_local_config)
        update_local_config
        shift
        ;;
    esac
done
