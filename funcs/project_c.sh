#!/bin/sh

c_project_clean() {
	(project-env-valid) || return 1
	rm -rf *.o *.so *.dylib *.out || return 1
	rm -rf .clean || return 1
	c_clean_cmake || return 1
}

c_clean_cmake() {
	(project-env-valid) || return 1
	rm -rf build || return 1
}

c_build_cmake() {
	(project-env-valid) || return 1
	cmake \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
		-DCMAKE_INSTALL_PREFIX="$WORKSPACE"/usr \
		-DCMAKE_BUILD_TYPE=Debug \
		-S . \
		-B ./build \
		-G Ninja
	ninja -C ./build
	ninja -C ./build install
}

c_project_run() {
	(project-env-valid) || return 1
}

c_deploy() {
	(project-env-valid) || return 1
}

c_tools_gen() {
	(project-env-valid) || return 1
}
