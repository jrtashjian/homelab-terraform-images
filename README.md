# Terraform Images

> ⚠️ This repository is a parial fork of [gitlab-org/terraform-images](https://gitlab.com/gitlab-org/terraform-images.git).

This repository provides a docker image which contains the `gitlab-terraform` shell script. This script is a thin wrapper around the `terraform` binary. Its main purpose is to serve the [Infrastructure as code with Terraform and GitLab
](https://docs.gitlab.com/ee/user/infrastructure/), by extracting some of the standard configuration a user would need to set up to use the Terraform backend on GitLab as well as the Terraform merge request widget.

# How to use it

## Required Environment Variables

The wrapper expects three environment variables to be set:

### `TF_ADDRESS`

Should be the backend URL. For the GitLab backend it will be something like:

`"<GITLAB_API_URL>/projects/<PROJECT_ID>/terraform/state/<STATE_NAME>"`

- `GITLAB_API_URL` is the URL of your GitLab API (you can use `$CI_API_V4_URL` in [GitLab CI/CD](https://docs.gitlab.com/ee/ci/variables/index.html)).
- `PROJECT_ID` is the id of the project you're using as your infrastructure as code (you can use `$CI_PROJECT_ID` in [GitLab CI/CD](https://docs.gitlab.com/ee/ci/variables/index.html))
- `STATE_NAME` can be arbitrarily defined to the Terraform state name that you create.

### `TF_USERNAME`

Is your user login name, which must have maintainer access. If this is unset, it will default to the value of `GITLAB_USER_LOGIN` which is the username that triggered the build.

### `TF_PASSWORD`

An access token created for the above maintainer with the `api` scope. If this is unset, it will default to the value of `CI_JOB_TOKEN` and override the `TF_USERNAME` to match.

## Support for GitLab CI Environment Variables

`gitlab-terraform` exposes the following GitLab CI Environment Variables as `TF_VAR` inputs

- `CI_JOB_ID`

- `CI_COMMIT_SHA`

- `TF_VAR_CI_JOB_STAGE`

- `CI_PROJECT_ID`

- `CI_PROJECT_NAME`

- `CI_PROJECT_NAMESPACE`

- `CI_PROJECT_PATH`

- `CI_PROJECT_URL`

You can use these in your Terraform files in the following way

```
variable "CI_PROJECT_NAME" {
  type    = string
}
```

## Terraform lockfile handling

If you commit the `.terraform.lock.hcl` file to your repository we recommend setting `TF_INIT_FLAGS` to `-lockfile=readonly` to prevent changes to the lockfile.

# Release

Currently we release three versions of this image to support the last three stable major versions of Terraform.
The image versioning is documented [here](https://docs.gitlab.com/ee/user/infrastructure/iac/gitlab_terraform_helpers.html#terraform-images).
