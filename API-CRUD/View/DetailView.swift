//
//  DetailView.swift
//  API-CRUD
//
//  Created by Kelvin Gao  on 7/9/2566 BE.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var tutorViewModel : TutorViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var tutorModel : TutorModel
    @State var name = ""
    @State var tutorId = ""
    @State var isAlert : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading){
                    
                    Text("Detail")
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
                .onAppear {
                    self.name = tutorModel.tutorName
                    self.tutorId = tutorModel.tutorId
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("New Post", displayMode: .inline)
            .navigationBarItems(trailing: trailing)
        }

    }
    
    var trailing : some View {
        Button {
            if name != "" && tutorId != "" {
                let parameter : [String : Any] = ["tutorId" : tutorId, "tutorName" : name]
                tutorViewModel.updateData(parameters: parameter, id: tutorModel._id)
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text("Update")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(tutorModel: .init(_id: "123", tutorId: "123", tutorName: "123"))
    }
}
