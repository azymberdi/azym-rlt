terraform {
  backend "gcs" {
    bucket  = "rlt-test"
    prefix  = "/cluster-infrastructure"
    project = "rlt-test-295608"
  }
}
