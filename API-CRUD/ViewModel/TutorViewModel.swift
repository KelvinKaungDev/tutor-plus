import Foundation

class TutorViewModel : ObservableObject{
    @Published var tutors = [TutorModel]()
    
    init () {
        getData()
    }
    
    func getData() {
        if let url = URL(string: "https://tutorplus.vercel.app/api/tutorPlus/tutors") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _ , error in
                if error == nil {
                    if let safeData = data {
                        self.fetchData(safeData, getData: true)
                    }
                }
            }
            
            task.resume()
        }
    }
        
    func createData(parameters : [String : Any]) {
        if let url = URL(string: "https://tutorplus.vercel.app/api/tutorPlus/tutors") {
            
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { _ , _ , error in
                if error == nil {
                    self.getData()
                }
            }

            task.resume()
        }
    }
    
    func updateData(parameters : [String : Any], id : String) {
        if let url = URL(string: "https://tutorplus.vercel.app/api/tutorPlus/tutors/\(id)") {
            
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { _ , _ , error in
                if error == nil {
                    self.getData()
                }
            }
            task.resume()
        }
    }
    
    func deleteData(parameters : [String : Any], id : String) {
        if let url = URL(string: "https://tutorplus.vercel.app/api/tutorPlus/tutors/\(id)") {
            
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { _ , _ , error in
                if error == nil {
                    self.getData()
                }
            }

            task.resume()
        }
    }
    
    func fetchData (_ data: Data, getData : Bool) {
        let decode = JSONDecoder()
        do {
            let result = try decode.decode([TutorModel].self, from: data)
            DispatchQueue.main.async {
                if getData {
                    self.tutors = result
                } else {
                    print("Hello")
                }
            }
        } catch {
            print(String(describing: error))
        }
    }
}
