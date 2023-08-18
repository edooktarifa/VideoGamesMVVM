//  Created by Phincon on 17/08/23.
//

import Foundation
struct VideoGamesModel : Codable {
	let count : Int?
	let next : String?
	let previous : String?
	let results : [VideoGameResults]?
	let seo_title : String?
	let seo_description : String?
	let seo_keywords : String?
	let seo_h1 : String?
	let noindex : Bool?
	let nofollow : Bool?
	let description : String?
	let filters : Filters?
	let nofollow_collections : [String]?

	enum CodingKeys: String, CodingKey {

		case count = "count"
		case next = "next"
		case previous = "previous"
		case results = "results"
		case seo_title = "seo_title"
		case seo_description = "seo_description"
		case seo_keywords = "seo_keywords"
		case seo_h1 = "seo_h1"
		case noindex = "noindex"
		case nofollow = "nofollow"
		case description = "description"
		case filters = "filters"
		case nofollow_collections = "nofollow_collections"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		next = try values.decodeIfPresent(String.self, forKey: .next)
		previous = try values.decodeIfPresent(String.self, forKey: .previous)
		results = try values.decodeIfPresent([VideoGameResults].self, forKey: .results)
		seo_title = try values.decodeIfPresent(String.self, forKey: .seo_title)
		seo_description = try values.decodeIfPresent(String.self, forKey: .seo_description)
		seo_keywords = try values.decodeIfPresent(String.self, forKey: .seo_keywords)
		seo_h1 = try values.decodeIfPresent(String.self, forKey: .seo_h1)
		noindex = try values.decodeIfPresent(Bool.self, forKey: .noindex)
		nofollow = try values.decodeIfPresent(Bool.self, forKey: .nofollow)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		filters = try values.decodeIfPresent(Filters.self, forKey: .filters)
		nofollow_collections = try values.decodeIfPresent([String].self, forKey: .nofollow_collections)
	}

}
