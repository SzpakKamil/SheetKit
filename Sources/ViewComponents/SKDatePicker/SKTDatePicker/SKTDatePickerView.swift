//  Copyright © 2023 Paramount. All rights reserved.
#if os(tvOS)
internal import UIKit

extension SKTPickerViewStyle {
    static let datePicker = SKTPickerViewStyle(
        componentSpacing: 56,
        backgrounds: .init(
            selectedCellBackgroundColor: .clear,
            focusedCellBackgroundColor: .white
        ),
        labels: .init(
            selectedCellTextColor: .label,
            unselectedCellTextColor: .label.withAlphaComponent(0.7),
            focusedCellTextColor: .black,
            disabledCellTextColor: .label.withAlphaComponent(0.1),
            font: UIFontDescriptor().withSize(48),
            focusedFont: {
                let descriptor = UIFontDescriptor().withSize(48)
                return descriptor.withSymbolicTraits([descriptor.symbolicTraits, .traitBold])
            }()
        )
    )
}

/// This component displays a `SKTPickerView` restricting its delegate object to be
/// an instance of `GregorianCalendarDatePickerDelegate` class.
class SKTDatePickerView: UIView {
    internal let pickerView: SKTPickerView

    var style: SKTPickerViewStyle {
        didSet {
            pickerView.style = style
        }
    }

    var delegate: GregorianCalendarDatePickerDelegate? {
        didSet {
            pickerView.delegate = delegate
            delegate?.onDateChanged = { [weak self] updatedDate in
                self?.onDateChanged?(updatedDate)
            }
        }
    }

    var date: Date? {
        delegate?.date
    }

    var onDateChanged: ((Date) -> Void)?

    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        pickerView.preferredFocusEnvironments
    }

    init(delegate: GregorianCalendarDatePickerDelegate? = nil) {
        self.delegate = delegate
        self.style = .datePicker
        self.pickerView = .init(style: self.style, delegate: delegate)

        super.init(frame: .zero)

        self.delegate?.onDateChanged = { [weak self] updatedDate in
            self?.onDateChanged?(updatedDate)
        }
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        accessibilityElements = [pickerView]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData() {
        pickerView.reloadData()
    }

    func reloadComponents(_ indices: IndexSet) {
        pickerView.reloadComponents(indices)
    }

    func reloadComponent(_ index: Int) {
        pickerView.reloadComponent(index)
    }
}
#endif
