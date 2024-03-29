//
//  Created by Антон Лобанов on 08.04.2022.
//

import UIKit

public enum Route {
	case setRoot(Presentable)
	case setTab(Int)
	case push(Presentable)
	case pop
	case popTo(Int)
	case popToRoot
	case present(Presentable)
	case dismiss
	case dismissOnRoot
}
