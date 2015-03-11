//
//  StaticVersion.swift
//  Versions
//
//  Created by Konstantin Koval on 11/03/15.
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

public enum Metadata {
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

public struct Version : Equatable,  Comparable{

  let major: Int
  let minor: Int
  let patch: Int
  let metadata: Metadata?

  let string: String?

  public init?(_ version: String) {
    let parts: Array<String> = split(version) { $0 == "." }

    let major = parts.at(0)?.toInt()
    let minor = parts.at(1)?.toInt()
    let patch = parts.at(2)?.toInt()

    if let major = major, minor = minor, patch = patch {
      self.major = major
      self.minor = minor
      self.patch = patch
      string = version
      metadata = nil
    } else {
      //Failable Initializers
      return nil
    }
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

//MARK: - Comparable

public func < (lhs: Version, rhs: Version) -> Bool {
  return lhs.string!.compare(rhs.string!, options: NSStringCompareOptions.NumericSearch) == .OrderedAscending
}


