#!/bin/bash

if [ ! -f ~/.ssh/config ]; then
  echo "File '~/.ssh/config' not found."
  echo -n "Would you like to create one? (y/n): "
  read create_file

  if [ "$create_file" == "y" ]; then
    touch ~/.ssh/config
    echo "Created file '~/.ssh/config'."
  else
    echo "Exiting."
    exit 0
  fi
fi

while :
do
  echo -n "Enter 'HostName' (or 'q' to quit): "
  read hostname

  if [ "$hostname" == "q" ]; then
    break
  fi

  echo -n "Enter 'Host' [optional]: (or 'q' to quit): "
  read host

  if [ "$host" == "q" ]; then
    break
  fi

  if [ -z "$host" ]; then
    host=$hostname
  fi

  echo -n "Enter 'IdentityFile': "
  read identity_file

  if grep -q "Host $host" ~/.ssh/config; then
    echo "Entry for $host already exists. Skiping."
  else
    echo -e "\nHost $host\n\tHostName $hostname\n\tIdentityFile ~/.ssh/$identity_file\n\tUser git" >> ~/.ssh/config
    echo "Entry added for $host."
  fi

  echo -n "Press any key to add a new Identity ref or q to quit: "
  read add_identity

  if [ "$add_identity" == "q" ]; then
    break
  fi
done
