package builtin.kubernetes.KCV0054

import rego.v1

test_validate_spec_permission_equal_600 if {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "NodeInfo",
		"type": "master",
		"info": {"kubeEtcdSpecFilePermission": {"values": [600]}},
	}

	count(r) == 0
}

test_validate_spec_permission_lower_600 if {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "NodeInfo",
		"type": "master",
		"info": {"kubeEtcdSpecFilePermission": {"values": [500]}},
	}

	count(r) == 0
}

test_validate_spec_permission_higher_600 if {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "NodeInfo",
		"type": "master",
		"info": {"kubeEtcdSpecFilePermission": {"values": [700]}},
	}

	count(r) == 1
}
