#  gbach.sh
#  ver 0.2
#
#  Copyright © 2014 mattux <andovais@gmail.com>
#  This work is free. You can redistribute it and/or modify it under the
#  terms of the Do What The Fuck You Want To Public License, Version 2,
#  as published by Sam Hocevar.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#  Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
#  Everyone is permitted to copy and distribute verbatim or modified
#  copies of this license document, and changing it is allowed as long
#  as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#  ---------------------------------------------------------------------


#! /bin/bash

# set these to execute the script in non-interactive mode, otherwise
# it runs in interactive mode.
user="";
password="";

# interactive mode
if [[ $user == "" && $password == "" ]];  then
      echo -e "\nusername:";
      read user

      echo -e "\npassword:";
      read -s password
fi

# retrieving the email feed
# donloading the feed | isolating lines that starts with <fullcount> and <title> | removing </title> | transforming &quote in "
email=$(curl -u $user:$password --silent "https://mail.google.com/mail/feed/atom" | egrep -o "<fullcount>+[0-9]*</fullcount>|<title>*[[:alpha:],[:punct:],[:space:],[0-9]{0,100}]*</title>" |  sed s/\<title\>//g| sed s/\&quot\;/\"/g);


n_email="Network problem. I'm not able to retrieve the email feed.";
# getting the number of undread emails
if [[ $email != "" ]];  then
      n_email=$(echo $email | grep -o "<fullcount>[0-9]*</fullcount>" | grep -o [0-9]*);
fi

echo -e "($n_email)";

# deleting the number of unread emails (<fullcount>NUMBER</fullcount)
email=$(echo $email | sed 's/<fullcount>[0-9]*<\/fullcount>//');


# printing the titles of the emails one per line
if [[ $n_email > 0 ]];  then
      echo $email | awk 'BEGIN { RS = "" ; FS = "</title>" } { for (i = 2; i <= NF-1; i++) print "-",$i }'
      # uncomment the following line to enable the notify
      #notify-send "$n_email emails to read!"
fi

exit 0;
