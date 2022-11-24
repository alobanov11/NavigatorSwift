//
//  Created by Антон Лобанов on 08.04.2022.
//

import UIKit

public final class Navigator {
	private let rootProvider: NavigatorRootProvider

	public init(rootProvider: NavigatorRootProvider) {
		self.rootProvider = rootProvider
	}

	public func navigate(
		with routes: [Route],
		animated: Bool = true,
		completion: (() -> Void)? = nil
	) {
		guard routes.isEmpty == false else {
			completion?()
			return
		}

		var routes = routes

		self.navigate(to: routes.removeFirst(), animated: animated) { [weak self] in
			self?.navigate(with: routes, animated: animated, completion: completion)
		}
	}

	public func navigate(
		to route: Route,
		animated: Bool = true,
		completion: (() -> Void)? = nil
	) {
		switch route {
		case let .setRoot(presentable):
			guard let viewController = presentable.build() else {
				print("⚠️ Can't build \(type(of: presentable))")
				return
			}
			self.rootProvider.switch(
				to: viewController,
				completion: completion
			)

		case let .setTab(index):
			guard let tabController = self.rootProvider.rootViewController as? UITabBarController else {
				print("⚠️ Can't set tab")
				return
			}
			tabController.selectedIndex = index
			completion?()

		case let .push(presentable):
			guard let viewController = presentable.build() else {
				print("⚠️ Can't build \(type(of: presentable))")
				return
			}
			guard let navigationController = self.rootProvider.topMostViewController?.navigationController else {
				print("⚠️ Can't find navigation controller")
				return
			}
			navigationController.pushViewController(
				viewController,
				animated: animated,
				completion: completion
			)

		case .pop:
			guard let navigationController = self.rootProvider.topMostViewController?.navigationController else {
				print("⚠️ Can't find navigation controller")
				return
			}
			navigationController.popViewController(
				animated: animated,
				completion: completion
			)

		case let .popTo(number):
			guard let navigationController = self.rootProvider.topMostViewController?.navigationController else {
				print("⚠️ Can't find navigation controller")
				return
			}
			guard navigationController.viewControllers.count > number else {
				print("⚠️ Can't pop to \(number)")
				return
			}
			navigationController.popToViewController(
				navigationController.viewControllers[navigationController.viewControllers.count - 1 - abs(number)],
				animated: animated,
				completion: completion
			)

		case .popToRoot:
			guard let navigationController = self.rootProvider.topMostViewController?.navigationController else {
				print("⚠️ Can't find navigation controller")
				return
			}
			navigationController.popToRootViewController(
				animated: animated,
				completion: completion
			)

		case let .present(presentable):
			guard let viewController = presentable.build() else {
				print("⚠️ Can't build \(type(of: presentable))")
				return
			}
			guard let topPresented = self.rootProvider.topPresentedViewController else {
				print("⚠️ Can't find top presented controller")
				return
			}
			topPresented.present(
				viewController,
				animated: animated,
				completion: completion
			)

		case .dismiss:
			guard let topPresented = self.rootProvider.topPresentedViewController else {
				print("⚠️ Can't find top presented controller")
				return
			}
			topPresented.dismiss(
				animated: animated,
				completion: completion
			)

		case .dismissOnRoot:
			self.rootProvider.rootViewController?.dismiss(
				animated: animated,
				completion: completion
			)
		}
	}
}

private extension UINavigationController {
	func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
		self.pushViewController(viewController, animated: animated)

		guard animated, let coordinator = self.transitionCoordinator else {
			DispatchQueue.main.async { completion?() }
			return
		}

		coordinator.animate(alongsideTransition: nil) { _ in completion?() }
	}

	func popViewController(animated: Bool, completion: (() -> Void)?) {
		self.popViewController(animated: animated)

		guard animated, let coordinator = self.transitionCoordinator else {
			DispatchQueue.main.async { completion?() }
			return
		}

		coordinator.animate(alongsideTransition: nil) { _ in completion?() }
	}

	func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
		self.popToViewController(viewController, animated: animated)

		guard animated, let coordinator = self.transitionCoordinator else {
			DispatchQueue.main.async { completion?() }
			return
		}

		coordinator.animate(alongsideTransition: nil) { _ in completion?() }
	}

	func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
		self.popToRootViewController(animated: animated)

		guard animated, let coordinator = self.transitionCoordinator else {
			DispatchQueue.main.async { completion?() }
			return
		}

		coordinator.animate(alongsideTransition: nil) { _ in completion?() }
	}
}
