//  Copyright © 2023 Paramount. All rights reserved.
#if os(tvOS)
import Foundation
internal import UIKit

/// This component displays one or more components that the user can navigate to select items.
/// Each component has a list of rows that display a string. Users select items by navigating the
/// lists to the desired values. You provide the data to display in the picker view and respond to
/// user selection using a delegate object conforming to `SKTPickerViewDelegate` protocol.
class SKTPickerView: UIView {
    private var firstReload = true
    private let stack = UIStackView()
    internal var components: [SKTPickerComponentView] = []

    var lastFocusedComponentIndex: Int?

    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if let lastFocusedComponentIndex,
           lastFocusedComponentIndex < components.count {
            return [components[lastFocusedComponentIndex]]
        }
        return components.first.map { [$0] } ?? []
    }

    var style: SKTPickerViewStyle {
        didSet {
            stack.spacing = style.componentSpacing
            components.forEach {
                $0.style = self.style
            }
        }
    }

    weak var delegate: SKTPickerViewDelegate? {
        didSet {
            reloadData()
        }
    }

    init(style: SKTPickerViewStyle, delegate: SKTPickerViewDelegate? = nil) {
        self.style = style
        self.delegate = delegate
        super.init(frame: .zero)

        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = style.componentSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if firstReload {
            firstReload = false
            reloadData()
        }
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        guard let next = context.nextFocusedView,
              next.isDescendant(of: self)
        else { return }
        lastFocusedComponentIndex = components.firstIndex { component in
            next.isDescendant(of: component)
        }
    }
}

// MARK: Public API
extension SKTPickerView {
    /// Call this method to reload all the data that’s used to construct the picker view.
    func reloadData() {
        guard frame.width > 0 else { return }
        guard let delegate else { return }
        let componentsCount = delegate.numberOfComponents(in: self)
        guard componentsCount > 0 else { return }
        while components.count > componentsCount {
            let last = components.popLast()
            last?.removeFromSuperview()
        }
        while components.count < componentsCount {
            let new = SKTPickerComponentView()
            new.style = style
            stack.addArrangedSubview(new)
            components.append(new)
            new.delegate = self
        }
        reloadComponents(IndexSet(integersIn: components.indices))

        accessibilityElements = components
    }

    /// Call this method to reload all the data that’s used to construct the selected components of the picker view.
    func reloadComponents(_ indices: IndexSet) {
        indices.forEach { index in
            guard index >= 0 && index < self.components.count else { return }
            let component = self.components[index]
            if let width = self.delegate?.pickerView(self, widthForComponent: index) {
                component.setupWidthConstraint(constant: width)
            }
            component.reloadData()
        }
    }

    /// Call this method to reload all the data that’s used to construct the selected component of the picker view.
    func reloadComponent(_ index: Int) {
        reloadComponents([index])
    }
}

// MARK: SKTPickerComponentViewDelegate conformance
extension SKTPickerView: SKTPickerComponentViewDelegate {
    func numberOfItems(inPickerComponentView componentView: SKTPickerComponentView) -> Int {
        guard let component = components.firstIndex(of: componentView),
              let delegate
        else { return 0 }
        return delegate.pickerView(self, numberOfRowsInComponent: component)
    }

    func rangeOfAllowedRows(inPickerComponentView componentView: SKTPickerComponentView) -> ClosedRange<Int>? {
        guard let component = components.firstIndex(of: componentView),
              let delegate
        else { return nil }
        return delegate.pickerView(self, rangeOfAllowedRowsInComponent: component)
    }

    func pickerComponentView(_ componentView: SKTPickerComponentView, titleForRow row: Int) -> String? {
        guard let component = components.firstIndex(of: componentView),
              let delegate
        else { return nil }
        return delegate.pickerView(self, titleForRow: row, inComponent: component)
    }

    func pickerComponentView(_ componentView: SKTPickerComponentView, accessibilityStringForRow row: Int) -> String? {
        guard let component = components.firstIndex(of: componentView),
              let delegate
        else { return nil }
        return delegate.pickerView(self, accessibilityStringForRow: row, inComponent: component)
    }

    func pickerComponentView(_ componentView: SKTPickerComponentView, didSelectRow row: Int) {
        guard let component = components.firstIndex(of: componentView) else { return }
        delegate?.pickerView(self, didSelectRow: row, inComponent: component)
    }

    func indexOfSelectedRow(inPickerComponentView componentView: SKTPickerComponentView) -> Int? {
        guard let component = components.firstIndex(of: componentView) else { return nil }
        return delegate?.indexOfSelectedRow(inComponent: component, ofPickerView: self)
    }
}
#endif
