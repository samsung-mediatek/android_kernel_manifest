#!/usr/bin/env bash
set -e

export DEVICE_MODULES_DIR=kernel_device_modules-6.6
export PROJECT=mgk_64_k66
export MODE="${MODE:-user}"
export DEFCONFIG_OVERLAYS='mt6833_overlay.config S96901AA1.config S96901AA1_debug.config'
export BUILD_CONFIG=out/target/product/a14xm/obj/KERNEL_OBJ/build.config
export OUT_DIR=out/target/product/a14xm/obj/KLEAF_OBJ
export DIST_DIR="${OUT_DIR}/dist"

python3 "${DEVICE_MODULES_DIR}/scripts/gen_build_config.py" \
    --kernel-defconfig mediatek-bazel_defconfig \
    --kernel-defconfig-overlays "${DEFCONFIG_OVERLAYS}" \
    --kernel-build-config-overlays '' \
    -m "${MODE}" -o "${BUILD_CONFIG}"

exec bash "${DEVICE_MODULES_DIR}/build.sh"
