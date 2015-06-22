#!/bin/sh

UTIL_HERE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source "${UTIL_HERE}/debug.sh"

# replace from_dir, from_file, to_dir, to_file, backup_dir
replace() {
  local fromdir=`dirname $1`
  local fromfile=`basename $1`
  local todir=`dirname $2`
  local tofile=`basename $2`
  local backupdir=$3
  local srcfile=${fromdir}/${fromfile}
  local targetfile=${todir}/${tofile}
  local backupfile=${backupdir}/${fromfile}
  if [ ! -e "$srcfile" ]; then
    warn "Source $(gray)${fromfile}$(reset) does not exist"
    return 0
  fi
  if [ -e "$targetfile" -o -L "$targetfile" ]; then
    oldrealfile=$( realpath $targetfile )
    if [ $? -ne 0 -o "x$oldrealfile" == "x" ]; then
      info "Removing broken symlink $(gray)${targetfile}$(reset)"
      color_output
      rm -v --force "$targetfile"
      reset
    else
      if [ "$oldrealfile" -ef "$srcfile" ]; then
        warn "$(gray)${tofile}$(reset) - The files have the same inode, doing nothing"
        return
      else
        info "Making backup of old file"
        if [ "$targetfile" == "$oldrealfile" ]; then
          info "Move old file to backup ($(gray)${backupfile}$(reset))"
          color_output
          mv -v --no-clobber --force "$targetfile" "$backupfile"
          result=$?
          reset
        else
          info "Make backup of original old file ($(gray)${oldrealfile}$(reset)) instead of symlink"
          color_output
          cp -v --no-clobber --recursive "$oldrealfile" "$backupfile"
          result=$?
          rm -v "$targetfile"
          reset
        fi
        if [ $result -ne 0 ]; then
          err "Could not backup file, aborting!"
          return 1
        fi
      fi
    fi
  fi
  info "Install $(gray)${fromfile}$(reset)"
  color_output
  mkdir -p `dirname "${targetfile}"`
  reset
  if [ -d "$srcfile" ]; then
    result=1
  else
    color_output
    ln -v "$srcfile" "$targetfile"
    result=$?
    reset
  fi
  if [ $result -eq 0 ]; then
    info "Symlink $(gray)${targetfile}$(reset) created"
  else
    color_output
    ln -v --symbolic "$srcfile" "$targetfile"
    result=$?
    reset
  fi
  if [ $result -ne 0 ]; then
    err "Could not symlink file to new place"
    return 2
  fi
  return 0
}

