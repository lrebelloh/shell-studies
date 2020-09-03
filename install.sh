#! /bin/bash

ORIGINAL_COLOR="\033[1;0m"
GREEN="\033[0;32m"
GRAY="\033[2m"
RED="\033[31m"

title() {
  echo -e "\n${GREEN}${1}...${ORIGINAL_COLOR}\n"
}

# ------------------------------------------------------------------------------
title "Creating backup & creating symlinks to new shell scripts"

cd ~/shell-studies/files
for file in *; do
  echo -ne "$file ${GRAY}"
  if [ ! -d ~/.shell_scripts ]; then
    echo "Error: Directory ~/.shell_scripts does not exists." 
    echo "Creating Directory ~/.shell_scripts"
    mkdir ~/.shell_scripts
    echo "Done!" 
  fi
  if [ -s ~/.shell_scripts/$file ]; then
    if ! diff -q ~/.shell_scripts/$file ~/shell-studies/files/$file &> /dev/null; then
      mv ~/.shell_scripts/$file ~/.shell_scripts/$file.bkp
      ln -s ~/shell-studies/files/$file ~/.shell_scripts/$file
      echo -ne "Has been moved to ~/.shell_scripts/$file.bkp and a new symlink has been created ${GREEN}✓${ORIGINAL_COLOR}\n"
    else
      echo -ne "Is identical ${RED}✕${ORIGINAL_COLOR}" 
    fi
  else
    ln -s ~/shell-studies/files/$file ~/.shell_scripts/$file
    echo -ne "symlink has been created ${GREEN}✓${ORIGINAL_COLOR}"
  fi
  echo -e "${ORIGINAL_COLOR}"
done
