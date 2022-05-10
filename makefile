PROJECT_DIR=${shell cd .; pwd}
BUILD_DIR=${PROJECT_DIR}/build

# ______________________________________________________________________________

.PHONY: all
all:	generate_about_cmake \
		build_about_cmake \
		install_about_cmake \
		run_about_cmake \
		generate_find_package \
		build_find_package \
		run_find_package \
		generate_add_library_imported \
		build_add_library_imported \
		run_add_library_imported

.PHONY: help
help:
	@echo "Targets:"
	@sed -nr 's/^.PHONY:(.*)/\1/p' ${MAKEFILE_LIST}

.PHONY: clean
clean:
	@echo "Cleaning..."
	@rm -rdf ${BUILD_DIR}

# ______________________________________________________________________________
# About CMake

ABOUT_CMAKE_SRC_DIR=${PROJECT_DIR}/about_cmake
ABOUT_CMAKE_BUILD_DIR=${BUILD_DIR}/about_cmake
ABOUT_CMAKE_INSTALL_DIR=${BUILD_DIR}/about_cmake_install

.PHONY: generate_about_cmake
generate_about_cmake:
	@echo "Generating About CMake..."
	@cmake -G Ninja -S ${ABOUT_CMAKE_SRC_DIR} -B ${ABOUT_CMAKE_BUILD_DIR} \
		-DCMAKE_INSTALL_PREFIX=${ABOUT_CMAKE_INSTALL_DIR} \
		-C ${ABOUT_CMAKE_SRC_DIR}/CMakeUtils/CMakeInitialCache.txt

.PHONY: build_about_cmake
build_about_cmake:
	@echo "Building About CMake..."
	@cmake --build ${ABOUT_CMAKE_BUILD_DIR}

.PHONY: install_about_cmake
install_about_cmake:
	@echo "Installing About CMake..."
	@cmake --build ${ABOUT_CMAKE_BUILD_DIR} --target install

.PHONY: run_about_cmake
run_about_cmake:
	@echo "Running About CMake..."
	@${ABOUT_CMAKE_BUILD_DIR}/bin/check_symbol

# ______________________________________________________________________________
# Find Package

FIND_PACKAGE_SRC_DIR=${PROJECT_DIR}/dependencies/find_package
FIND_PACKAGE_BUILD_DIR=${BUILD_DIR}/find_package

generate_find_package:
	@echo "Generating Find Package..."
	@cmake -G Ninja -S ${FIND_PACKAGE_SRC_DIR} -B ${FIND_PACKAGE_BUILD_DIR}_from_install \
		-DCMAKE_PREFIX_PATH=${ABOUT_CMAKE_INSTALL_DIR}

	@cmake -G Ninja -S ${FIND_PACKAGE_SRC_DIR} -B ${FIND_PACKAGE_BUILD_DIR}_from_build \
		-DCMAKE_PREFIX_PATH=${ABOUT_CMAKE_BUILD_DIR}

build_find_package:
	@echo "Building Find Package..."
	@cmake --build ${FIND_PACKAGE_BUILD_DIR}_from_install
	@cmake --build ${FIND_PACKAGE_BUILD_DIR}_from_build

.PHONY: run_find_package
run_find_package:
	@echo "Running Find Package..."
	@${FIND_PACKAGE_BUILD_DIR}_from_install/find_package
	@${FIND_PACKAGE_BUILD_DIR}_from_build/find_package

# ______________________________________________________________________________
# Add Library - Imported

ADD_LIBRARY_IMPORTED_SRC_DIR=${PROJECT_DIR}/dependencies/add_library_imported
ADD_LIBRARY_IMPORTED_BUILD_DIR=${BUILD_DIR}/add_library_imported

generate_add_library_imported:
	@echo "Generating Add Library - Imported..."
	@cmake -G Ninja -S ${ADD_LIBRARY_IMPORTED_SRC_DIR} -B ${ADD_LIBRARY_IMPORTED_BUILD_DIR} \
    	-DSUM_BIN=${ABOUT_CMAKE_INSTALL_DIR}/lib/libsum.a \
    	-DSUM_INCLUDE=${ABOUT_CMAKE_INSTALL_DIR}/include

build_add_library_imported:
	@echo "Building Add Library - Imported..."
	@cmake --build ${ADD_LIBRARY_IMPORTED_BUILD_DIR}

.PHONY: run_add_library_imported
run_add_library_imported:
	@echo "Running Add Library - Imported..."
	${ADD_LIBRARY_IMPORTED_BUILD_DIR}/add_library_imported
