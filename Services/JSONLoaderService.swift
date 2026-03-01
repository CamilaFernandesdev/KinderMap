import Foundation

final class JSONLoaderService {

    func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "question", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([Question].self, from: data)
        else {
            return []
        }

        return questions
    }
}
