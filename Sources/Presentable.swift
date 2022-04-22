//
//  Created by Антон Лобанов on 08.04.2022.
//

import UIKit

public protocol Presentable {
	func build() -> UIViewController?
}

extension UIViewController: Presentable {
	public func build() -> UIViewController? {
		self
	}
}
