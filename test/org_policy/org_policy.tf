#############################################################################################################################################################
#ORGANIZATION POLICIES/CONSTRAINT REQUIRED FOR THE RESOURCES/PRODUCT WE ARE USING                                                                           #
#INSIDE OUR TERRAFORM SCRIPTS.                                                                                                                              #
#ALLOWS MANAGEMENT OF ORGANIZATION POLICIES FOR A GOOGLE CLOUD PROJECT                                                                                      #      
#BOOLEAN CONSTRAINT POLICY CAN BE USED TO EXPLICITLY ALLOW A PARTICULAR CONSTRAINT ON AN INDIVIDUAL PROJECT, REGARDLESS OF HIGHER LEVEL POLICIES            #
#LIST CONSTRAINT POLICY THAT CAN DEFINE SPECIFIC VALUES THAT ARE ALLOWED OR DENIED FOR THE GIVEN CONSTRAINT. IT CAN ALSO BE USED TO ALLOW OR DENY ALL VALUES#
#############################################################################################################################################################
/*
resource "google_project_organization_policy" "serial_port_policy" {
  project     = var.project_id
  constraint = "compute.disableSerialPortAccess"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "disableNestedVirtualization" {
  project     = var.project_id
  constraint = "compute.disableNestedVirtualization"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "skipDefaultNetworkCreation" {
  project     = var.project_id
  constraint = "compute.skipDefaultNetworkCreation"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "vmExternalIpAccess" {
  project     = var.project_id
  constraint = "compute.vmExternalIpAccess"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "disableInternetNetworkEndpointGroup" {
  project     = var.project_id
  constraint = "compute.disableInternetNetworkEndpointGroup"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "requireShieldedVm" {
  project     = var.project_id
  constraint = "compute.requireShieldedVm"
  boolean_policy {
    enforced = false
  }
}
resource "google_project_organization_policy" "trustedImageprojects" {
  project     = var.project_id
  constraint = "compute.trustedImageProjects"
  list_policy {
    allow {
     all = true
     }
 }
}
resource "google_project_organization_policy" "storageresourceUseRestrictions" {
  project     = var.project_id
  constraint = "compute.storageresourceUseRestrictions"
  list_policy {
    allow {
      all = false
    }
  }
}
resource "google_project_organization_policy" "restrictVpnPeerIPs" {
  project     = var.project_id
  constraint = "compute.restrictVpnPeerIPs"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "restrictVpcPeering" {
  project     = var.project_id
  constraint = "compute.restrictVpcPeering"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "vmCanIpForward" {
  project     = var.project_id
  constraint = "compute.vmCanIpForward"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "restrictDedicatedInterconnectUsage" {
  project     = var.project_id
  constraint = "compute.restrictDedicatedInterconnectUsage"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "restrictPartnerInterconnectUsage" {
  project     = var.project_id
  constraint = "compute.restrictPartnerInterconnectUsage"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "allowedIngressSettings" {
  project     = var.project_id
  constraint = "cloudfunctions.allowedIngressSettings"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "allowedPolicyMemberDomains" {
  project     = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "allowServiceAccountCredentialLifetimeExtension" {
  project     = var.project_id
  constraint = "iam.allowServiceAccountCredentialLifetimeExtension"
  list_policy {
    allow {
      all = true
    }
  }
}
resource "google_project_organization_policy" "uniformBucketLevelAccess" {
  project     = var.project_id
  constraint = "storage.uniformBucketLevelAccess"
  boolean_policy {
    enforced = false
  }
}
resource "google_project_organization_policy" "restrictAuthorizedNetworks" {
  project     = var.project_id
  constraint = "sql.restrictAuthorizedNetworks"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "automaticIamGrantsForDefaultServiceAccounts" {
  project     = var.project_id
  constraint = "iam.automaticIamGrantsForDefaultServiceAccounts"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "disableServiceAccountKeyCreation" {
  project     = var.project_id
  constraint = "iam.disableServiceAccountKeyCreation"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "disableServiceAccountKeyUpload" {
  project     = var.project_id
  constraint = "iam.disableServiceAccountKeyUpload"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_organization_policy" "disableCodeDownload" {
  project     = var.project_id
  constraint = "appengine.disableCodeDownload"
  boolean_policy {
    enforced = true
  }
}
resource "google_project_service" "enable_bigquery_api" {
  project = var.project_id
  service = "bigquery.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy =true
}
resource "google_project_service" "enable_iam_apis" {
  project = var.project_id
  service = "iam.googleapis.com"
  disable_dependent_services = true
}
resource "google_project_service" "enable_cloud_resource_manager_api" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}
*/