import Foundation


/**
 Preferred logging method. Will be ignored in release builds

 - parameter message:  Log message
 - parameter file:     Should not be used
 - parameter function: Should not be used
 - parameter line:     Should not be used
 */
public func WALOG( _ message: String, file: String = #file, function: String = #function, line: Int = #line ) {
    //print("([\((file as NSString).lastPathComponent) \(function)] line: \(line)) ", message)
}
