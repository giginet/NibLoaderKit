# NibLoader

This is a micro utility to create UIView/NSView from nib files.

# Usage

## 1. Declare CustomView class

```swift
class CustomView: UIView { }
```

## 2. Place `CustomView.xib`

- `xib` must contains just one top level view.

## 3. Set custom class

- Set custom class of the top level view to `CustomView`.

![](https://raw.githubusercontent.com/giginet/NibLoader/master/Documentation/Images/custom_view.png)

## 4. Load from code

```swift
let customView: CustomView = CustomView.view(withOwner: self)
```

`CustomView.xib` will be loaded and generated the view.

You can also pass the nibName and bundle.

```swift
let customView: CustomView = UIView.view(
    fromNibNamed: "MyCustomView", 
    owner: self, 
    bundle: NSBundle(forClass: self.dynamicType)
)
```

## Requirements

- >= iOS 8
- >= macOS 10.10
- >= tvOS 9
- Swift 2.2

## LICENSE

MIT License
