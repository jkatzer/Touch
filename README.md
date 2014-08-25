# Touch
## Automatic UIEvent Analytics/Tracking Library for iOS


It's hard to tell what events are going to be important for your comapny/product/game analytics. So we track all the events caused by the user, and store them for later filtering.

Also, its time consuming to implement all sorts of event tracking to keep your product manager and the business guys happy. Use this, with whatever analytics tool your team is using and look like a superstar/rockstar/ninja/any other outdated HR talk for an average developer.

### Automatically Tracked Events


#####Touches
```
touchesBegan:withEvent:
```

This includes all touches of any UIView subclass including buttons.


#####Gestures
```
UIGestureRecognizer
UITapGestureRecognizer
UIPinchGestureRecognizer
UIRotationGestureRecognizer
UISwipeGestureRecognizer
UIPanGestureRecognizer
UIScreenEdgePanGestureRecognizer
UILongPressGestureRecognizer
```

Anytime you add a gesture recognizer, we will track it



### Automatically Tracked Contexts

#####View Controllers

Anytime you spawn a new UIViewController or subclass, we track that, so your events have context

#####Text and Labels

We send along with events the text if the object responds to the correct selector, and any accessabilty info about the item.




### Usage

#### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Touch in your projects.

##### Podfile

Add the following line to your Podfile, or make a Podfile with just this entry.


```
pod "Touch"
```
If you are new to using Cocoapods, you'll want to commit your Podfile to your project repository, and ignore the Pods directory, and Podfile.lock file.

####Then run

```
    pod install
```


#### AppDelegate (example using Keen.io)

```
...
 #import "Touch.h"
...


  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      ...
      
      [Touch setupBackend:@"Keen" withId:@"YOURPROJECTID" andToken:@"YOURWRITEKEY"];
      [Touch start];
	   ...

      return TRUE;
  }

```

You can also just put those values in your plist and skip the configuration line

```
EXAMPLE(S) FOR THAT
```


### Advanced Features

##### Multiple Backends
Set up multiple backends
```
Example(s)
```
and we'll take care of the rest


##### Upload Interval

Set the time delay for updating info

```
    [Touch setInterval:30];
```

##### Verbose Mode

When you turn on verbose mode, we'll print out the information we would normally be sending to the server.

```
    [Touch setVerbose:TRUE];
```

##### Other events

Simple Event

```
    [Touch addEvent:@{@"key":@"object"}];
```


Advanced Event

```
    [Touch addEvent:@{@"key":@"object"} toCollection:@"collectionName" error:nil];
```



### What do the events look like?


Use verbose mode and find out!


### Contributing

* Feedback
  * Is this cool?
  * Will you use this? / (Why not?)
  * What is it missing? (other than tests)
* Tests
* Abstraction Class for your favorite/least favorite analytics backend


##### Future Versions

* Optional Event Tracking
* Extendable Format for Tracking other Events

