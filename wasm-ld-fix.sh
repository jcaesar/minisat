#!/usr/bin/env bash

set -eu

dir="$(dirname "$0")"

declare -a args
while test $# -gt 0; do
	case $1 in
		--as-needed|--no-undefined|--start-group|--end-group)
		;;
		*.a)
			args+=("$1")
			"$dir/ranlib" "$1"
			;;
		*)
			args+=("$1")
	esac
	shift
done

set -x
exec "$dir/wasm-ld-orig" ${args[@]+"${args[@]}"}
