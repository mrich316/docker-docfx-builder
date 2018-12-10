#!/bin/sh
set -e

DOCFX_CMD=/opt/docfx/docfx.exe

usage() {
  mono "$DOCFX_CMD" --help
}

command=${1:-help}
shift $(( $# > 0 ? 1 : 0 ))

case "$command" in

    docfx)
        mono "$DOCFX_CMD" $@
        ;;

    build|dependency|download|init|merge|metadata|pdf|serve|template)
        mono "$DOCFX_CMD" $command $@
        ;;

    *)
        usage
        exit 1
esac
