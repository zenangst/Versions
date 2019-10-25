import Foundation

extension Array {

  func at(index: Int) -> Element? {
    if index >= 0 && index < self.count {
      return self[index]
    }
    return nil
  }
}

public struct Version : Equatable,  Comparable{

  public let major  : Int
  public let minor  : Int
  public let patch  : Int
  public let string : String?

  
  public init?(_ version: String) {
    
    let parts: Array<String> = version.split { $0 == "." }.map { String($0) }
    if let major = parts.at(index: 0), let minor = parts.at(index: 1), let patch = parts.at(index: 2), let majorInt = Int(major), let minorInt = Int(minor), let patchInt = Int(patch) {
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
    return lhs.string!.compare(rhs.string!, options: .numeric) == .orderedAscending
}
