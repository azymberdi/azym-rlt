terraform {
  backend "gcs" {
    bucket  = "rlt"
    prefix  = "/cluster-infrastructure"
    project = "rlt-test-295608"
  }
}
