# BPFormatted

This is a back-port of the `.formatted` API in Foundation that was introduced at WWDC '21 for iOS 15, macOS 12.0, tvOS 15.0, and watchOS 8.0.

Most developers cannot start developing their apps from those platforms and upwards.

But now they can! This package provides the same nice api for projects starting at **iOS 9.0, macOS 10.10, tvOS 9.0 and watchOS 2.0**!!!

## Goal

To provide the exact same api with the exact same results as Apple's Foundation api.

## Features

What's already available and what's to come.

- [x] Date
- [x] ISO8601
- [x] DateInterval
- [ ] DateComponents
- [ ] List
- [ ] Measurement
- [ ] PersonNameComponent
- [ ] RelativeDate
- [ ] ByteCount
- [ ] String parsing (maybe)

## How to use

The same API as in Apple's Foundation framework, but prefixed with `bp`.

```swift
// Apple's Foundation
Date().formatted()
Date().formatted(.dateTime.month().year(.twoDigits))
(Date()..<Date()).formatted(.interval.year())
// BPFormatted
Date().bpFormatted()
Date().bpFormatted(.dateTime.month().year(.twoDigits))
(Date()..<Date()).bpFormatted(.interval.year())
```

You will get automatic compiler warnings if you try to use this framework when your minimum deployment already allows you to use Apple's official API.

All possibilities are not yet fully documented by Apple. Your best bet right now is to watch [What's new in Foundation (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10109/) starting at 14:30.

## Warning

* Since the current release of Foundation this is based on is still in bèta, everything is still subject to change.
* The unit tests contains code that needs the new base SDK's, so these tests will not compile in Xcode 12 or lower. The package itself should be fine.
* To use the same syntax as the new API, you need to use Swift 5.5, otherwise, a longer form will be necessary.
```
// Swift 5.5
Date().bpFormatted(.dateTime)
// Swift 5.x
Date().bpFormatted(Date.BPFormatStyle.dateTime)
```
* This is my first open source project. If you have any suggestions/improvements, I am open-minded.

## Installation
SPM:

```swift
dependencies: [
    .package(url: "https://github.com/simonsalomons/BPFormatted.git", .upToNextMajor(from: "0.0.1"))
]
```

CocoaPods:

TBA
