#
# A generic makefile creating builds with CMake
#
TOPLEVEL_BUILD_DIRECTORY = ./build
CC=gcc-7.3
CXX=g++-7.3

MAKEFILE = $(BUILD_DIRECTORY)/Makefile

CMAKE_FLAGS_COMMON = \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_CXX_FLAGS="-Wall -Werror -pedantic" \
  -DCMAKE_CXX_FLAGS_RELWITHDEBINFO=-O3 -g


.PHONY: all
all: release

#
# ... Release
#

BUILD_DIRECTORY_RELEASE = $(TOPLEVEL_BUILD_DIRECTORY)/release
CMAKE_CACHE_RELEASE = $(BUILD_DIRECTORY_RELEASE)/CMakeCache.txt
CMAKE_FLAGS_RELEASE = $(CMAKE_FLAGS_COMMON) -DCMAKE_BUILD_TYPE=Release

.PHONY: release
release: $(CMAKE_CACHE_RELEASE) $(BUILD_DIRECTORY_RELEASE)
	cd $(BUILD_DIRECTORY_RELEASE) && make && make test

$(CMAKE_CACHE_RELEASE): $(BUILD_DIRECTORY_RELEASE)
	cd $(BUILD_DIRECTORY_RELEASE) && CC=$(CC) CXX=$(CXX) cmake $(CMAKE_FLAGS_RELEASE) ../..

$(BUILD_DIRECTORY_RELEASE):
	mkdir -p $(BUILD_DIRECTORY_RELEASE)



#
# ... Release with debug information
#
BUILD_DIRECTORY_RELWITHDEBINFO = $(TOPLEVEL_BUILD_DIRECTORY)/RelWithDebInfo
CMAKE_CACHE_RELWITHDEBINFO = $(BUILD_DIRECTORY_RELWITHDEBINFO)/CMakeCache.txt
CMAKE_FLAGS_RELWITHDEBINFO = $(CMAKE_FLAGS_COMMON) -DCMAKE_BUILD_TYPE=RelWithDebInfo
.PHONY: relwithdebinfo
relwithdebinfo: $(CMAKE_CACHE_RELWITHDEBINFO) $(BUILD_DIRECTORY_RELWITHDEBINFO)
	cd $(BUILD_DIRECTORY_RELWITHDEBINFO) && make && make test

$(CMAKE_CACHE_RELWITHDEBINFO_): $(BUILD_DIRECTORY_RELWITHDEBINFO)
	cd $(BUILD_DIRECTORY_RELWITHDEBINFO) && CC=$(CC) CXX=$(CXX) cmake $(CMAKE_FLAGS_RELWITHDEBINFO) ../..

$(BUILD_DIRECTORY_REWITHDEBINFO): 
	mkdir -p $(BUILD_DIRECTORY_RELWITHWITHDEBINFO)




#
# ... Debug
#

.PHONY: debug
BUILD_DIRECTORY_DEEBUG = $(TOPLEVEL_BUILD_DIRECTORY)/Debug
CMAKE_CACHE_DEBUG = $(BUILD_DIRECTORY_DEBUG)/CMakeCache.txt
CMAKE_FLAGS_DEBUG = $(CMAKE_FLAGS_COMMON) -DCMAKE_BUILD_TYPE=Debug

debug: $(CMAKE_CACHE_DEBUG) $(BUILD_DIRECTORY_DEBUG)
	cd $(BUILD_DIRECTORY_DEBUG) && make && make test

$(DEBUG_CMAKE_CACHE): $(BUILD_DIRECTORY_DEBUG)
	cd $(BUILD_DIRECTORY_DEBUG) && CC=$(CC) CXX=$(CXX) cmake $(CMAKE_FLAGS_DEBUG) ../..

$(BUILD_DIRECTORY_DEBUG): 
	mkdir -p $(BUILD_DIRECTORY_DEBUG)












.PHONY: clean_release
clean_release: $(RELEASE_BUILD_DIRECTORY) $(RELEASE_CMAKE_CACHE)
	cd $(RELEASE_BUILD_DIRECTORY) && make clean

.PHONY: clean_relwithdebinfo
clean_relwithdebinfo: $(RELWITHDEBINFO_BUILD_DIRECTORY) $(RELWITHDEBINFO_CMAKE_CACHE)
	cd $(RELWITHDEBINFO_BUILD_DIRECTORY) && make clean

.PHONY: clean_debug
clean_debug: $(DEBUG_BUILD_DIRECTORY) $(DEBUG_CMAKE_CHACHE)
	cd $(DEBUG_BUILD_DIRECTORY) && make clean

.PHONY: distclean
distclean:
	rm -rf $(TOPLEVEL_BUILD_DIRECTORY)
