#!/bin/sh

#################################################
## Setup basic information for the script
##########################################¤######

HERE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TARGET="${HOME}"
HOMESOURCE=${HERE}/home
BACKUPDIR="${HERE}/.old"
DIFFDIR="${HERE}/diff/`whoami`@`hostname`"

source ${HERE}/utils.d/replace.sh

dir_count() {
  echo $(ls -A "$1/" | wc -l)
}

if [ -d "${BACKUPDIR}" -a $(dir_count "$BACKUPDIR") -ne "0" ]; then
  oldbackup="${BACKUPDIR}-`date -I`"
  info "Backup old backup dir, ${oldbackup}"
  mv -v "${BACKUPDIR}" "$oldbackup"
fi

mkdir -p ${BACKUPDIR}/
mkdir -p ${TARGET}/
mkdir -p ${DIFFDIR}/

do_replace() {
  replace "${HOMESOURCE}/$1" "${TARGET}/$1" "${DIFFDIR}/$1" "${BACKUPDIR}"
}

do_install() {
  replace "${HERE}/$1" "${TARGET}/$2" "${DIFFDIR}/$1" "${BACKUPDIR}"
}

#################################################
## Indicate which files are to be installed
#################################################

do_replace ".xinitrc"
do_replace ".nvimrc"
do_replace ".zshrc"
do_replace ".i3"
do_replace ".config/i3status"
do_install "scripts" ".bin"

if [ $(dir_count "$BACKUPDIR") -eq "0" ]; then
  rmdir "$BACKUPDIR"
fi
