#!/usr/bin/expect -f

set adminpassword [lindex $argv 0]
set timeout 5

spawn /opt/cloudhsm/bin/cloudhsm_mgmt_util /opt/cloudhsm/etc/cloudhsm_mgmt_util.cfg

expect -re "aws-cloudhsm*" {
  send "enable_e2e\r"
  send "loginHSM PRECO admin password\r"
  expect -re "success*"
  send "\r"
  send "changePswd PRECO admin $adminpassword\r"
  expect -re "continue*"
  send "y\r"
  expect -re "CAUTION*"
  send "\r"
  send "logoutHSM\r"
  send "\r"
  expect -re ""
}
exit
