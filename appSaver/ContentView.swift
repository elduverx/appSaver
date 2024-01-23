//
//  ContentView.swift
//  appSaver
//
//  Created by duverney muriel on 13/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var moc
    @Query var saving: [Saving]
    
    @State private var show:Bool = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                ForEach(saving) { save in
                    VStack(alignment: .leading,spacing: 12) {
                        HStack(alignment: .top){
                            Text(save.name)
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                            }
                            .contextMenu{
                                Button {
                                    
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Label("Save to Album", systemImage: "square.and.arrow.up")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                            }
                            
                        }
                        Image(uiImage: UIImage(data: save.imgData)!)
                            .resizable().scaledToFill().frame(width: UIScreen.main.bounds.width - 24, height: 220)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        HStack(alignment: .top) {
                            HStack(alignment: .top) {
                                Text(save.date, style: .date)
                                Text(save.date,style: .time)
                            }.font(.callout).foregroundStyle(.gray)
                            Spacer()
                            Button {
                                save.liked.toggle()
                                
                                try! self.moc.save()
                            } label: {
                                Image(systemName: save.liked ? "bookmark.fill":"bookmark").foregroundStyle(save.liked ? .blue : .gray)
                            }
                            
                        }
                        Text(save.detail)
                            .lineLimit(4)
                    }
                    Divider()
                }
            }.navigationTitle("Showing up Master")
                .toolbar{
                    ToolbarItem{
                        Button(action: {
                            self.show.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }.sheet(isPresented: self.$show) {
                    CreateView()
                }
        }
    }
}

#Preview {
    ContentView()
    
}


@Model
final class Saving {
    var imgData: Data
    var name:String
    var detail:String
    var date:Date
    var liked: Bool
    
    
    init(imgData: Data, name: String, detail: String, date: Date, liked: Bool) {
        self.imgData = imgData
        self.name = name
        self.detail = detail
        self.date = date
        self.liked = liked
    }
}
