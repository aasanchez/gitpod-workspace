#!/usr/bin/env bash
echo 'Testing Terraform Installation'
echo '----------'
echo ''
terraform --version || exit 1
echo ''
echo '----------'
