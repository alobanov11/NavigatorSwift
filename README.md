# NavigatorSwift

NavigatorSwift is a lightweight library which allows you not to be crazy with navigation in UIKit, but stay flexible.



## How to use

Define an object which conform `NavigationRootProvider` protocol or use standart `BaseNavigatorRootProvider(container:)`. The container must conform `NavigatorRootContainer` protocol and by default UIWindow already conform it. Instantiate `Navigator(rootProvider:)`. If you want to go forward use `Presentable` protocol, by default `UIViewController` conform the protocol.

```swift

let rootProvider = BaseNavigatorRootProvider(container: window)
let navigator = Navigator(rootProvider: rootProvider)

navigator.navigate(to: .present(SomeViewController()), animated: true, completion: { print("Done") })
navigator.navigate(to: .present(SomeScreen(id:)))

```

Also you can make a chain:

```swift

navigator.navigate(with: [
	.setRoot(TabsScreen()),
	.setTab(TabsScreen.TabItem.profile.rawValue),
	.push(WalletScreen()),
	.present(Transaction(id:)),
])

navigator.navigate(with: [
	.dismissOnRoot,
	.setTab(0),
	.popToRoot,
])

```


## Requirements

ReactSwift supports **iOS 9 and up**, and can be compiled with **Swift 4.2 and up**.



## Installation

### Swift Package Manager

The ReactSwift package URL is:

```
`https://github.com/alobanov11/NavigatorSwift`
```



## License

NavigatorSwift is licensed under the [Apache-2.0 Open Source license](http://choosealicense.com/licenses/apache-2.0/).

You are free to do with it as you please.  We _do_ welcome attribution, and would love to hear from you if you are using it in a project!
