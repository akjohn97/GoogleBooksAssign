
struct Book {
    
    let author: String
    let id: String
    let title: String
    let published: String
    let pageCount: Int
    let description: String
    let cover: String!
    
    
    private enum CodingKeys: String, CodingKey {
        case author = "authors"
        case id = "id"
        case title = "title"
        case published = "publishedDate"
        case pageCount = "pageCount"
        case description = "description"
        case cover = "smallThumbnail"
        
    }
    
    
}

extension Book {
    
    init(_ core: CoreBook) {
        self.author = core.author!
        self.id = core.uid!
        self.title = core.title!
        self.published = core.published!
        self.pageCount = Int(core.pageCount)
        self.description = core.udescription!
        self.cover = core.cover
        
    }
}
