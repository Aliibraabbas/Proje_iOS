import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var showingAlert = false
    
    var body: some View {
        if isLoggedIn {
            NavigationLink(destination: HomeView()) {
                                  Text("")
                                      .padding()
                                      
                              }
            HomeView()
//            NavigationLink(destination: HomeView())
             // Redirige vers la page d'accueil après la connexion
        } else {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)

                Button(action: {
                    // Vérifie les informations de connexion
                    if username == "Admin" && password == "1234" {
                        print("ok")
                        isLoggedIn = true
                    } else {
                        print("error")
                        showingAlert = true
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Erreur"), message: Text("Nom d'utilisateur ou mot de passe incorrect"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
