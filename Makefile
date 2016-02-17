include $(MAKE_ROOT)/settings.mk

PROTOBUF3_BUILD_DIR=build/$(RADIANT_BUILD_PLATFORM)

ifeq ($(RADIANT_BUILD_PLATFORM),x86) 
PROTOBUF3_MSBUILD_CONFIGURATION="|Win32"
else
PROTOBUF3_MSBUILD_CONFIGURATION=
endif

.PHONY: default
default: configure protobuf3
	echo done

protobuf3: configure
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=Release
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=debug$(PROTOBUF3_MSBUILD_CONFIGURATION)

configure:
	-mkdir -p $(PROTOBUF3_BUILD_DIR)
	$(CMAKE) -G"$(RADIANT_CMAKE_GENERATOR)" -B$(PROTOBUF3_BUILD_DIR) -DCMAKE_INSTALL_PREFIX=install/$(RADIANT_BUILD_PLATFORM)/release -Dprotobuf_BUILD_TESTS=OFF -Hpackage/cmake

.PHONY: clean
clean:
	rm -rf build install
