package builtin.dockerfile.DS011

import rego.v1

test_basic_denied if {
	r := deny with input as {"Stages": [{"Name": "alpine:3.3", "Commands": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock", "my_app"],
		},
	]}]}

	count(r) == 1
	r[_].msg == "Slash is expected at the end of COPY command argument 'my_app'"
}

test_two_args_allowed if {
	r := deny with input as {"Stages": [{"Name": "alpine:3.3", "Commands": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock"],
		},
	]}]}

	count(r) == 0
}

test_three_args_with_file_colon_in_allowed if {
	r := deny with input as {"Stages": [{"Name": "alpine:3.3", "Commands": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["file:8b8864b3e02a33a579dc216fd51b28a6047bc8eeaa03045b258980fe0cf7fcb3", "in", "myfile"],
		},
	]}]}

	count(r) == 0
}

test_three_args_with_multi_colon_in_allowed if {
	r := deny with input as {"Stages": [{"Name": "alpine:3.3", "Commands": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["multi:8b8864b3e02a33a579dc216fd51b28a6047bc8eeaa03045b258980fe0cf7fcb3", "in", "myfile"],
		},
	]}]}

	count(r) == 0
}

test_three_arg_allowed if {
	r := deny with input as {"Stages": [{"Name": "alpine:3.3", "Commands": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock", "myapp/"],
		},
	]}]}

	count(r) == 0
}
