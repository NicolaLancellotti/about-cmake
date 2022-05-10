BUILD = ./build
FIND_PACKAGE_SRC_DIR = ./find-package

all:	generate_ac \
		install_ac \
		generate_find_package \
		build_find_package \
		generate_ac_initial_cache

clean:
	@rm -rdf $(BUILD)

generate_ac:
	@cmake --preset=default

install_ac:
	@cmake --build --preset=install

generate_find_package:
	@cmake -S $(FIND_PACKAGE_SRC_DIR) --preset=from-install
	@cmake -S $(FIND_PACKAGE_SRC_DIR) --preset=from-build

build_find_package:
	@cd $(FIND_PACKAGE_SRC_DIR) && cmake --build --preset=from-install
	@cd $(FIND_PACKAGE_SRC_DIR) && cmake --build --preset=from-build

generate_ac_initial_cache:
	@cmake -S . -B $(BUILD)/ac-initial-cache -C CMakeInitialCache.txt
