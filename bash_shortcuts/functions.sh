#!/bin/bash

# Borrowed (but I plan to return it, with only slight wear and tear) from the extremely talented Michaël Ferrand.
# Modified for my own purposes.
function try(){
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function catch() {
  ex_code=$?
  case $ex_code in
    0)
      echo -e "By jove, he's got it! He's really got it!"
      ;;
    1)
      echo -e "Failed to rouse the dingo. The dingorouser will be sacked forthwith."
    ;;
    2)
      echo -e "Failed to add the identity file. Shadda had it but diddna. The shaddahaddabuhdiddna will be sacked forthwith."
    ;;
    *)
      echo -e "I'm stumped, ol' chap. Beware of this and that. Self-sacking imminent. Bip-bop and such."
      return $ex_code
    ;;
  esac
}

function wake_ssh(){
  local ex_code=0;

  trap 'catch' err

  echo -e "Attempting to rouse the lazy little dingo.\nThe person responsible for keeping him awake will be sacked.";
  [[ -z "$(ssh-agent -s)" ]] && return 1

  echo -e "Ooh he's feisty when he's sleepy, but he's up now! Let's see about having him add that identity file, shall we?";
  ssh-add ~/.ssh/id_ed25519 || return 2

  trap - ERR
  catch
}

