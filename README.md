# Stocks
This study-related application queries all assets available on Yahoo Finance. The api service is encapsulated and used through a SPM (Swift Package Manager). Finally, the app has a layout mixed with UIKit and SwiftUI.

## Screenshots
![alt text](https://github.com/Rodrigompacheco/BestSwiftRepos/blob/master/Screenshots/1.png "List of Repositories") ![alt text](https://github.com/Rodrigompacheco/BestSwiftRepos/blob/master/Screenshots/2.png "Paged Request")

## Requirements

* Xcode 11.1
* Swift 5

## Architecture

This app is using `MVP` with  `Coordinators`.

## Features

* **No Storyboard:** Views was developed using View Code.
* **Unit Tests:** Tests developed with Quick and Nimble - code coverage: ~41,7%

## Third-party libraries
I'm using CocoaPods, that is a dependency manager for Swift and Objective-C Cocoa projects

#### - pod 'Kingfisher'
Used to download and cache images.

#### - pod 'SnapKit'
SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.

#### - pods 'Quick and Nimble'
Quick Is a behavior-driven development framework for Swift and Objective-C. Quick comes together with Nimble — a matcher framework for your tests. 
  
## How to install

* Clone or download the project to your machine.
* Using the terminal, go to the project folder where there is the Podfile and execute the command bellow.
``` sh
pod install
```

## Next Steps  
- [ ] Add Slather to generate test coverage reports for Xcode projects & hook it into CI.
- [ ] Add EarlGrey - native iOS UI automation test framework that enables you to write clear, concise tests
- [ ] Add Circle CI to automate the development process. 
- [ ] Add iOSSnapshotTestCase to avoid regression.
- [ ] Add SwiftLint to enforce code style and conventions.
