
import Foundation

class UserInfoService {
    
    var id: Int
    
    init(id: Int){
        self.id = id
    }
    
    func getUserInfoResponse(completion: @escaping ([UserInfoResponse]?) -> ()) {
        
        let urlString = "http://127.0.0.1:8000/getAppUserInfo.php?id=" + String(self.id)
        
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
            
            let responses = try? JSONDecoder().decode([UserInfoResponse].self, from: data)
            
            DispatchQueue.main.async {
                completion(responses)
                
            }
            
            
        }.resume()
    }
}

// WEB REQUEST STUFF

class UserInfoRequest : ObservableObject {
    
    @Published var responses = [UserInfoViewModel]()
    @Published var success : Bool = false
    @Published var user : User = User(id: 0, region: TestData.London, completedChallengeRefs: [], pictureRef: "missing.jpg", name: "Loading..", regDate: "2020-06-29 15:00:00")
    
    func send(id: Int) {
        print("Sending User Info Request...")
        UserInfoService(id: id).getUserInfoResponse() { responses in
            
            if let responses = responses {
                self.responses = responses.map(UserInfoViewModel.init)
                print("Received >")
                print(responses)
                print("<")
                for response in responses {
                    if response.user_request_success == 1 {
                        self.success = true
                        self.user = User(id: id, region: Region(longitude: response.region_longitude, latitude: response.region_latitude, name: response.region_name), completedChallengeRefs: [], pictureRef: response.picture_ref, name: "\(response.firstname) \(response.lastname)", regDate: response.reg_date)
                        print("Setting Success flag to true")
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
    
    func hasSucceeded() -> Bool {
        printMyFlag()
        return self.success
    }
    
}

struct UserInfoViewModel {
    var response: UserInfoResponse
    
    init(response: UserInfoResponse) {
        
        self.response = response
        //print(response)
    }
    
    var firstname: String {
        return self.response.firstname
    }
    var lastname: String {
        return self.response.lastname
    }
    var region_latitude : Double {
        return self.response.region_latitude
    }
    var region_longitude : Double {
        return self.response.region_longitude
    }
    var region_name : String {
        return self.response.region_name
    }
    var picture_ref : String {
        return self.response.picture_ref
    }
    var user_request_success : Int {
        return self.response.user_request_success
    }
    var reg_date : String {
        return self.response.reg_date
    }

}

struct UserInfoResponse: Codable {
    
    let firstname: String
    let lastname: String
    let region_latitude : Double
    let region_longitude : Double
    let region_name : String
    let picture_ref : String
    let reg_date: String
    let user_request_success : Int
    

}
 
