![Versions logo](https://raw.githubusercontent.com/zenangst/Versions/master/Images/logo_v2.png)

Helping you find inner peace when comparing version numbers in Swift.

Comparing with the current applications version couldn't be easier.

```swift
// App.version is 1.0.0
if App.version.olderThan("2.0.0") {
  // Prompt user to update
}
```

But you can apply this to more things than just the `CFBundleShortVersionString`.

```swift
let currentVersion = "1.0.1a"
if currentVersion.olderThan("1.1.3") {
    // update
}
```

Versions also support semantic versioning (`Major`, `Minor`, `Patch`)

```swift 
if "1.0".semanticCompare("2.0") == Semantic.Major) {
    // major update
}
```

## Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create pull request


## Who's behind?

- Christoffer Winterkvist ([@zenangst](https://twitter.com/zenangst))
- Kostiantyn Koval ([@KostiaKoval](https://twitter.com/KostiaKoval))
