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

function wake_ssh(){
  try(
    echo -e "Attempting to rouse the lazy little dingo.\nThe person responsible for keeping him awake will be sacked.";
    [ eval $(ssh-agent -s); ] && throw $failedToRouseException
    echo -e "Ooh he's feisty when he's sleepy, but he's up now! Let's see about having him add that identity file, shall we?";
    ssh-add ~/.ssh/id_ed25519 || throw $failedToAddIdentityFile
    echo -e "By jove, he's got it! He's really got it!";
  ) catch || {
      case $ex_code in
        $failedToRouseException)
          echo -e "Failed to rouse the dingo. The dingorouser will be sacked forthwith."
        ;;
        $failedToAddIdentityFile)
          echo -e "Failed to add the identity file. Shadda had it but diddna. The shaddahaddabuhdiddna will be sacked forthwith."
        ;;
        *)
          echo -e "I'm stumped, ol' chap. Beware of this and that. Self-sacking imminent. Bip-bop and such."
          throw $ex_code
        ;;
      esac
  }
}
