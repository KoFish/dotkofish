#!/bin/sh

UTIL_HERE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TMPDIR=`mktemp -d`

source "${UTIL_HERE}/debug.sh"

# replace from_file, to_file, diff_file, backup_dir
replace() {
  local fromdir=`dirname $1`
  local fromfile=`basename $1`
  local todir=`dirname $2`
  local tofile=`basename $2`
  local diffdir=`dirname $3`
  local difffile=`basename $3`
  local backupdir=$4
  local srcpath=${fromdir}/${fromfile}
  local targetpath=${todir}/${tofile}
  local diffpath=${diffdir}/${difffile}
  local backuppath=${backupdir}/${fromfile}
  local tmppath="$TMPDIR/$tofile"
  if [ -e "$tmppath" ]; then
    warn "Remove old temp file $(gray)${tmppath}$(reset)"
    rm "$tmppath"
  fi
  if [ ! -e "$srcpath" ]; then
    warn "Source $(gray)${fromfile}$(reset) does not exist"
    return 0
  fi
  if [ -e "$diffpath" ]; then
    patch -p1 "$srcpath" "$diffpath" -o "$tmppath"
    if [ $? -ne 0 ]; then
      warn "Could not apply diff!"
      return 3
    fi
  fi
  ## If targetpath exists or exists but is a link
  if [ -e "$targetpath" -o -L "$targetpath" ]; then
    ## Store realpath to file
    oldrealfile=$( realpath -e $targetpath )
    if [ $? -ne 0 ]; then
      ## The realpath -e command failed the the file does not exist so we can
      ## remove the broken symlink
      info "Removing broken symlink $(gray)${targetpath}$(reset)"
      color_output
      rm -v --force "$targetpath"
      reset
    else
      if [ ! -e "$tmppath" -a "$oldrealfile" -ef "$srcpath" ]; then
        warn "$(gray)${tofile}$(reset) - The files have the same inode, doing nothing"
        return 0
      else
        diff "$tmppath" "$oldrealfile" &> /dev/null
        local is_same=$?
        if [ -e "$tmppath" -a $is_same -eq 0 ]; then
          info "New file is the same as current file, doing nothing"
          return 0
        else
          info "Making backup of old file"
          if [ "$targetpath" == "$oldrealfile" ]; then
            info "Move old file to backup ($(gray)${backuppath}$(reset))"
            color_output
            mv -v --no-clobber --force "$targetpath" "$backuppath"
            result=$?
            reset
          else
            info "Make backup of original old file ($(gray)${oldrealfile}$(reset)) instead of symlink"
            color_output
            cp -v --no-clobber --recursive "$oldrealfile" "$backuppath"
            result=$?
            rm -v "$targetpath"
            reset
          fi
          if [ $result -ne 0 ]; then
            err "Could not backup file, aborting!"
            return 1
          fi
        fi
      fi
    fi
  fi
  info "Install $(gray)${fromfile}$(reset)"
  color_output
  mkdir -p `dirname "${targetpath}"`
  reset
  if [ -d "$srcpath" ]; then
    result=1
  elif [ -e "$tmppath" ]; then
    color_output
    cp -v "$tmppath" "$targetpath"
    result=$?
    reset
  else
    color_output
    ln -v "$srcpath" "$targetpath"
    result=$?
    reset
  fi
  if [ -e "$tmppath" -a $result -eq 0 ]; then
    info "Patched file copied into place $(gray)${targetpath}$(reset)"
  elif [ $result -eq 0 ]; then
    info "Symlink $(gray)${targetpath}$(reset) created"
  else
    color_output
    ln -v --symbolic "$srcpath" "$targetpath"
    result=$?
    reset
  fi
  if [ $result -ne 0 ]; then
    err "Could not install file to new place"
    return 2
  fi
  return 0
}

