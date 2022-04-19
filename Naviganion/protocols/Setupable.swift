//
//  Setupable.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import Foundation


protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
