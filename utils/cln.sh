#!/bin/bash

#############################################################
#                                                           #
#  CLN - Collect LiNks                                      #
#  Xuan Huang @ 2019  https://github.com/huxpro             #
#                                                           #
#                                                           #
#  Install:                                                 #
#  $ ln -s path/to/cln.sh /usr/local/bin/cln -- add to path $
#                                                           #
#  Usage:                                                   #
#  $ cln <dir_contains_links>                -- collect     #
#  $ sh <dir_contains_links>/cln_gen.sh      -- replay      #
#                                                           #
#  TODO:                                                    #
#  - different user name                                    #
#  - different relative path                                #
#                                                           #
#############################################################

CWD="$(pwd)"
GEN="${CWD}/cln_gen.sh"

function traverse() {
  for file in "$1"/*    
  do
    # only looking for link
    if [ -L "${file}" ] ; then
        source="$(readlink -f ${file})"
        
        # trace
        echo "[CLN] reading link: ${file} -> ${source}"
        
        # append to gen
        echo "ln -s ${source} ${file}" >> "${GEN}"
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
    # prepend hashbang (not works well)
    # echo "$(echo "#!/bin/bash"; cat $GEN)" >> "${GEN}"

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


