# blog runner

Example code for CircleCI Runners

[CircleCI Runner Docs](https://circleci.com/docs/2.0/runner-overview/)

[Installing the CircleCI Runner](https://circleci.com/docs/2.0/runner-installation/index.html)

## Create a CircleCI Namespace

Create a [CircleCI Personal API Token](https://circleci.com/docs/2.0/managing-api-tokens/#creating-a-personal-api-token)

# Install circleci cli
```shell
sudo curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash
``
# Create a CircleCI namespace you can have only one namespace per Organization
```shell
circleci namespace create ***<Name for namespace>*** github ***<VCS Organization>***
```

# Create a resource class in the CircleCI CLI (eg. namespace/<name for resource-class>)
```shell
circleci runner resource-class create ***namespace/<name for resource-class>*** "digital ocean runner"
```

# Create a token for authenticating the resource-class - Copy the token and save it

**NOTE:** Save the `Runner Token` value upon creating. This will be the only time the token will be visible. You will have to regenerate the token if you don't capture it on previous creation attempts. I suggest you assign the token value to a `$RUNNER_TOKEN` environment variable locally on the machine executing and provisioning your CircleCI Runners. This will prevent exposing this sensitive data in command line executions. 

```shell
circleci runner token create ***namespace/<resource-class name>*** ***"<description>"***
```

## Terraform execution commands for Digital Ocean provider

These are the commands for the terraform execution commands.

### Execute Plan
```shell
terraform plan \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_key_file=${HOME}/.ssh/id_rsa"
```

### Execute Apply
```shell
terraform apply \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_key_file=${HOME}/.ssh/id_rsa"
```

### Execute Apply with --auto-approve
```shell
terraform apply \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_key_file=${HOME}/.ssh/id_rsa" \
  -auto-approve
```

### Execute Destroy
```shell
terraform destroy \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_key_file=${HOME}/.ssh/id_rsa"
```

### Execute Destroy with --auto-approve
```shell
terraform destroy \
  -var "do_token=${DIGITAL_OCEAN_TOKEN}" \
  -var "runner_token=${RUNNER_TOKEN}" \
  -var "runner_name=dorunner" \
  -var "ssh_key_file=${HOME}/.ssh/id_rsa" \
  -auto-approve
```