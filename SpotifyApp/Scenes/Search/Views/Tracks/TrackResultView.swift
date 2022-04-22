import SwiftUI

struct TrackResultView: View {
    let topInset: CGFloat

    @Binding
    var tracks: [SearchModel.Track]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: .zero) {
                ForEach(tracks) { track in
                    TrackResultRow(track: track)
                        .frame(height: 80)
                }
            }
            .padding(.top, topInset)
        }
    }
}

struct TrackResultView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            TrackResultView(
                topInset: 0,
                tracks: .constant([
                    SearchModel.Track(
                        id: "6deiaArbeoqp1xPEGdEKp1",
                        name: "Can't Stop",
                        artist: "Red Hot Chili Peppers",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e02de1af2785a83cc660155a0c4"
                    ),
                    SearchModel.Track(
                        id: "6deiaArbeoqp1xPEGdEKp1qwe",
                        name: "Can't Stop",
                        artist: "Red Hot Chili Peppers",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e02de1af2785a83cc660155a0c4"
                    ),
                    SearchModel.Track(
                        id: "6deiaArbeoqp1xPEGdEKp1asd",
                        name: "Can't Stop",
                        artist: "Red Hot Chili Peppers",
                        imageUrl: "https://i.scdn.co/image/ab67616d00001e02de1af2785a83cc660155a0c4"
                    )
                ])
            )
        }
    }
}
