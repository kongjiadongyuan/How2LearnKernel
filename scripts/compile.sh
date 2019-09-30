#!/bin/sh
export CONCURRENCY_LEVEL=20
fakeroot make-kpkg --initrd kernel_image kernel_headers
