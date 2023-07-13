//
//  CategoryListView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(store.state.categories) { category in
                    CategoryCardView(category: category)
                        .accessibilityIdentifier("CategoryCardView-\(category.name)")

                }
                .accessibilityIdentifier("CategoryCardViewHStackItems")
            }
            .accessibilityIdentifier("CategoryCardViewHStack")
        }
    }
}

#if !TESTING
struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let categories = CategoryList().categories
            
            store.dispatch(.setCategories(categories))
            
            return store
        }()
        
        CategoryListView()
            .environmentObject(previewStore)
    }
}
#endif
