import UIKit
import SwiftUI

// This is just a view controller that wraps a FocusableView
class FocusingViewController: UIViewController {
    let purpose: String
    var focusableView: FocusableView!

    init(title: String) {
        self.purpose = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        focusableView = FocusableView(title: purpose, frame: .zero)
        view.addSubview(focusableView)
        focusGroupIdentifier = purpose
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        focusableView.frame = .init(
            x: view.safeAreaInsets.left + 10,
            y: view.safeAreaInsets.top + 60,
            width: 300,
            height: 40
        )
    }
}
