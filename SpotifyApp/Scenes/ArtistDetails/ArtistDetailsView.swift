import SwiftUI

struct ArtistDetailsView: View {
    let artist: SearchModel.Artist

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            Text("Artist: \(artist.name)")
                .foregroundColor(.textPrimary)
        }
    }
}

struct ArtistDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailsView(artist: SearchModel.Artist(id: "", name: "", imageUrl: ""))
    }
}
