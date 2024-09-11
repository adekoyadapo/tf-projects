variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type    = string
  default = "elb"
}

variable "labels" {
  type = map(string)
  default = {
    "created_by" = "terraform"
    "managed_by" = "ade"
  }
}

variable "image_url" {
  description = "The container image URL"
  type        = string
}

variable "cloud_id" {
  description = "Cloud ID value"
  type        = string
  sensitive   = true
}

variable "es_api_key" {
  description = "Elasticsearch API Key value"
  type        = string
  sensitive   = true
}

variable "azure_openai_api_key" {
  description = "Azure OpenAI API Key value"
  type        = string
  sensitive   = true
}

variable "azure_openai_endpoint" {
  description = "Azure OpenAI Endpoint value"
  type        = string
  sensitive   = true
}

variable "azure_openai_deployment_name" {
  description = "Azure OpenAI Deployment Name value"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 8501
}

variable "iap_brand_name" {
  description = "IAP Brand Name value - format: projects/{project_number}/brands/{brand_id}"
  type        = string
}

variable "iap_email" {
  description = "IAP Email value"
  type        = string
  default     = "ade.adekoya@elastic.co"
}

variable "iap_oauth2_client_name" {
  description = "IAP OAuth2 Client Name value"
  type        = string
  default     = "iap-client-cloudrun"
}
