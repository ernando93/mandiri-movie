//
//  Extension+Genre.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import UIKit

extension Genre {
    
    var emoji: String {
        switch name {
        case "Action": return "🎬"
        case "Adventure": return "🗺️"
        case "Animation": return "🎨"
        case "Comedy": return "😂"
        case "Crime": return "🕵️"
        case "Documentary": return "📚"
        case "Drama": return "🎭"
        case "Family": return "👨‍👩‍👧‍👦"
        case "Fantasy": return "🐉"
        case "History": return "🏛️"
        case "Horror": return "👻"
        case "Music": return "🎵"
        case "Mystery": return "🔍"
        case "Romance": return "❤️"
        case "Science Fiction": return "🚀"
        case "TV Movie": return "📺"
        case "Thriller": return "😱"
        case "War": return "⚔️"
        case "Western": return "🤠"
        default: return "🎥"
        }
    }
}

extension Genre {

    var color: UIColor {
        switch name {
        case "Action":
            return .systemRed

        case "Adventure":
            return .systemOrange

        case "Animation":
            return .systemMint

        case "Comedy":
            return .systemYellow

        case "Crime":
            return .systemBlue

        case "Drama":
            return .systemIndigo

        case "Fantasy":
            return .systemPurple

        case "Horror":
            return .systemGray

        case "Romance":
            return .systemPink

        case "Science Fiction":
            return .systemCyan

        default:
            return .systemTeal
        }
    }
}
