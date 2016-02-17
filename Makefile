include $(MAKE_ROOT)/settings.mk

PROTOBUF3_BUILD_DIR=build/$(RADIANT_BUILD_PLATFORM)

.PHONY: default
default: configure protobuf3
	echo done

protobuf3: configure
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=release
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=debug

configure:
	-mkdir -p $(PROTOBUF3_BUILD_DIR)/release
	-mkdir -p $(PROTOBUF3_BUILD_DIR)/debug
	$(CMAKE) -G"$(RADIANT_CMAKE_GENERATOR)" -B$(PROTOBUF3_BUILD_DIR)/release -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=install/$(RADIANT_BUILD_PLATFORM)/release -Dprotobuf_BUILD_TESTS=OFF -Hpackage/cmake
	$(CMAKE) -G"$(RADIANT_CMAKE_GENERATOR)" -B$(PROTOBUF3_BUILD_DIR)/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=install/$(RADIANT_BUILD_PLATFORM)/debug -Dprotobuf_BUILD_TESTS=OFF -Hpackage/cmake

.PHONY: clean
clean:
	rm -rf build install
