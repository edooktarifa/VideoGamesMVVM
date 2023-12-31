//  Created by Phincon on 17/08/23.
//

import Foundation
struct EsrbRating : Codable {
	let id : Int?
	let name : String?
	let slug : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case slug = "slug"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
	}

}
