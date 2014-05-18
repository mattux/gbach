<h1>GBaCh (Gmail Bach Checker) <h1> <h3is a Bash script that shows you how many unread
emails you have, and their title.</h3>

This script downloads the email feed of your gmail mailbox and print
the number, and the title of the unread emails.



It works in two different ways:
- interactive mode: the script asks you the credentials;
- non-interactive mode: the script don't asks you anything.

To activate the "non-interactive mode", just set $user
and $password in the source code, like this:
<b>user="my_username"<br /></b>
<b>password="my_password"</b>
