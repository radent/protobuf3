include $(MAKE_ROOT)/settings.mk

PROTOBUF3_BUILD_DIR=build/$(RADIANT_BUILD_PLATFORM)

ifeq ($(RADIANT_BUILD_PLATFORM), x86)
MSBUILD_PLATFORM=Win32
else
MSBUILD_PLATFORM=x64
endif

.PHONY: default
default: configure protobuf3
	echo done

configure:
	-mkdir -p $(PROTOBUF3_BUILD_DIR)
	$(CMAKE) -G"$(RADIANT_CMAKE_GENERATOR)" -B$(PROTOBUF3_BUILD_DIR) -DCMAKE_INSTALL_PREFIX=install/$(RADIANT_BUILD_PLATFORM)/release -Dprotobuf_BUILD_TESTS=OFF -Hpackage/cmake

.PHONY: clean
clean:
	rm -rf build install

# macOS
ifeq ($(RADIANT_OS_PLATFORM), macos)

protobuf3: configure
	cmake --build $(PROTOBUF3_BUILD_DIR) --config RelWithDebInfo --target install

# Windows
else

protobuf3: configure
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=release,platform=$(MSBUILD_PLATFORM)
	$(MSBUILD) $(PROTOBUF3_BUILD_DIR)/protobuf.sln -p:configuration=debug,platform=$(MSBUILD_PLATFORM)

endif
