//
//  MovieSchedulModels.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/6/25.
//

import Foundation

// MARK: - DTO
struct MovieScheduleResponseDTO: Codable {
    let status: String
    let message: String
    let data: MovieDataDTO
}

struct MovieDataDTO: Codable {
    let movies: [MovieDTO]
}

struct MovieDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageRating = "age_rating"
        case schedules
    }
}

struct ScheduleDTO: Codable {
    let date: String
    let areas: [AreaDTO]
}

struct AreaDTO: Codable {
    let area: String
    let items: [ItemDTO]
}

struct ItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

struct ShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}

// MARK: - Domain Models
struct Movie {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [Schedule]
}

struct Schedule {
    let date: Date
    let areas: [Area]
}

struct Area {
    let name: String
    let items: [Auditorium]
}

struct Auditorium {
    let id = UUID()
    let name: String
    let format: String
    let showtimes: [Showtime]
}

struct Showtime {
    let start: String
    let end: String
    let available: Int
    let total: Int
    
    var availableRatio: Double {
        Double(available) / Double(total)
    }
}

// MARK: - Mapper
struct MovieMapper {
    static func toDomain(from dto: MovieDTO) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            ageRating: dto.ageRating,
            schedules: dto.schedules.map { ScheduleMapper.toDomain(from: $0) }
        )
    }
}

struct ScheduleMapper {
    static func toDomain(from dto: ScheduleDTO) -> Schedule {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dto.date) ?? Date()
        
        return Schedule(
            date: date,
            areas: dto.areas.map { AreaMapper.toDomain(from: $0) }
        )
    }
}

struct AreaMapper {
    static func toDomain(from dto: AreaDTO) -> Area {
        Area(
            name: dto.area,
            items: dto.items.map { ItemMapper.toDomain(from: $0) }
        )
    }
}

struct ItemMapper {
    static func toDomain(from dto: ItemDTO) -> Auditorium {
        Auditorium(
            name: dto.auditorium,
            format: dto.format,
            showtimes: dto.showtimes.map { ShowtimeMapper.toDomain(from: $0) }
        )
    }
}

struct ShowtimeMapper {
    static func toDomain(from dto: ShowtimeDTO) -> Showtime {
        Showtime(
            start: dto.start,
            end: dto.end,
            available: dto.available,
            total: dto.total
        )
    }
}
