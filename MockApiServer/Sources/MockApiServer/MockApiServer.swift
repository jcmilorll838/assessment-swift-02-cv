import Foundation
import Kitura

@main
public struct MockApiServer {
    public static func main() {
        let router = Router()
        router.all(middleware: BodyParser())

        let services = QuestionsGameServices()

        router.get("/questions") { _, response, next in
            services.getQuestions(forResource: "questions"){ (result) in
                switch result {
                case .success(let data):
                    response.send(data: data)
                case .failure(let error):
                    response.status(.badRequest)
                    response.send(error.localizedDescription)

                }
            }
        }

        //route to handle GET requests to any other endpoint
        router.get("*") { request, response, next in
            response.status(.notFound)
            response.send("Not Found")
        }

        let port = ProcessInfo.processInfo.environment["PORT"] ?? "8090"
        Kitura.addHTTPServer(onPort: Int(port)!, with: router)
        Kitura.run()
    }
}
