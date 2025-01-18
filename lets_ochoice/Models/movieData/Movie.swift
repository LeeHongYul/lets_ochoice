import UIKit
// Movie 모델
struct Movie {
    let title: String        // 영화 제목
    let author: String       // 작가 (감독)
    let synopsis: String     // 간단한 줄거리
    let posterImageURL: String // 포스터 이미지
}
//
//
//private let collectionMovieData: [Movie] = [
//        Movie(title: "Inception",
//              author: "Christopher Nolan",
//              synopsis: "A mind-bending thriller that delves into the world of dreams.",
//              posterImage: UIImage(named: "inceptionPoster") ?? UIImage()),
//        
//        Movie(title: "The Dark Knight",
//              author: "Christopher Nolan",
//              synopsis: "Batman faces off against the Joker in this action-packed thriller.",
//              posterImage: UIImage(named: "darkKnightPoster") ?? UIImage()),
//        
//        Movie(title: "The Shawshank Redemption",
//              author: "Frank Darabont",
//              synopsis: "Two imprisoned men form a deep bond over many years in this drama.",
//              posterImage: UIImage(named: "shawshankPoster") ?? UIImage()),
//        
//        Movie(title: "The Matrix",
//              author: "The Wachowskis",
//              synopsis: "A computer hacker learns about the true nature of reality.",
//              posterImage: UIImage(named: "matrixPoster") ?? UIImage()),
//        
//        Movie(title: "Interstellar",
//              author: "Christopher Nolan",
//              synopsis: "A team of astronauts travel through a wormhole in search of a new home for humanity.",
//              posterImage: UIImage(named: "interstellarPoster") ?? UIImage())
//    ]
