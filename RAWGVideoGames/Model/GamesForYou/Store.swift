//  Created by Phincon on 17/08/23.
//

import Foundation
struct Store : Codable {
	let id : Int?
	let name : String?
	let slug : String?
	let domain : String?
	let games_count : Int?
	let image_background : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case slug = "slug"
		case domain = "domain"
		case games_count = "games_count"
		case image_background = "image_background"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		domain = try values.decodeIfPresent(String.self, forKey: .domain)
		games_count = try values.decodeIfPresent(Int.self, forKey: .games_count)
		image_background = try values.decodeIfPresent(String.self, forKey: .image_background)
	}

}
