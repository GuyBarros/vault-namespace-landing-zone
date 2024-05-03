#--------------------------------
# This variable is a map of
# child - parent namespaces
#--------------------------------

variable "namespaces" {
  type = map(string)
  default = {
    "OrgA"  = ""     # example namespace without parent
    "TeamA" = "OrgA" # child namespace of OrgA
    "TeamB" = "OrgA" # child namespace of OrgA
    "TeamC" = "OrgA" # child namespace of OrgA
    "TeamD" = "OrgA" # child namespace of OrgA
    "TeamE" = "OrgA" # child namespace of OrgA
    "OrgB"  = ""     # example namespace without parent
    "TeamF" = "OrgB" # child namespace of OrgB
    "TeamG" = "OrgB" # child namespace of OrgB
    "TeamH" = "OrgB" # child namespace of OrgB
    "TeamI" = "OrgB" # child namespace of OrgB
    "TeamJ" = "OrgB" # child namespace of OrgB
    "OrgC"  = ""     # example namespace without parent
    "TeamK" = "OrgC" # child namespace of OrgB
  }

}

variable "default_namespace" {
  type = string
  default = "admin"
}

