# NibLoaderKit 

[![Build Status](https://travis-ci.org/giginet/NibLoaderKit.svg?branch=master)](https://travis-ci.org/giginet/NibLoaderKit) 
[![codecov](https://codecov.io/gh/giginet/NibLoaderKit/branch/master/graph/badge.svg)](https://codecov.io/gh/giginet/NibLoaderKit)
[![Language](https://img.shields.io/badge/language-Swift%203-orange.svg)](https://swift.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/NibLoaderKit.svg)](http://cocoadocs.org/docsets/NibLoaderKit)
[![Platform](https://img.shields.io/cocoapods/p/NibLoaderKit.svg?style=flat)](http://cocoadocs.org/docsets/NibLoaderKit)
[![License](https://cocoapod-badges.herokuapp.com/l/NibLoaderKit/badge.svg)](https://github.com/giginet/NibLoaderKit/blob/master/LICENSE.md)

This is a tiny utility to load UIView/NSView from nibs.

# Usage

## 1. Declare CustomView class

```swift
class CustomView: UIView { }
```

## 2. Place `CustomView.xib`

- `xib` must contains just one top level view.

## 3. Set custom class

- Set custom class of the top level view to `CustomView`.

![](https://raw.githubusercontent.com/giginet/NibLoaderKit/master/Documentation/Images/custom_view.png)

## 4. Load from the code

```swift
let customView: CustomView = try! CustomView.view(withOwner: self)
```

`CustomView.xib` will be loaded and generate the view.

Nib names are guessed automatically by class name. they would be demodulized.

You can also pass the nibName and bundle.

```swift
let customView: UIView = try! UIView.view(
    from: "MyCustomView", 
    owner: self, 
    bundle: Bundle(forClass: self.dynamicType)
)
```

# Installation

## Carthage

```
github "giginet/NibLoaderKit"
```

## CocoaPods

```ruby
use_frameworks!

pod 'NibLoaderKit'
```

# Requirements

- >= iOS 8
- >= macOS 10.10
- >= tvOS 9
- Swift 3.0
- Xcode 8.x

## LICENSE

MIT License
