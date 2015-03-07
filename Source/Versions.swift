//
//  Versions.swift
//  Versions
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

extension Array {

  func at(index: Int) -> T? {
    if index >= 0 && index < self.count {
      return self[index]
    }
    return nil
  }
}

public enum Patch {
  case NumberVersion(Int)
  case StringVersion(String)

  public init?(_ patch: String?) {
    switch patch {
      case let .Some(x): switch x {
        case let num where num.toInt() != nil: self = .NumberVersion(num.toInt()!)
        default: self = .StringVersion(x)
      }
      case .None: return nil
    }
  }

  var number: Int? {
    switch self {
      case let .NumberVersion(x): return x
      default: return nil
    }
  }

  var string: String? {
    switch self {
      case let .StringVersion(s): return s
      default: return nil
    }
  }
}


public struct Version : Equatable {

  let major: Int?
  let minor: Int?
  let patch: Patch?
  let string: String?

  public init(_ version: String) {
    let parts: Array<String> = split(version) { $0 == "." }
    major = parts.at(0)?.toInt()
    minor = parts.at(1)?.toInt()
    patch = Patch(parts.at(2))
    string = version
  }
}

//MARK: - Equatable

public func == (lhs: Version, rhs: Version) -> Bool {
  return lhs.string == rhs.string
}

public func == (lhs: Version, rhs: Version?) -> Bool {
  switch (rhs) {
    case let .Some(r): return lhs.string == r.string
    case .None: return false
  }
}

//MARK: - Versions string functionality

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

    var major: String {
        return self[0]
    }

    var minor: String {
        return self[0...2]
    }

    var patch: String {
        return self[0...4]
    }

    func newerThan(version :String) -> Bool {
        return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }

    func olderThan(version: String) -> Bool {
        let isEqual: Bool = self == version
        return !isEqual ? !self.newerThan(version) : false
    }

    func majorChange(version: String) -> Bool {
        return self.major != version.major
    }
    func minorChange(version: String) -> Bool {
        return self.minor != version.minor && self.olderThan(version)
    }
    func patchChange(version: String) -> Bool {
        return self.patch != version.patch && self.olderThan(version)
    }

    func semanticCompare(version: String) -> Semantic {

        switch self {
        case _ where self == version:
            return .Same
        case _ where self.major != version.major:
            return .Major
        case _ where self.minor != version.minor && self.olderThan(version):
            return .Minor
        case _ where self.patch != version.patch && self.olderThan(version):
            return .Patch
        default:
            return .Unknown
        }
    }
}
