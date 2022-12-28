//
//  AnimeResponse.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

// MARK: - Anime
struct AnimeResponse: Codable {
  let id: Int
  let title: String
  let mainPicture: MainPicture?
  let alternativeTitles: AlternativeTitles?
  let startDate, endDate, synopsis: String?
  let mean: Double?
  let rank, popularity: Int?
  let numListUsers: Int
  let genres: [Genre]
  let mediaType: MediaType
  let status: Status
  let numEpisodes: Int
  let startSeason: StartSeason
  let source: Source?
  let averageEpisodeDuration: Int
  let studios: [Genre]

  enum CodingKeys: String, CodingKey {
    case id, title
    case mainPicture = "main_picture"
    case alternativeTitles = "alternative_titles"
    case startDate = "start_date"
    case endDate = "end_date"
    case synopsis, mean, rank, popularity
    case numListUsers = "num_list_users"
    case genres
    case mediaType = "media_type"
    case status
    case numEpisodes = "num_episodes"
    case startSeason = "start_season"
    case source
    case averageEpisodeDuration = "average_episode_duration"
    case studios
  }
}

// MARK: - AlternativeTitles
struct AlternativeTitles: Codable {
  let synonyms: [String]?
  let en, ja: String?
}

// MARK: - Genre
struct Genre: Codable {
  let id: Int
  let name: String
}

// MARK: - MainPicture
struct MainPicture: Codable {
  let medium: String
  let large: String?
}

// MARK: - MediaType
enum MediaType: String, Codable {
  case unknown, tv, ova
  case movie, special, ona
  case music
}

// MARK: - Source
enum Source: String, Codable {
  case other = "other"
  case original = "original"
  case manga = "manga"
  case fourKomaManga = "4_koma_manga"
  case webManga = "web_manga"
  case digitalManga = "digital_manga"
  case novel = "novel"
  case lightNovel = "light_novel"
  case visualNovel = "visual_novel"
  case game = "game"
  case cardGame = "card_game"
  case book = "book"
  case pictureBook = "picture_book"
  case radio = "radio"
  case music = "music"
}

// MARK: - StartSeason
struct StartSeason: Codable {
  let year: Int
  let season: Season
}

// MARK: - Season
enum Season: String, Codable {
  case fall, spring, summer
  case winter
}

// MARK: - Status
enum Status: String, Codable {
  case finishedAiring = "finished_airing"
  case currentlyAiring = "currently_airing"
  case notYetAired = "not_yet_aired"
}
