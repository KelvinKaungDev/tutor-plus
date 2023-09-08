import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var tutorLists : TutorViewModel
    @State var isPresent = false
    @State var name : String = ""
    @State var tutorId : String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                List {
                    ForEach(tutorLists.tutors, id : \.self) { tutor in
                        NavigationLink(
                            destination: DetailView(tutorModel: tutor),
                            label: {
                                VStack (alignment: .leading) {
                                    Text(tutor.tutorName)
                                    Text(tutor._id).font(.caption)
                                }
                            }
                        ).padding()
                    }.onDelete (perform: deleteTutor)
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("Today Shdule")
            .navigationBarItems(trailing: plusButton)
            
        } .sheet(isPresented: $isPresent) {
            CreateContentView(isPresent: $isPresent, name: $name, tutorId: $tutorId )
        }
    }
}

extension ContentView {
    
    var plusButton : some View {
        Button {
            isPresent.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func deleteTutor(indexSet : IndexSet) {
        let id = indexSet.map{tutorLists.tutors[$0]._id}
        DispatchQueue.main.async {
            let parameter : [String : Any] = ["_id" : id[0]]
            self.tutorLists.deleteData(parameters: parameter, id: id[0])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
