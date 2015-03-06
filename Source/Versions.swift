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

    var firstLetter: String {
        return self[0]
    }



    func newerThan(version :String) -> Bool {
        return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }

    func olderThan(version: String) -> Bool {
        let isEqual: Bool = self == version
        return !isEqual ? !self.newerThan(version) : false
    }

    func semanticCompare(version: String) -> Semantic {
        return semanticCompareFunc(self, version)
    }
}


//FIX: can't use the same name "semanticCompare" because of Swift bug/limitation
public func semanticCompareFunc(version1: String, version2: String) -> Semantic {

    let versions = (version1, version2)

    switch (versions) {
    case let (v1, v2) where v1 == v2:
        return .Same
    case let (v1, v2) where v1.firstLetter != v2.firstLetter:
        return .Major
    case let (v1, v2) where v1[0...2] != v2[0...2] && v1.olderThan(v2):
        return .Minor
    case let (v1, v2) where v1[0...4] != v2[0...4] && v1.olderThan(v2):
        return .Patch
    default:
        return .Unknown
    }
}

