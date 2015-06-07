import Foundation

//MARK: - Versions string functionality

public enum Semantic {
  case Major, Minor, Patch, Same, Unknown
}

public struct App {

  public static var version: String = {
    var version: String = ""
    if let infoDictionary = NSBundle.mainBundle().infoDictionary {
      version = infoDictionary["CFBundleShortVersionString"] as! String
    }
    return version
  }()
}


public extension String {

  public subscript (i: Int) -> Character {
    return self[advance(self.startIndex, i)]
  }

  
  public subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  

  public subscript (r: Range<Int>) -> String {
    return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
  }
  

  public var major: String {
    return self[0]
  }

  
  public var minor: String {
    return self[0...2]
  }
  

  public var patch: String {
    return self[0...4]
  }
  

  public func newerThan(version :String) -> Bool {
    return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
  }
  

  public func olderThan(version: String) -> Bool {
    let isEqual: Bool = self == version
    return !isEqual ? !self.newerThan(version) : false
  }
  

  public func majorChange(version: String) -> Bool {
    return self.major != version.major
  }
  
  
  public func minorChange(version: String) -> Bool {
    return self.minor != version.minor && self.olderThan(version)
  }
  
  
  public func patchChange(version: String) -> Bool {
    return self.patch != version.patch && self.olderThan(version)
  }
  

  public func semanticCompare(version: String) -> Semantic {
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
