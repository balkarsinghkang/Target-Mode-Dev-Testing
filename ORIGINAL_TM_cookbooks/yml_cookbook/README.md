# Exported Chef Infra Repository for Policy 'openwrt'

Policy revision: 0026b5ac99b18d56ad7d8d6211f4ffbb8375a70745ab599777a2b5a56f56f97b

This directory contains all the cookbooks and configuration necessary for Chef
to converge a system using this exported policy. To converge a system with the
exported policy, use a privileged account to run `chef-client -z` from the
directory containing the exported policy.

## Contents:

### Policyfile.lock.json

A copy of the exported policy, used by the `chef push-archive` command.

### .chef/config.rb

A configuration file for Chef Infra Client. This file configures Chef Infra Client to
use the correct `policy_name` and `policy_group` for this exported repository. Chef
Infra Client will use this configuration automatically if you've set your working
directory properly.

### cookbook_artifacts/

All of the cookbooks required by the policy will be stored in this directory.

### policies/

A different copy of the exported policy, used by the `chef-client` command.

### policy_groups/

Policy groups are used by Chef Infra Server to manage multiple revisions of the same
policy. The default "local" policy is recommended for export use since there can be
no different revisions when not utilizing a server.
