import Foundation

extension Array {

  func at(_ index: Int) -> Element? {
    if index >= 0 && index < self.count {
      return self[index]
    }
    return nil
  }
}

public struct Version : Equatable, Comparable {

  public let major  : Int
  public let minor  : Int
  public let patch  : Int
  public let string : String?

  
  public init?(_ version: String) {
    
    let parts: Array<String> = version.characters.split { $0 == "." }.map { String($0) }
    if let major = parts.at(0), let minor = parts.at(1), let patch = parts.at(2), let majorInt = Int(major), let minorInt = Int(minor), let patchInt = Int(patch) {
      self.major = majorInt
      self.minor = minorInt
      self.patch = patchInt
      string = version
    } else {
      //Failed to Initialize Version
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
  case let .some(r): return lhs.string == r.string
  case .none: return false
  }
}


//MARK: - Comparable

public func < (lhs: Version, rhs: Version) -> Bool {
  return lhs.string!.compare(rhs.string!, options: NSString.CompareOptions.numeric) == .orderedAscending
}

public func < (lhs: Version?, rhs: Version?) -> Bool {
  guard let rhs = rhs, let lhs = lhs else { return false }
  return lhs.string!.compare(rhs.string!, options: NSString.CompareOptions.numeric) == .orderedAscending
}

public func > (lhs: Version, rhs: Version) -> Bool {
  return lhs.string!.compare(rhs.string!, options: NSString.CompareOptions.numeric) == .orderedDescending
}

public func > (lhs: Version?, rhs: Version?) -> Bool {
  guard let rhs = rhs, let lhs = lhs else { return false }
  return lhs.string!.compare(rhs.string!, options: NSString.CompareOptions.numeric) == .orderedDescending
}
