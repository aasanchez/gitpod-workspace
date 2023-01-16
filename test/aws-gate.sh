#!/usr/bin/env bash
echo 'Testing aws-gate Installation'
echo '----------'
echo ''
aws-gate --version || exit 1
echo ''
echo '----------'
