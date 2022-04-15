//
//  Article.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import Foundation

struct News: Decodable {

    struct Article: Decodable {
        let author, description, image: String
        let likes, views: Int

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }

    }

    let articles: [Article]

}

