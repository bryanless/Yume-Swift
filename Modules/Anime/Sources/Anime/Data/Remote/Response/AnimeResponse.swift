//
//  AnimeResponse.swift
//  
//
//  Created by Bryan on 06/01/23.
//

// MARK: - Anime
public struct AnimeResponse: Codable {
  let id: Int
  let title: String
  let mainPicture: MainPicture?
  let alternativeTitles: AlternativeTitles?
  let startDate, endDate, synopsis: String?
  let rating: Double?
  let rank, popularity: Int?
  let userAmount, favoriteAmount: Int
  let nsfw: Nsfw?
  let genres: [Genre]?
  let mediaType: MediaType
  let status: Status
  let episodeAmount: Int
  let startSeason: StartSeason?
  let source: Source?
  let episodeDuration: Int?
  let studios: [Studio]

  private enum CodingKeys: String, CodingKey {
    case id, title
    case mainPicture = "main_picture"
    case alternativeTitles = "alternative_titles"
    case startDate = "start_date"
    case endDate = "end_date"
    case synopsis
    case rating = "mean"
    case rank, popularity
    case userAmount = "num_list_users"
    case favoriteAmount = "num_favorites"
    case nsfw
    case genres
    case mediaType = "media_type"
    case status
    case episodeAmount = "num_episodes"
    case startSeason = "start_season"
    case source
    case episodeDuration = "average_episode_duration"
    case studios
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.mainPicture = try? container.decodeIfPresent(MainPicture.self, forKey: .mainPicture)
    self.alternativeTitles = try? container.decodeIfPresent(AlternativeTitles.self, forKey: .alternativeTitles)
    let startDateString = try? container.decodeIfPresent(String.self, forKey: .startDate)
    self.startDate = startDateString?.apiToFullDate() ?? "Unknown"
    let endDateString = try? container.decodeIfPresent(String.self, forKey: .endDate)
    self.endDate = endDateString?.apiToFullDate() ?? "Unknown"
    self.synopsis = try? container.decodeIfPresent(String.self, forKey: .synopsis)
    self.rating = try? container.decodeIfPresent(Double.self, forKey: .rating)
    self.rank = try? container.decodeIfPresent(Int.self, forKey: .rank)
    self.popularity = try? container.decodeIfPresent(Int.self, forKey: .popularity)
    self.userAmount = try container.decode(Int.self, forKey: .userAmount)
    self.favoriteAmount = try container.decode(Int.self, forKey: .favoriteAmount)
    self.nsfw = try? container.decodeIfPresent(Nsfw.self, forKey: .nsfw)
    self.genres = try? container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
    self.mediaType = try container.decode(MediaType.self, forKey: .mediaType)
    self.status = try container.decode(Status.self, forKey: .status)
    self.episodeAmount = try container.decode(Int.self, forKey: .episodeAmount)
    self.startSeason = try? container.decode(StartSeason.self, forKey: .startSeason)
    self.source = try? container.decodeIfPresent(Source.self, forKey: .source)
    self.episodeDuration = try? container.decode(Int.self, forKey: .episodeDuration)
    self.studios = try container.decode([Studio].self, forKey: .studios)
  }
}

// MARK: - AlternativeTitles
public struct AlternativeTitles: Codable {
  let synonyms: [String]?
  let english, japanese: String?

  enum CodingKeys: String, CodingKey {
    case synonyms
    case english = "en"
    case japanese = "ja"
  }
}

// MARK: - Genre
public struct Genre: Codable {
  let id: Int
  let name: String
}

// MARK: - MainPicture
public struct MainPicture: Codable {
  let medium: String
  let large: String?
}

// MARK: - NSFW
public enum Nsfw: String, Codable {
  case white
  case gray
  case black

  var name: String {
    return rawValue
  }
}

// MARK: - MediaType
public enum MediaType: String, Codable {
  case unknown, tv, ova
  case movie, special, ona
  case music

  var name: String {
    switch self {
    case .unknown:
      return "Unknown"
    case .tv:
      return "TV"
    case .ova:
      return "OVA"
    case .movie:
      return "Movie"
    case .special:
      return "Special"
    case .ona:
      return "ONA"
    case .music:
      return "Music"
    }
  }
}

// MARK: - Source
public enum Source: String, Codable {
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

  var name: String {
    return rawValue.snakeCaseToTitleCase()
  }
}

// MARK: - StartSeason
public struct StartSeason: Codable {
  let year: Int
  let season: Season
}

// MARK: - Genre
public struct Studio: Codable {
  let id: Int
  let name: String
}

// MARK: - Season
public enum Season: String, Codable {
  case fall, spring, summer
  case winter

  var name: String {
    return rawValue.capitalized
  }
}

// MARK: - Status
public enum Status: String, Codable {
  case finishedAiring = "finished_airing"
  case currentlyAiring = "currently_airing"
  case notYetAired = "not_yet_aired"

  var name: String {
    return rawValue.snakeCaseToTitleCase()
  }
}

