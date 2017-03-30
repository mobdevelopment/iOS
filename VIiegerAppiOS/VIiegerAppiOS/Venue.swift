
import Foundation

class Venue {
    let id: Int
    let name: String
    let category: String
    let telephone: String
    let website_url: String
    let tagline: String
    
    init(_id: Int, _name: String, _category: String, _telephone: String, _website_url: String, _tagline: String){
        
        id = _id
        name = _name
        category = _category
        telephone = _telephone
        website_url = _website_url
        tagline = _tagline
        
    }
    
}
