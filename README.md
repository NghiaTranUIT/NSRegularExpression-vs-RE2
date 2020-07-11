# NSRegularExpression-vs-RE2
Tiny Performance benchmark for [NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression) and [google/re2](https://github.com/google/re2)

## Testcase
- A large files [UTF8 File](https://github.com/NghiaTranUIT/NSRegularExpression-vs-RE2/blob/master/WebView/howto.txt) (~40Mb)
- Run 5 times on Release Mode and get the average result

```swift
        let tests = [TestCase(name: "URI", regex: "([a-zA-Z][a-zA-Z0-9]*)://([^ /]+)(/[^ ]*)?"),
                     TestCase(name: "Email", regex: "([^ @]+)@([^ @]+)"),
                     TestCase(name: "Date", regex: "([0-9][0-9]?)/([0-9][0-9]?)/([0-9][0-9]([0-9][0-9])?)"),
                     TestCase(name: "URI|Email", regex: "([a-zA-Z][a-zA-Z0-9]*)://([^ /]+)(/[^ ]*)?|([^ @]+)@([^ @]+)")]

        tests.forEach { test in

            measure(name: "RE2") {
                let _ = RegexUtils.regex(withText: content, pattern: test.regex)
            }

            measure(name: "NSRegularExpression") {
                let regex = NSRegularExpression(test.regex)
                let _ = regex.matches(content)
            }
        }
```

## Result
```
Time: RE2 URI : 0.11845834599989757
Time: NSRegularExpression URI : 0.003419409999878553
-------------------
Time: RE2 Email : 0.13101682099932077
Time: NSRegularExpression Email : 7.166600062191719e-05
-------------------
Time: RE2 Date : 0.12773934000051668
Time: NSRegularExpression Date : 0.0019232759996157256
-------------------
Time: RE2 URI|Email : 0.13327939200007677
Time: NSRegularExpression URI|Email : 7.956900026329095e-05
-------------------

```

# Credit
- http://lh3lh3.users.sourceforge.net/reb.shtml
