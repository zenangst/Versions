//
//  Versions.swift
//  Versions
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

public enum Semantic {
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
        switch version {
        case let version where self == version:
            return .Same
        case let version where self[0] != version[self.startIndex]:
            return .Major
        case let version where self[0...2] != version[0...2] && self.olderThan(version):
            return .Minor
        case let version where self[0...4] != version[0...4] && self.olderThan(version):
            return .Patch
        default:
            return .Unknown
        }
    }

}
