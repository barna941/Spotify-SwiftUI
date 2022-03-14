import SwiftUI

struct SearchView<Router: SearchRouting, ViewModel: SearchViewModelProtocol>: View where Router.Route == SearchRoute {
    let router: Router

    @StateObject
    var viewModel: ViewModel

    private let topInset: CGFloat = 104

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea()

                ScrollView {
                    LazyVStack {
                        ForEach(0..<100) { item in
//                            Text("Lorem ipsum dolor sit amet")
                            Image(systemName: "music.note.list")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color.textPrimary)
                        }
                    }
                    .padding(.top, topInset)
                }

                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                    .frame(height: topInset)

                VStack {
                    SearchTextFieldView(searchText: $viewModel.searchText)
                    SearchResultSelectorView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            router: SearchRouter(),
            viewModel: SearchViewModel(interactor: DependencyProvider.resolver.resolve(SearchInteractorProtocol.self)!)
        )
    }
}
