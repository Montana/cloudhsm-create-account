#!/usr/bin/expect -f

set adminpassword [lindex $argv 0]
set newusername [lindex $argv 1]
set newuserpwd [lindex $argv 2]
set timeout 5

spawn /opt/cloudhsm/bin/cloudhsm_mgmt_util /opt/cloudhsm/etc/cloudhsm_mgmt_util.cfg

expect -re "aws-cloudhsm*" {
  send "enable_e2e\r"
  send "loginHSM CO admin $adminpassword\r"
  expect -re "success*"
  send "\r"
  send "createUser CU $newusername $newuserpwd\r"
  expect -re "continue*"
  send "y\r"
  expect -re "success"
  send "\r"
  send "listUsers\r"
  send "\r"
  send "quit\r"
}
exit
