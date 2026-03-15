import Foundation

struct LocalQuestionProvider: QuestionProvider {
    
    func fetchQuestions() throws -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            throw NSError(domain: "FileNotFound", code: 1)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Question].self, from: data)
    }
}