//  Created by Phincon on 17/08/23.
//

import Foundation
struct Platforms : Codable {
	let platform : Platform?
	let released_at : String?
//	let requirements_en : String?
//	let requirements_ru : String?

	enum CodingKeys: String, CodingKey {

		case platform = "platform"
		case released_at = "released_at"
//		case requirements_en = "requirements_en"
//		case requirements_ru = "requirements_ru"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		platform = try values.decodeIfPresent(Platform.self, forKey: .platform)
		released_at = try values.decodeIfPresent(String.self, forKey: .released_at)
//		requirements_en = try values.decodeIfPresent(String.self, forKey: .requirements_en)
//		requirements_ru = try values.decodeIfPresent(String.self, forKey: .requirements_ru)
	}

}
