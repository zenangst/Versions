import Foundation

//MARK: - Versions string functionality

public enum Semantic {
  case major, minor, patch, same, unknown
}

public struct App {
  
  public static var version: String = {
    var version: String = ""
    if let infoDictionary = Bundle.main.infoDictionary {
      version = infoDictionary["CFBundleShortVersionString"] as! String
    }
    return version
  }()
}


public extension String {
  
  subscript (i: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: i)]
  }
  
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  
  subscript (r: Range<Int>) -> String {
    return String(self[self.index(startIndex, offsetBy: r.startIndex)..<self.index(startIndex, offsetBy: r.endIndex)])
  }
  
  
  var major: String {
    return self[0]
  }
  
  
  var minor: String {
    return String(self[self.index(self.startIndex, offsetBy: 0)...self.index(self.startIndex, offsetBy: 2)])
  }
  
  
  var patch: String {
    return String(self[self.index(self.startIndex, offsetBy: 0)...self.index(self.startIndex, offsetBy: 4)])
  }
  
  
  func newerThan(version :String) -> Bool {
    return self.compare(version, options: .numeric) == .orderedDescending
  }
  
  
  func olderThan(version: String) -> Bool {
    let isEqual: Bool = self == version
    return !isEqual ? !self.newerThan(version: version) : false
  }
  
  
  func majorChange(version: String) -> Bool {
    return self.major != version.major
  }
  
  
  func minorChange(version: String) -> Bool {
    return self.minor != version.minor && self.olderThan(version: version)
  }
  
  
  func patchChange(version: String) -> Bool {
    return self.patch != version.patch && self.olderThan(version: version)
  }
  
  
  func semanticCompare(version: String) -> Semantic {
    switch self {
    case _ where self == version:
      return .same
    case _ where self.major != version.major:
      return .major
    case _ where self.minor != version.minor && self.olderThan(version: version):
      return .minor
    case _ where self.patch != version.patch && self.olderThan(version: version):
      return .patch
    default:
      return .unknown
    }
  }
}
