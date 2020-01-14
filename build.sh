# build with bazel 1.2.1 on osx 
bazel build c_from_swift:framework --ios_multi_cpus=armv7,arm64,x86_64
