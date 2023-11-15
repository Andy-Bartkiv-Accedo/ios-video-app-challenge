//
//  data.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import Foundation
import UIKit
import SwiftUI

struct Item: Identifiable {
    var id: Int
    var title: String
    var year: String
    var description: String
    var imgSrc: String
    var poster: String
}

let movies = [
    Item(id:0, title: "The Marvels", year: "2023",
         description: "Carol Danvers, aka Captain Marvel, has reclaimed her identity from the tyrannical Kree and taken revenge on the Supreme Intelligence. But unintended consequences see Carol shouldering the burden of a destabilized universe. When her duties send her to an anomalous wormhole linked to a Kree revolutionary, her powers become entangled with that of Jersey City super-fan Kamala Khan, aka Ms. Marvel, and Carol’s estranged niece, now S.A.B.E.R. astronaut Captain Monica Rambeau. Together, this unlikely trio must team up and learn to work in concert to save the universe.",
        imgSrc: "movie01",
        poster: "poster01"),
    Item(id:1, title: "Sentinelle", year: "2023",
         description: "François Sentinelle has two lives. By day, he is the most famous cop of Réunion Island, known for his tough methods and flowery shirts, pursuing criminals in his famous yellow defender. But the rest of the time, Sentinelle is also a charming singer.",
        imgSrc: "movie04",
        poster: "poster04"),
    Item(id:2, title: "Mission: Impossible - Dead Reckoning Part One", year: "2023",
         description: "Ethan Hunt and his IMF team embark on their most dangerous mission yet: To track down a terrifying new weapon that threatens all of humanity before it falls into the wrong hands. With control of the future and the world's fate at stake and dark forces from Ethan's past closing in, a deadly race around the globe begins. Confronted by a mysterious, all-powerful enemy, Ethan must consider that nothing can matter more than his mission—not even the lives of those he cares about most.",
        imgSrc: "movie02",
        poster: "poster02"),
    Item(id:3, title: "Boudica", year: "2023",
         description: "Inspired by events in A.D. 60, Boudica follows the eponymous Celtic warrior who rules the Iceni people alongside her husband Prasutagus. When he dies at the hands of Roman soldiers, Boudica’s kingdom is left without a male heir and the Romans seize her land and property. Driven to the edge of madness and determined to avenge her husband’s death, Boudica rallies the various tribes from the region and wages an epic war against the mighty Roman empire.",
        imgSrc: "movie03",
        poster: "poster03"),
    Item(id:4, title: "The Marvels", year: "2023",
         description: "Carol Danvers, aka Captain Marvel, has reclaimed her identity from the tyrannical Kree and taken revenge on the Supreme Intelligence. But unintended consequences see Carol shouldering the burden of a destabilized universe. When her duties send her to an anomalous wormhole linked to a Kree revolutionary, her powers become entangled with that of Jersey City super-fan Kamala Khan, aka Ms. Marvel, and Carol’s estranged niece, now S.A.B.E.R. astronaut Captain Monica Rambeau. Together, this unlikely trio must team up and learn to work in concert to save the universe.",
        imgSrc: "movie01",
        poster: "poster01"),
    Item(id:5, title: "Sentinelle", year: "2023",
         description: "François Sentinelle has two lives. By day, he is the most famous cop of Réunion Island, known for his tough methods and flowery shirts, pursuing criminals in his famous yellow defender. But the rest of the time, Sentinelle is also a charming singer.",
        imgSrc: "movie04",
        poster: "poster04"),
]
