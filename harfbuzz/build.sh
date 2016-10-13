#!/bin/bash -eu
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

cd /src/harfbuzz

# Build the library.
./autogen.sh
export LDFLAGS=$FUZZER_LDFLAGS
./configure
make clean all

$CXX $CXXFLAGS -std=c++11 -Isrc \
    /src/harfbuzz_fuzzer.cc -o /out/harfbuzz_fuzzer \
    /work/libfuzzer/*.o src/.libs/*.o src/hb-ucdn/.libs/*.o $FUZZER_LDFLAGS
