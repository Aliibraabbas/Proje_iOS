
import Foundation

class DataController {
    static var registeredUsers: [String: String] = [
        "Jean": "12345",
        "Anne": "54321"
    ]
    
    let tableau = [1, 2, 23]
    
    func checkTableau() {
        for number in tableau {
            
        }
    }
    
    func checkDico(dico: [String:EleveTest]) {
        for element in dico {
            print("\(element.key) s'appelle \(element.value.name) et a \(element.value.age)")
        }
    }
}

struct EleveTest {
    var name: String
    var age: Int
}
