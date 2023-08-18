//
//  VideoGamesModelFactory.swift
//  RAWGVideoGamesTests
//
//  Created by Phincon on 18/08/23.
//

import Foundation
@testable import RAWGVideoGames

class VideoGamesModelFactory {
    
    func successGetListVideoGAmes() -> Data? {
        let rawString = """
            {
                "count": 852584,
                "next": "https://api.rawg.io/api/games?key=32c7cdcac9c445949dbd91564e6c3d51&page=2",
                "previous": null,
                "results": [],
                "seo_title": "All Games",
                "seo_description": "",
                "seo_keywords": "",
                "seo_h1": "All Games",
                "noindex": false,
                "nofollow": false,
                "description": "",
                "filters": {
                    "years": []
                },
                "nofollow_collections": [
                    "stores"
                ]
            }
            """
        
        return rawString.data(using: .utf8)
    }
    
    func seccessGetDetailVideoGames() -> Data? {
        let rawString = """
            {
                "id": 3498,
                "slug": "grand-theft-auto-v",
                "name": "Grand Theft Auto V",
                "name_original": "Grand Theft Auto V",
                "description": "",
                "metacritic": 92,
                "metacritic_platforms": [],
                "released": "2013-09-17",
                "tba": false,
                "updated": "2023-08-17T16:12:53",
                "background_image": "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
                "background_image_additional": "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg",
                "website": "http://www.rockstargames.com/V/",
                "rating": 4.47,
                "rating_top": 5,
                "ratings": [],
                "reactions": {
                    "21": 2
                },
                "added": 19890,
                "added_by_status": {
                    "yet": 511
                },
                "playtime": 74,
                "screenshots_count": 57,
                "movies_count": 8,
                "creators_count": 11,
                "achievements_count": 539,
                "parent_achievements_count": 75,
                "reddit_url": "https://www.reddit.com/r/GrandTheftAutoV/",
                "reddit_name": "/r/GrandTheftAutoV",
                "reddit_description": "/r/GrandTheftAutoV - the subreddit for all GTA V related news, content, and discussions revolving around Rockstar's critically acclaimed single player release and the ongoing multiplayer expansion of Grand Theft Auto Online.",
                "reddit_logo": "",
                "reddit_count": 5159,
                "twitch_count": 99,
                "youtube_count": 1000000,
                "reviews_text_count": 95,
                "ratings_count": 6478,
                "suggestions_count": 422,
                "alternative_names": [
                    "GTA 5",
                    "GTA V",
                    "GTA5",
                    "GTAV"
                ],
                "metacritic_url": "https://www.metacritic.com/game/pc/grand-theft-auto-v",
                "parents_count": 0,
                "additions_count": 3,
                "game_series_count": 10,
                "user_game": null,
                "reviews_count": 6573,
                "saturated_color": "0f0f0f",
                "dominant_color": "0f0f0f",
                "parent_platforms": [],
                "platforms": [],
                "stores": [],
                "developers": [],
                "genres": [],
                "tags": [],
                "publishers": [],
                "esrb_rating": {
                    "id": 4,
                    "name": "Mature",
                    "slug": "mature"
                },
                "clip": null,
                "description_raw": "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.\n\nEspañol\nRockstar Games se hizo más grande desde su entrega anterior de la serie. Obtienes la construcción del mundo complicada y realista de Liberty City de GTA4 en el escenario de Los Santos, un viejo favorito de los fans, GTA San Andreas. 561 vehículos diferentes (incluidos todos los transportes que puede operar) y la cantidad aumenta con cada actualización.\nNarración simultánea desde tres perspectivas únicas:\nSigue a Michael, ex-criminal que vive su vida de ocio lejos del pasado, Franklin, un niño que busca un futuro mejor, y Trevor, el pasado exacto del que Michael está tratando de huir.\nGTA Online proporcionará muchos desafíos adicionales incluso para los jugadores experimentados, recién llegados del modo historia. Ahora tendrás otros jugadores cerca que pueden ayudarte con la misma probabilidad que arruinar tu misión. Los jugadores pueden experimentar todas las mecánicas de GTA actualizadas a través del personaje personalizable único, y el contenido de la comunidad combinado con el sistema de nivelación tiende a mantener a todos ocupados y comprometidos."
            }
            """
        
        return rawString.data(using: .utf8)
    }
    
    func successSearchMovieGames() -> Data? {
        let rawString = """
            {
                "count": 3650,
                    "next": "https://api.rawg.io/api/games?key=32c7cdcac9c445949dbd91564e6c3d51&page=2&search=Grand+Theft+Auto+V",
                    "previous": null,
            "results": [
                "name": "Grand Theft Auto V"
              ]
            }
            """
        
        return rawString.data(using: .utf8)
    }
    
}
