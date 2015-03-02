//
//  Versions.swift
//  Versions
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

public extension NSString {
    
    func newerThan(version :String) -> Bool {
        return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    func olderThan(version: String) -> Bool {
        return !self.isEqualToString(version) ? !self.newerThan(version) : false
    }
    
}
