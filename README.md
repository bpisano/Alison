# Alison

[![CI Status](https://img.shields.io/travis/bpisano/Alison.svg?style=flat)](https://travis-ci.org/bpisano/Alison)
[![Version](https://img.shields.io/cocoapods/v/Alison.svg?style=flat)](https://cocoapods.org/pods/Alison)
[![License](https://img.shields.io/cocoapods/l/Alison.svg?style=flat)](https://cocoapods.org/pods/Alison)
[![Platform](https://img.shields.io/cocoapods/p/Alison.svg?style=flat)](https://cocoapods.org/pods/Alison)

![Alison gif](Example/Images/alison.gif)

## Get Started

Alison is a cool and easy to use animation for your bot. You can use an `ALView` to create an animation in your app :

```swift
let animationView = ALView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
```

Alison have two animation states. The **normal** state is by default slow and green. The **thinking** state represent a bot activity to show to your users that something is happening. The **normal** state is the state by default when loading the view.

To change states, you can use :

```swift
animationView.setNormalState()
animationView.setThinkingState()
```

## Customization

Alison is fully customizable. You can change various parameters to adapt it to your app. Here is an example of full customization :

```swift
let animationView = ALView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

animationView.rayCount = 5
animationView.rayLength = 6
animationView.rayRadius = 5
animationView.raySpeed = 6

animationView.normalPrimaryColor = UIColor.red
animationView.normalSecondaryColor = UIColor.cyan

animationView.thinkingPrimaryColor = UIColor.blue
animationView.thinkingSecondaryColor = UIColor.green
```

## Installation

Alison is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Alison'
```

Then run `pod install`.

## Requirements

Alison require **iOS 11.0** and **Swift 5**.

## Author

Alison is made by me, Benjamin Pisano. If you want to talk with me, you can contact me on Twitter [@benjamin_pisano](https://twitter.com/benjamin_pisano).

## License

Alison is available under the MIT license. See the LICENSE file for more info.
