//
//  Article.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import Foundation

struct News: ViewModelProtocol { 
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

