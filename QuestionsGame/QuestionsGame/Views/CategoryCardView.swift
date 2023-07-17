//
//  CategoryCardView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct CategoryCardView: View {
    @EnvironmentObject var store: AppStore
    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    func isSelected() -> Bool{
        return store.state.selectedCategory?.name == category.name
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            AsyncImage(url: URL(string: self.category.imageUrl.absoluteString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 136, height: 99)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            
            Text(self.category.name)
                .font(.system(size: 16, weight: .regular))
                .frame(alignment: .leading)
        }
        .frame(width: 150, height: 139)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
        .padding([.horizontal, .bottom], 7)
        .padding(.top, 6)
        .scaleEffect(isSelected() ? 1.03 : 1)
        .animation(.linear)
        .onTapGesture {
            if isSelected() {
                store.dispatch(.setSelected(nil))
            } else {
                store.dispatch(.setSelected(category))
            }
        }
    }
}

#if !TESTING
struct CategoryCardView_Previews: PreviewProvider {

    static var previews: some View {
        let questions = QuestionList().questions
        let defaultURL: URL = URL(string: "https://live.staticflickr.com/7312/28222753271_5144638a2a_c.jpg")!
        let question = questions.randomElement()
        
        let categoryList: [Category] = [Category(name: question?.category ?? "Biology", imageUrl: question?.imageUrl ?? defaultURL)]
        

        let previewStore: AppStore = {
            let store = AppStore.preview
            
            store.dispatch(.setQuestions(questions))
            //store.dispatch(.setCategories(categoryList))
            return store
        }()

        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            CategoryCardView(category: categoryList[0])
                .previewLayout(.sizeThatFits)
                .environmentObject(previewStore)
        }
    }
}
#endif
