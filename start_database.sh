#!/usr/bin/expect -f

set timeout -1

spawn gcloud sql connect postgresdbs --database=travels_db --user=datastream --quiet

expect "*Password*"

send -- "password\r"

expect eof