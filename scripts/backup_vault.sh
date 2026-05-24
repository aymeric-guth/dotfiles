#!/bin/sh

# tar -zcvf /home/yul/Backup/vault101/$(date "+%Y-%m-%d")_vault101.tar.gz /home/yul/Documents/vault101
7z a -p"$(cat ~/.archive_pass)" -mhe=on /home/yul/Backup/vault101/$(date "+%Y-%m-%d")_vault101.7z /home/yul/Documents/vault101
