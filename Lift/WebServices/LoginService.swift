
import Foundation

class LoginService {
    
    var username: String
    var password: String
    
    init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    func getLoginResponse(completion: @escaping ([LoginResponse]?) -> ()) {
        
        let urlString = "http://localhost:8000/authenticateAppUser.php?email=\(self.username)&password=\(self.password)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let responses = try? JSONDecoder().decode([LoginResponse].self, from: data)
            
            DispatchQueue.main.async {
                completion(responses)
            }
            
            
        }.resume()
    }
}

// WEB REQUEST STUFF

class LoginRequest : ObservableObject {
    
    @Published var responses = [LoginViewModel]()
    @Published var success : Bool = false
    @Published var loggedInID : Int = 0
    
    
    func send(username: String, password: String) {
        print("Sending Login...")
        LoginService(username: username, password: password).getLoginResponse() { responses in
            
            if let responses = responses {
                self.responses = responses.map(LoginViewModel.init)
                print("Received >")
                print(responses)
                print("<")
                for response in responses {
                    if response.authenticationSuccess == 1 {
                        self.success = true
                        self.loggedInID = response.id
                        print("Setting success flag to true")
                    }
                }
            }
        }
    }
    
    func printMyFlag(){
        if self.success {
            print("Success flag is true")
        } else {
            print("Success flag is not true")
        }
    }
    
    func wasSuccessful() -> Bool {
        printMyFlag()
        return self.success
    }
    
    func userIDLoggedIn() -> Int {
        return self.loggedInID
    }
    
}

struct LoginViewModel {
    var response: LoginResponse
    
    init(response: LoginResponse) {
        
        self.response = response
    }
    
    var id: Int {
        return self.response.id
    }
    var email: String {
        return self.response.email
    }
    
    var password: String {
        return self.response.password
    }
    
    var authenticationSuccess: Int {
        return self.response.authenticationSuccess
    }

}

struct LoginResponse: Codable {
    let id: Int
    let email: String
    let password: String
    let authenticationSuccess: Int

}
 
