#!/bin/sh

#################################################
## Setup basic information for the script
##########################################¤######

HERE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TARGET="${HOME}"
HOMESOURCE=${HERE}/home
BACKUPDIR="${HERE}/.old"

source ${HERE}/utils.d/replace.sh

if [ -d ${BACKUPDIR} ]; then
  info "Backup old backup dir"
  mv "${BACKUPDIR}" "${BACKUPDIR}-`date -I`"
fi
mkdir -p ${BACKUPDIR}/
mkdir -p ${TARGET}/

do_replace() {
  replace "${HOMESOURCE}/$1" "${TARGET}/$1" "${BACKUPDIR}"
}

do_install() {
  replace "${HERE}/$1" "${TARGET}/$2" "${BACKUPDIR}"
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
