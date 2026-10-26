# Samsung S96901AA1 kernel

Repo manifest for the Samsung Galaxy A14 5G (SM-A146P,
`a14xm`) Android 15 kernel. The manifest branch and board
configuration are `S96901AA1`; the SoC is MediaTek MT6833.

The Samsung BSP package separates three components:

- `kernel-6.6`: Samsung/MediaTek common kernel, based on Android 15 / 6.6
- `kernel_device_modules-6.6`: device drivers, device trees and board configs
- `vendor/mediatek/kernel_modules`: out-of-tree MediaTek vendor modules

The checkout root is the Bazel workspace. Patched Kleaf lives in `build/kernel`,
and MTK integration rules live in `build/bazel_mgk_rules`.

```text
checkout/
├── build_kernel.sh
├── WORKSPACE -> build/bazel_mgk_rules/kleaf/bazel.WORKSPACE
├── kernel-6.6/
├── kernel_device_modules-6.6/
├── vendor/mediatek/kernel_modules/
├── build/{kernel,bazel_mgk_rules,bazel_common_rules,configs}/
├── configs/
├── tests/
├── external/
├── prebuilts/
└── tools/
```

The manifest retains links for build entry points such as `WORKSPACE` and
`tools/bazel`; their targets stay inside the workspace. Relative directory links
to source trees outside the workspace can break when Bazel remaps source paths
inside its sandbox.

## Sync and build

Use a new checkout directory when migrating from the previous nested `kernel/`
workspace. Preserve local commits and uncommitted changes in the old checkout
until the new checkout has been verified.

```bash
repo init -u git@github.com:samsung-mediatek/android_kernel_manifest.git -b S96901AA1
repo sync -c -j4
./build_kernel.sh
```

The wrapper generates the configuration for project `mgk_64_k66` in `user` mode,
using `mediatek-bazel_defconfig` plus `mt6833_overlay.config`,
`S96901AA1.config` and `S96901AA1_debug.config`. It then calls the supplied MTK
build script: build common kernel, build device/vendor modules, install modules,
and collect artifacts.

Outputs: `out/target/product/a14xm/obj/KLEAF_OBJ/dist/`

