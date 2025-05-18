//
//  AnimeRow.swift
//  Yume
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Anime
import SwiftUI

public struct AnimeRow: View {
  @State var animes: [AnimeDomainModel]

    public var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(animes) { anime in
            AnimeItem(anime: anime)
          }
        }
      }
    }
}
