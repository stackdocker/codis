#!/bin/bash

# Wrapper around printf - clobber print since it's not POSIX anyway
print() { printf "%s\n" "$*"; }

die() {
	print "
Doing error:

$1" 1>&2
	exit ${2:-1}
}

set_var() {
	local var=$1
	shift
	local value="$*"
	eval "export $var=\"\${$var-$value}\""
}

vars_setup() {
	# Try to locate a 'vars' file in order of location preference.
	# If one is found, source it
	local vars=

	# set up program path
	local prog_vars="${0%/*}/vars"

	set_var CODIS_BASE	   "$(dirname $BASH_SOURCE[0])/.."
        set_var CODIS_BRANCH       "release3.1"
        set_var GOLANG_PKG         "go1.6.2.linux-amd64.tar.gz"
        set_var DOCKERFILE_SUFFIX  "debian:jessie"
        set_var IMAGE_NS           "tangfeixiong"
}

while :; do
	# Separate option from value:
	opt="${1%%=*}"
	val="${1#*=}"
	empty_ok= # Empty values are not allowed unless excepted

	case "$opt" in
	--image-os)
		empty_ok=1
		export DOCKERFILE_SUFFIX="$val"
		;;
	*)
		break ;;
	esac

	# fatal error when no value was provided
	if [ ! $empty_ok ] && { [ "$val" = "$1" ] || [ -z "$val" ]; }; then
		die "Missing value to option: $opt"
	fi

	shift
done

export IMAGE_NS="$1"

vars_setup


case $DOCKERFILE_SUFFIX in
	debian:jessie)
		docker build --no-cache -t $IMAGE_NS/codis:v3.1 -f $CODIS_BASE/hack/Dockerfile.${CODIS_BRANCH//\./%2E}.${GOLANG_PKG//\./%2E}.debian%3Ajessie $CODIS_BASE
		;;
	*)
		die "Unknown command '$cmd'. Run without commands for usage help."
		;;
esac
