load("@build_bazel_rules_swift//swift:swift.bzl", "swift_binary", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_framework", "ios_static_framework")

licenses(["notice"])

# 1. This library has some C++ code that you want to interact with from Swift...
cc_library(
    name = "counter",
    srcs = ["counter.cc"],
    hdrs = ["counter.h"],
)

# 2. ...but Swift can't import C++ yet, so we implement a wrapper API in C.
cc_library(
    name = "c_counter",
    srcs = ["c_counter.cc"],
    hdrs = ["c_counter.h"],
    tags = ["swift_module=CCounter"],
    deps = [":counter"],
)

# 3. The Swift library then depends on the `cc_library`. This causes a
# Swift-compatible module map to be created for the `cc_library` so that the
# Swift code can import it.
swift_library(
    name = "swift_counter",
    srcs = ["Counter.swift"],
    module_name = "Counter",
    deps = [":c_counter"],
)

# 4. Finally, this binary is a straightforward target with no surprises. It just
# imports the Swift `Counter` module above.
swift_binary(
    name = "c_from_swift",
    srcs = ["main.swift"],
    module_name = "main",
    deps = [":swift_counter"],
)

objc_library(
    name = "CCounter",
    hdrs = ["c_counter.h"],
    module_name = "CCounter",
    deps = [
        ":c_counter",
    ],
)

ios_static_framework(
    name = "framework",
    hdrs = ["c_counter.h"],
    bundle_name = "CounterLib",

    #        families = [
    #                "iphone",
    #                "ipad",
    #        ],
    minimum_os_version = "11.0",
    deps = [
        ":CCounter",
    ],
)

"""

load("//sdk/lib:swift_static_framework.bzl", "swift_static_framework")

swift_static_framework(
    name = "framework",
    srcs = [
        "Counter.swift",
    ],
    hdrs = [
        "c_counter.h",
    ],
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "11.0",
    module_name = "CounterLib",
    deps = [
        ":c_counter",
        #":CCounter",
    ],
)
"""
