//
//  Created by Антон Лобанов on 08.04.2022.
//

import UIKit

public protocol NavigatorRootProvider {
	var topMostViewController: UIViewController? { get }
	var topPresentedViewController: UIViewController? { get }
	var rootViewController: UIViewController? { get }

	func `switch`(
		to: UIViewController,
		completion: (() -> Void)?
	)
}

public protocol NavigatorRootContainer: AnyObject {
	var rootViewController: UIViewController? { get set }
}

extension UIWindow: NavigatorRootContainer {}

public final class BaseNavigatorRootProvider: NavigatorRootProvider {
	public var topMostViewController: UIViewController? {
		self.container.rootViewController?.topMostViewController
	}

	public var topPresentedViewController: UIViewController? {
		self.container.rootViewController?.topPresentedViewController
	}

	public var rootViewController: UIViewController? {
		self.container.rootViewController
	}

	private let container: NavigatorRootContainer

	public init(container: NavigatorRootContainer) {
		self.container = container
	}

	public func `switch`(to: UIViewController, completion: (() -> Void)?) {
		self.container.rootViewController = to
	}
}
