//
//  Log.swift
//

import Foundation
import SLLog

public class AppLog {

    public class func setup() {
        let path = URL.documents
        SLLog.addHandler(SLLogConsole())
    }

    public class func v(_ message: @autoclosure () -> Any, _ file: String = #file, _ line: UInt = #line) {
        Log.v(message(), file, line)
    }

    public class func i(_ message: @autoclosure () -> Any, _ file: String = #file, _ line: UInt = #line) {
        Log.i(message(), file, line)
    }

    public class func d(_ message: @autoclosure () -> Any, _ file: String = #file, _ line: UInt = #line) {
        Log.d(message(), file, line)
    }

    public class func w(_ message: @autoclosure () -> Any, _ file: String = #file, _ line: UInt = #line) {
        Log.w(message(), file, line)
    }

    public class func e(_ message: @autoclosure () -> Any, _ file: String = #file, _ line: UInt = #line) {
        Log.e(message(), file, line)
    }

}
