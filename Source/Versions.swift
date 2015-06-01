import Foundation

//MARK: - Versions string functionality

public enum Semantic {
  case Major, Minor, Patch, Same, Unknown
}

struct App {

  static var version: String = {
    var version: String = ""
    if let infoDictionary = NSBundle.mainBundle().infoDictionary {
      version = infoDictionary["CFBundleShortVersionString"] as! String
    }

    return version
    }()

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
