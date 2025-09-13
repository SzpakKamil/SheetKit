//
//  SKTDatePicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 18/07/2025.
//


import SwiftUI
#if os(tvOS)
internal import UIKit

@_documentation(visibility: internal)
struct SKTDatePicker: UIViewRepresentable {
    @Binding var date: Date
    let minDate: Date?
    let maxDate: Date?
    let order: GregorianCalendarDatePickerDelegate.DateComponentsOrder
    let locale: Locale
    let offLimitYearsDisplayed: Int
    
    init(
        date: Binding<Date>,
        minDate: Date? = nil,
        maxDate: Date? = nil,
        order: GregorianCalendarDatePickerDelegate.DateComponentsOrder = .monthDayYear,
        locale: Locale = .autoupdatingCurrent,
        offLimitYearsDisplayed: Int = 20
    ) {
        self._date = date
        self.minDate = minDate
        self.maxDate = maxDate
        self.order = order
        self.locale = locale
        self.offLimitYearsDisplayed = offLimitYearsDisplayed
    }
    
    func makeUIView(context: Context) -> SKTDatePickerView {
        let delegate = GregorianCalendarDatePickerDelegate(
            order: order,
            locale: locale,
            minDate: minDate,
            maxDate: maxDate,
            initialDate: date,
            offLimitYearsDisplayed: offLimitYearsDisplayed
        )
        
        let pickerView = SKTDatePickerView(delegate: delegate)
        pickerView.onDateChanged = { newDate in
            context.coordinator.updateDate(newDate)
        }
        
        return pickerView
    }
    
    func updateUIView(_ uiView: SKTDatePickerView, context: Context) {
        // Update the delegate's date if it has changed externally
        if let delegate = uiView.delegate, delegate.date != date {
            delegate.date = date
            uiView.reloadData()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(date: $date)
    }
    
    class Coordinator: NSObject {
        @Binding var date: Date
        
        init(date: Binding<Date>) {
            self._date = date
            super.init()
        }
        
        func updateDate(_ newDate: Date) {
            DispatchQueue.main.async {
                self.date = newDate
            }
        }
    }
}

@_documentation(visibility: internal)
struct SKTDatePickerExample: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            SKTDatePicker(
                date: $selectedDate,
                minDate: Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)),
                maxDate: Date(),
                order: .monthDayYear,
                locale: .autoupdatingCurrent,
                offLimitYearsDisplayed: 20
            )
            .frame(height: 300) // Adjust height as needed
            .padding()
            
            Text(SKTranslation.SKDatePicker.title.value)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.black) // tvOS typically uses dark backgrounds
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

@_documentation(visibility: internal)
struct SKTDatePickerExample_Previews: PreviewProvider {
    static var previews: some View {
        SKTDatePickerExample()
    }
}
#endif
