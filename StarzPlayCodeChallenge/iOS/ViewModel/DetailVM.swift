//
//  TVDetailVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

@Observable
final class DetailVM {

    private let detailService: MediaDetailService
    private let id: Int

    private(set) var detail: MediaDetail?
    private(set) var loading = false
    var showError = false
    var errorMessage = ""

     deinit {
         #if DEBUG
         print("✅ DEALLOCATE: \(self)")
         #endif
     }
     
    init(detailService: MediaDetailService, id: Int) {
        self.detailService = detailService
        self.id = id
    }
}
// MARK: - Movie Detail Api
extension DetailVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
     func getDetail(_ Id: Int = 0) async {
          guard !loading else { return }
          defer { loading = false }
          loading = true
          await handleDetailResult(detailService.getDetails(from: id))
     }
    
     private func handleDetailResult(_ result: Result<MediaDetail, RequestError>) async {
        switch result {
        case let .success(fetchedDetail):
            self.detail = fetchedDetail
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
     
     func getVideos() -> [Video]? {
         switch detail {
         case let tvDetail as TvDetail:
             return tvDetail.getVideos().flatMap { $0.isEmpty ? nil : $0 }
         case let movieDetail as MovieDetail:
              return movieDetail.getVideos().flatMap { $0.isEmpty ? nil : $0 }
         default:
             return nil
         }
     }
}
