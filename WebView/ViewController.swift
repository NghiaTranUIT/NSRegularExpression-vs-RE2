//
//  ViewController.swift
//  WebView
//
//  Created by Nghia Tran on 7/11/20.
//  Copyright © 2020 Nghia Tran. All rights reserved.
//

import Cocoa
import WebKit

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

class ViewController: NSViewController {

    struct TestCase {
        let name: String
        let regex: String
    }

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load File
        let url = Bundle.main.url(forResource: "howto", withExtension: "txt")!
        let content = try! String(contentsOf: url)

        // Init Testcase
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
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

@discardableResult
func measure<A>(name: String = "", _ block: () -> A) -> A {
    let startTime = CACurrentMediaTime()
    let result = block()
    let timeElapsed = CACurrentMediaTime() - startTime
    print("Time: \(name) : \(timeElapsed)")
    return result
}
