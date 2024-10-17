
import SwiftUI

struct HomeView: View {
    var body: some View {
         
        NavigationView {
            
            VStack {
                Text("Bienvenue à la Home Page")
                    .font(.title2)
                    .padding(.bottom, 40)

                
                Image("calucator")

                NavigationLink(destination: CalculatorView()) {
                    Text("Open Calculator")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)

                }
                .padding(.bottom, 20)

                Image("TodoListe")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(30)

                NavigationLink(destination: TodoListView()) {
                    Text("Open To-Do List")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Home Page", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
