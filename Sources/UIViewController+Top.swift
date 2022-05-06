//
//  Created by Антон Лобанов on 22.04.2022.
//

import UIKit

public extension UIViewController {
	var topMostViewController: UIViewController {
		self.findTopMostViewController(self)
	}

	private func findTopMostViewController(_ controller: UIViewController) -> UIViewController {
		if let presented = controller.presentedViewController {
			return self.findTopMostViewController(presented)
		}

		if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
			return self.findTopMostViewController(selected)
		}

		if let navigationController = controller as? UINavigationController,
		   let lastViewController = navigationController.visibleViewController
		{
			return self.findTopMostViewController(lastViewController)
		}

		return controller
	}
}

public extension UIViewController {
	var topPresentedViewController: UIViewController {
		self.findTopPresentedViewController(self)
	}

	private func findTopPresentedViewController(_ controller: UIViewController) -> UIViewController {
		if let presented = controller.presentedViewController {
			return self.findTopMostViewController(presented)
		}

		return controller
	}
}
