#!/bin/bash

# Borrowed (but I plan to return it, with only slight wear and tear) from the extremely talented Michaël Ferrand.
# Modified for my own purposes.
function try(){
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function throw(){
    exit $1
}

function catch(){
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

function throwErrors(){
    set -e
}

function ignoreErrors(){
    set +e
}

wake_ssh () {
  echo -e "Attempting to rouse the lazy little dingo.\nThe person responsible for keeping him awake will be sacked.";
  eval $(ssh-agent -s);
  echo -e "Ooh he's feisty when he's sleepy, but he's up now! Let's see about having him add that identity file, shall we?";
  ssh-add ~/.ssh/id_ed25519;
  echo -e "By jove, he's got it! He's really got it!";
}
