#!/bin/bash

#############################################################
#                                                           #
#  CLN - Collect LiNks                                      #
#  Xuan Huang @ 2019  https://github.com/huxpro             #
#                                                           #
#                                                           #
#  Install:                                                 #
#  $ ln -s path/to/cln.sh some/where/in/your/PATH           #
#                                                           #
#  Usage:                                                   #
#  $ cln <dir_contains_links>                -- collect     #
#  $ sh <dir_contains_links>/.cln_gen.sh     -- replay      #
#                                                           #
#  Features:                                                #
#  - replace $HOME in path to `~`                           #
#                                                           #
#############################################################

CWD=`pwd`
GEN_NAME=".cln_gen.sh"
GEN="${CWD}/${GEN_NAME}"

function traverse() {
  for target in "$1"/*    
  do
    # only looking for link
    if [ -L "${target}" ] ; then

        # read canonical path
        # require GNU readlink (`brew i coreutils` on mac)
        source=`greadlink -f ${target}`
        echo "[CLN] reading link: ${target} -> ${source}"

        # relative to $HOME
        # echo "[CLN] relative-ize : ${target} -> ${source_rel}"
        source_rel="${source//$HOME/~}"

        # append to gen
        echo "ln -s ${source_rel} ${target}" >> "${GEN}"
    fi
  done
}


function main() {
  # trace
  echo "[CLN] collecting links from: ${CWD}"
  echo "[CLN] intend to generate: ${GEN}"

  # make sure fresh
  if [[ -f "${GEN}" ]]; then
    rm "${GEN}"
  fi

  # traverse
  traverse "$1"

  # print gen
  if [[ -f "${GEN}" ]]; then
    # prepend hashbang 
    echo "$(echo "#!/bin/bash"; cat $GEN)" > "${GEN}"

    # trace
    echo "[CLN] script generated: "
    cat "${GEN}"
  else
    echo "[CLN] no links found. "
  fi
}


# args check
if [ "$#" -ne 1 ]; then
  echo "$ cln <dir_contains_links>"
  exit 1
fi

main "$1"


