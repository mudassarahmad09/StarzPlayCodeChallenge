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
    @ObservationIgnored var errorMessage = ""

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
        loading = true
        await handleDetailResult(detailService.getDetails(from: id))
        loading = false
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
}
