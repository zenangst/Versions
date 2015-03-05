//
//  Versions.swift
//  Versions
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

public enum Semantic: Int {
    case Major, Minor, Patch, Same, Unknown
}

public extension String {

    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }

    func newerThan(version :String) -> Bool {
        return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    func olderThan(version: String) -> Bool {
        let isEqual: Bool = self == version
        return !isEqual ? !self.newerThan(version) : false
    }

    func semanticCompare(version: String) -> Semantic {
        var semanticType = Semantic.Unknown

        if self == version {
            semanticType = Semantic.Same
        } else if self[0] != version[advance(self.startIndex, 0)] {
            semanticType = Semantic.Major
        } else if self[0...2] != version[0...2] && self.olderThan(version) {
            semanticType = Semantic.Minor
        } else if self[0...4] != version[0...4] && self.olderThan(version) {
            semanticType = Semantic.Patch
        }

        return semanticType
    }
    
}
