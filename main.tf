
terraform {	
	required_providers {	
		sleuth = {		
			version = "0.1.0-dev"
			source	= "sleuth.io/core/sleuth"	
		}	
	}
}
provider "sleuth" {
    baseurl = "http://dev.sleuth.io"
    api_key = "60d77096f7bc7917c14e42dd4046faf3ff4257da"
}

resource "sleuth_project" "myproject" {
	name = "Deni's project"
}

resource "sleuth_environment" "myenvironment" {
	project_slug = "${sleuth_project.myproject.id}"
	name = "Production"
	description = "blah"
	color = "#aa33ff"
}

resource "sleuth_environment" "myenvironmentstg" {
	project_slug = "${sleuth_project.myproject.id}"
	name = "Staging"
	description = "blah 2"
	color = "#3333ff"
}

resource "sleuth_error_impact_source" "mysentry" {
	project_slug = "${sleuth_project.myproject.id}"
	environment_slug = "${sleuth_environment.myenvironment.id}"
	name = "Sentry"
	provider_type = "sentry"
	error_org_key = "sleuth-demo"
	error_project_key = "sleuth-dev"
	error_environment = "Production"
	manually_set_health_threshold = 42
}