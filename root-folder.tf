
locals {
  files = [
    ".github/workflows/atat-manual-docker-build.yaml",
    "src/docker/github-actions-runner/Dockerfile",
    "src/docker/github-actions-runner/entrypoint.sh"
  ]
}

resource "github_repository_file" "bulk" {

  for_each = toset(local.files)

  repository          = var.repository
  branch              = var.branch
  file                = each.key
  content             = file("${path.module}/files/${each.key}")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
