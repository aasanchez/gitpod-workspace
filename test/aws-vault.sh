#!/usr/bin/env bash
echo 'Testing aws-vault Installation'
echo '----------'
echo ''
aws-vault --version || exit 1
echo ''
echo '----------'
