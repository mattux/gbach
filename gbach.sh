#  gbach.sh
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

# set these to execute the script in auto-check mode, otherwise
# it runs in interactive mode.
user=""
password=""

# interactive mode
if [[ $user == "" && $password == "" ]]
   then
      echo -e "\nusername:";
      read user

      echo -e "\npassword:";
      read -s password
fi

# retrieving the email feed
mail=$(curl -u $user:$password --silent "https://mail.google.com/mail/feed/atom" | sed -n '/<title>/p' |  sed s/\<title\>//g| sed s/\&quot\;/\"/g);

n_email="Network problem. I'm not able to retrieve the email feed"

# fields number = n_email + 1
if [[ $mail != "" ]]
   then
      n_email=$(echo $mail | awk -F '</title>' '{print NF}');
      n_email=$(echo "$n_email - 2" | bc)
fi

echo -e "($n_email)";

# printing the titles of the emails one per line
if [[ $n_email > 0 ]]
   then
      echo $mail | awk 'BEGIN { RS = "" ; FS = "</title>" } { for (i = 2; i <= NF-1; i++) print "-",$i }'
      # de-comment the following line to enable the notify
      #notify-send "$n_email emails to read!"
fi

exit 0;
