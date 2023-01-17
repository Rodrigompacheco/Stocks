# Stocks
This study-related application queries all assets available on Yahoo Finance. The api service is encapsulated and used through a SPM (Swift Package Manager). Finally, the app has a layout mixed with UIKit and SwiftUI.

## Screenshots
![alt text](https://github.com/Rodrigompacheco/Stocks/blob/main/Screenshots/1.png "Search Stock") ![alt text](https://github.com/Rodrigompacheco/Stocks/blob/main/Screenshots/2.png "Stock Details") ![alt text](https://github.com/Rodrigompacheco/Stocks/blob/main/Screenshots/3.png "Stock Price")

## Requirements

* Xcode 11
* Swift 5

## Architecture

This app is using `MVP` with  `Coordinators`.

## Features

* **No Storyboard:** Views was developed part using View Code and part using SwiftUI.

## Third-party libraries
I'm using Swift Package Manager, which lets you manage your project dependencies, allowing you to import libraries into your applications with ease.

#### - SPM 'SnapKit'
SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.

#### - SPM 'XCAStocksAPI'
Framework that I mentioned before that provides the services to make the requests to the Yahoo Finance API. 
  
## How to install

* No mysteries here, just download the project and run! =)

## Next Steps  
- [ ] Implement a cache logic to not make the same recent request.
- [ ] Logic to update the Stocks prices in real time.
- [ ] Unit Tests.
- [ ] Add SwiftLint to enforce code style and conventions.
