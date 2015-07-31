#!/bin/sh

UTIL_HERE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TMPDIR=`mktemp -d`

source "${UTIL_HERE}/debug.sh"

replace_symlink() {
  local file="$1"
  if [ -L "$file" ]; then
    realfile=$( realpath -e $file )
    if [ $? -ne 0 ]; then
      info "Target file is a broken symlink, remove it: $(gray)$(realpath $file)$(reset)"
      color_output
      rm -v --force "$file"
      reset
    else
      info "Target file is a symlink, replace it with the target"
      color_output
      rm -v --force "$file"
      cp -v "$realfile" "$file"
      reset
    fi
  fi
}

create_patch_file() {
  local new=$1
  local current=$2
  local diff=$3

  if [ -e "$diff" ]; then
    warn "Diff file $(gray)${diff}$(reset) already exists"
    return 2
  fi

  diff --unified "$new" "$current" > $diff
  local result=$?
  if [ $result -eq 1 ]; then
    # Files where different
    return 0
  else
    # There where no difference between the files
    rm --force "$diff"
    return 1
  fi
}

create_patched_file() {
  local new=$1
  local diff=$2
  local current=$3

  if [ -e "$current" ]; then
    warn "File $(gray)${current}$(reset) already exists"
    return 2
  fi

  if [ -e "$diff" ]; then
    patch -p1 "$new" "$diff" -o "$current"
    if [ $? -ne 0 ]; then
      warn "Could not apply diff!"
    else
      return 0
    fi
  fi
  return 1
}

backup_target_file() {
  local src=$1
  local target=$2
  local backup=$3
  if [ -e "$target" ]; then
    diff "$src" "$target" &> /dev/null
    if [ $? -ne 0 ]; then
      info "Making backup of old file, $(gray)${target}$(reset)"
      color_output
      mv -v --no-clobber --force "$target" "$backup"
      local result=$?
      reset
      if [ $result -ne 0 ]; then
        err "Could not backup file, aborting!"
        return 1
      fi
    fi
  fi
}

install_file() {
  local src=$1
  local target=$2
  local result=0
  info "Install $(gray)${src}$(reset)"

  color_output
  mkdir -p `dirname "${target}"`
  reset

  if [ -d "$src" ]; then
    err "Source is a directory, not handled yet"
    result=1
  else
    diff "$src" "$target" &> /dev/null
    if [ $? -eq 1 ]; then
      color_output
      cp -v "$src" "$target"
      result=$?
      reset
    else
      info "Source and target file do not differ, no copying"
    fi
  fi
  return $result
}

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
  local result=0
  if [ -e "$tmppath" ]; then
    warn "Remove old temp file $(gray)${tmppath}$(reset)"
    color_output
    rm -v "$tmppath"
    reset
  fi
  if [ ! -e "$srcpath" ]; then
    warn "Source $(gray)${fromfile}$(reset) does not exist"
    return 0
  fi
  create_patched_file "$srcpath" "$diffpath" "$tmppath"
  result=$?
  local newsrc="$srcpath"
  if [ $result -eq 0 -a -e "$tmppath" ]; then
    newsrc="$tmppath"
  elif [ $result -gt 1 ]; then
    return 3
  fi
  replace_symlink "$targetpath" 
  backup_target_file "$newsrc" "$targetpath" "$backuppath"

  install_file "$newsrc" "$targetpath" "$backuppath"
  result=$?

  if [ $result -eq 0 ]; then
    info "File successfully installed, $(gray)${target}$(reset)"
  else
    warn "Could not install file" 
  fi
  return $result
}

# vim: ts=2 sw=2
