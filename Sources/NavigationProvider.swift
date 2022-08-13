//
//  Created by Антон Лобанов on 08.04.2022.
//

import UIKit

public protocol NavigationProvider {
	var topMostViewController: UIViewController? { get }
	var topPresentedViewController: UIViewController? { get }
	var rootViewController: UIViewController? { get }

	func `switch`(
		to: UIViewController,
		completion: (() -> Void)?
	)
}

public final class WindowNavigationProvider: NavigationProvider {
	public var topMostViewController: UIViewController? {
		self.window?.rootViewController?.topMostViewController
	}

	public var topPresentedViewController: UIViewController? {
		self.window?.rootViewController?.topPresentedViewController
	}

	public var rootViewController: UIViewController? {
		self.window?.rootViewController
	}

	private var window: UIWindow?

	public init() {}

	public func setWindow(_ window: UIWindow) {
		self.window = window
	}

	public func `switch`(to: UIViewController, completion: (() -> Void)?) {
		self.window?.rootViewController = to
	}
}
