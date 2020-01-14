# bazel_static_framework_issue
This example attempts to extend the [example rules_swift]( https://github.com/bazelbuild/rules_swift/tree/master/examples/xplatform/c_from_swift) for wrapping c++ in swift. 
It builds a static framework using the ios_static_framework rule. 
This static framework may be imported into an xcode application, but the C namespace CCounter is not found.

example usage code in something like AppDelegate.swift would be as follows:

```
import CounterLib // here the error shows up as: Missing required module 'CCounter'

// then later...
let counter = Counter()
for _ in 1...10 {
        counter.increment()
}
```
