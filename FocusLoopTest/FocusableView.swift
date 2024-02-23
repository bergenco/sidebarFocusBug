//
//  FocusableView.swift
//  FocusLoopTest
//
//  Created by Majd Taby on 2/23/24.
//

import UIKit

// This is just a view that shows if it's focused or not
class FocusableView: UIView {
    var label: UILabel!
    let title: String

    init(title: String, frame: CGRect) {
        self.title = title
        super.init(frame: frame)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        label = UILabel(frame: .zero)
        label.text = title
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = .init(
            x: 10,
            y: 0,
            width: frame.width - 10,
            height: frame.height
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFocused: Bool {
        true
    }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext,
        with coordinator: UIFocusAnimationCoordinator
    ) {
        if context.nextFocusedView == self {
            label.text = "\(title) focused view"
            label.textColor = .red
        }
        else if context.previouslyFocusedView == self {
            label.text = "\(title) previously focused"
            label.textColor = .gray
        }
    }
}
