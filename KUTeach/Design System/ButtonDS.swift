//
//  ButtonDS.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 10.01.2024.
//

import SwiftUI

struct ButtonDS: View {

    private let buttonTitle: String
    private let action: () -> Void

    init(
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        self.buttonTitle = buttonTitle
        self.action = action
    }

    var body: some View {
        Button(action: action) {

        }
    }
}
