import SwiftUI

struct CreateContentView: View {
    
    @EnvironmentObject var TutorUpdate : TutorViewModel
    @Binding var isPresent : Bool
    @Binding var name : String
    @Binding var tutorId : String
    @State var isAlert : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading){
                    
                    Text("Create New Post")
                        .padding()
                        .font(Font.system(size: 25, weight: .bold))
                    TextField("Tutor Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Tutor ID", text: $tutorId)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
            
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                .alert(isPresented: $isAlert) {
                    let title = Text("No Data")
                    let message = Text("Please fill your data first")
                    return Alert(title: title, message: message)
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("New Post", displayMode: .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    
    var leading : some View {
        Button {
            isPresent.toggle()
        } label: {
            Text("Cancel")
        }
    }

    var trailing : some View {
        Button {
            if name != "" && tutorId != "" {
                let parameters : [String : Any] = ["tutorId" : tutorId, "tutorName" : name]
                TutorUpdate.createData(parameters: parameters)
                isPresent.toggle()
            } else {
                isAlert.toggle()
            }
        } label: {
            Text("Post")
        }
    }
}

struct CreateContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContentView(isPresent: .constant(false), name: .constant("Kelvin"), tutorId: .constant("113"))
    }
}
