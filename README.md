# WeatherApp
Show the weather info 

## Setup
Requirements: 

- Xcode 11 and later
- Swift 5.1
- iOS 13 and above

## App demo screen for iPhone

<img src="Simulator Screen Shot - iPhone 11 - 2020-11-29 at 16.53.20.png" height="300"> <img src="Simulator Screen Shot - iPhone 11 - 2020-11-29 at 16.53.36.png" height="300">

## App demo screen for iPad
<img src="Simulator Screen Shot - iPad Air (3rd generation) - 2020-11-30 at 11.00.35.png" height="300">

## Run

Open `WeatherApp.xcodeproj` and run Shopping App scheme in a chosen simulator. If you want to run the app on a real device, you need to update code signing configuration first.


## Some implementation details
- There are no external dependencies 🔥
- MVVM design architecture implented ❤️
- The codable protocol is used for json Parsing (like LocationSearch.swift and LocationInfo.swift struct) 😀
- Constants.swift contains all static resource like (APIValue,Cities etc) If you want to add new city then please go to Constants.swift class 🙂
- iPad split view also added for this demo 👌

## TestCase
- Hit command + U for run the test cases 🚀
- Test cases has been added for Network and view model class 🚀
- Model and Controller are also being tested via test case 🚀


## UITestCase
- WeatherAppUITests have testRunApp test to check basic app functionality 🔥
