wake_ssh () {
  echo -e "Attempting to rouse the lazy little dingo.\nThe person responsible for keeping him awake will be sacked.";
  eval $(ssh-agent -s);
  echo -e "Ooh he's feisty when he's sleepy, but he's up now! Let's see about having him add that identity file, shall we?";
  ssh-add ~/.ssh/id_ed25519;
  echo -e "By jove, he's got it! He's really got it!";
}