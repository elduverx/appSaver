//
//  CreateView.swift
//  appSaver
//
//  Created by duverney muriel on 14/10/23.
//

import SwiftUI
import SwiftData
struct CreateView: View {
    @Environment(\.modelContext) var moc
    
    @Environment(\.dismiss) var dismiss
    
    @State var imgData: Data = .init(count: 0)
    @State private var name:String = ""
    @State var detail:String = ""
    @State var show:Bool = false
    
    
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Spacer()
                    if self.imgData.count != 0{
                        Button {
                            self.show.toggle()
                        } label: {
                                Image(uiImage: UIImage(data: self.imgData)!)
                                    .resizable().scaledToFill()
                                    .frame(width: 100,height: 100)
                                    .cornerRadius(6)
                                    .shadow(radius: 3)
                        }

                    }else {
                        
                            Button {
                                self.show.toggle()
                            } label: {
                                    Image(systemName: "photo.fill")
                                        .resizable().scaledToFill()
                                        .frame(width: 100,height: 100)
                                        .cornerRadius(6)
                                        .shadow(radius: 3)
                                        .foregroundStyle(.gray)
                            }
                    }
                    Spacer()
                }
                TextField("name",text: self.$name)
                TextEditor(text: self.$detail)
                Button {
                    let new = Saving(imgData: self.imgData, name: self.name, detail: self.detail, date: Date(), liked: false)
                    
                    self.moc.insert(new)
                    
                    try! self.moc.save()
                    dismiss()
                    
                } label: {
                    Text("Save")
                }

            }.navigationTitle("Create")
                .sheet(isPresented: self.$show, content: {
                    PhotoPicker(imgData: self.$imgData, show: self.$show)
                    
                })
        }
    }
}

#Preview {
    CreateView()
}


struct PhotoPicker: UIViewControllerRepresentable{
    
    @Binding var imgData: Data
    @Binding var show: Bool
    
    func makeCoordinator() -> Coordinator {
        return PhotoPicker.Coordinator(img0: self)
        
    }
    
    
    func makeUIViewController(context: Context) ->  UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    class Coordinator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var img0: PhotoPicker
        init(img0: PhotoPicker) {
            self.img0 = img0
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as? UIImage
            let data = image?.jpegData(compressionQuality: 50)
            self.img0.imgData = data!
            
            self.img0.show.toggle()
            
            
            
        }
        
    }
}
