##===- lib/Support/Makefile --------------------------------*- Makefile -*-===##
#
#                     The LLVM Compiler Infrastructure
#
# This file is distributed under the University of Illinois Open Source
# License. See LICENSE.TXT for details.
#
##===----------------------------------------------------------------------===##

LEVEL = ../..
LIBRARYNAME = LLVMSupport
BUILD_ARCHIVE = 1

## FIXME: This only requires RTTI because tblgen uses it.  Fix that.
REQUIRES_RTTI = 1

# -DLLVM_DEBIAN_INFO='" ($(OS) $(VERSION))"'
CPP.Flags = $(DebianOpts)

EXTRA_DIST = Unix Win32 README.txt

include $(LEVEL)/Makefile.common

CompileCommonOpts := $(filter-out -pedantic,$(CompileCommonOpts))
CompileCommonOpts := $(filter-out -Wno-long-long,$(CompileCommonOpts))
