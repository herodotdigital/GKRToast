# GKRToast
iOS replay for Android Toast messages made with easy customization in mind.

## How to use 

For default style toast just write:

```objective-c
[GKRToast show:@"Your text"];
```

For other style use one of two classes `AIMToast` or `AIMFancyToast` or create custom subclass

## Available classes and styles

**GKRToast** - base class with Android look'n'feel
<br>
<img src="https://github.com/AllinMobile/GKRToast/raw/master/Assets/GKRToast.gif" width="320">

**AIMToast** - class that we are using at All in Mobile, background and text color can be easly customized 
<br>
<img src="https://raw.githubusercontent.com/AllinMobile/GKRToast/master/Assets/AIMToast.gif" width="320">

**AIMFancyToast** - example how to create more complicated animations
<br>
<img src="https://raw.githubusercontent.com/AllinMobile/GKRToast/master/Assets/AIMFancyToast.gif" width="320">

## Custom subclass
If you want make a toast with custom layout and animation, you should create a subclass of `GKRToast`, override `+ (GKRToastConfigure *)configure` method and return new configuration for toast. For example if you want to create a toast, that shows from left-hand side, you should write something like that:

```objective-c

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *configure = [GKRToastConfigure new];
    
    CGFloat offset = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5f + 100;
    
    configure.animateShowLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        centerX.offset = -offset;
        [textContainer layoutIfNeeded];
        centerX.offset = 0;
        [UIView animateWithDuration:1.0f animations:^{
            [textContainer layoutIfNeeded];
        }];
    };
    return configure;
};

```

## GKRToastConfigure properties 
The `GKRToastConfigure` object has the following properties:

Property | Type | Description | Default value
-------- | ---- | ----------- | --------------
backgroundView | UIView * | background displayed full screen | back color with 30% alpha
textContainer | UIView * | container for text message | back color with 80% alpha
textLabel | UILabel * | label that display message text | whte text color, number of line set to 0
textEdgeInsets | UIEdgeInsets | margin for `textLabel` | left, right, top and bottom set to 10 pt
hideTimeOut | NSTimeInterval |displaying time (in secounds); if set to 0, never hides autmaticly | 5s
animateShowLabel | void(^)(`UIView *textContainer`, `UILabel *textLabel`, `MASConstraint *centerX`, `MASConstraint *centerY`) | block call after `textContainer` is add to current window; `centerX` and `centerY` are constrains that center toast on screen | alpha transition from 0 to 1 in 0.5 s
animateShowBackground | void(^)(`UIView *backgroundView`) | block call after `backgroundView` is add to current window | alpha transition from 0 to 1 in 0.5 s
animateHideLabel | void(^)(`UIView *textContainer`, `UILabel *textLabel`, `MASConstraint *centerX`, `MASConstraint *centerY`) | block call when `textContainer` should be remove from current window; remember to call `[textLabel removeFromSuperview]` and `[textContainer removeFromSuperview]` after animation is ended | alpha transition from 1 to 0 in 0.5 s
animateHideBackground | void(^)(`UIView *backgroundView`) | block call when `backgroundView` should be remove from current window; remember to call `[backgroundView removeFromSuperview]` after animation is ended | alpha transition from 1 to 0 in 0.5 s

## Check the full video on Youtube

[![Check the full video](http://img.youtube.com/vi/QUvb8lZWkhg/0.jpg)](https://www.youtube.com/watch?v=QUvb8lZWkhg)

or [try it by yourself](https://appetize.io/embed/jt4r91ch6tmnpepgyexcuf3v94?device=iphone5s&scale=100&autoplay=false&orientation=portrait&deviceColor=black)
