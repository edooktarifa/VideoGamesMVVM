//  Created by Phincon on 17/08/23.
//

import Foundation
struct Filters : Codable {
	let years : [Years]?

	enum CodingKeys: String, CodingKey {

		case years = "years"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		years = try values.decodeIfPresent([Years].self, forKey: .years)
	}

}
