//
//  PersonDetailVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 10/08/2023.
//

import SwiftUI
import MyApiLibrary

@Observable
final class PersonDetailVM {

    private let detailService: PersonDetailService
    private let id: Int

    private(set) var detail: PersonInfo?
    private(set) var loading = false
    var showError = false
    @ObservationIgnored var errorMessage = ""

    init(detailService: PersonDetailService, id: Int) {
        self.detailService = detailService
        self.id = id
    }
}
// MARK: - Movie Detail Api
extension PersonDetailVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func getDetail(_ Id: Int = 0) async {
        loading = true
        await handleDetailResult(detailService.getDetails(from: id))
        loading = false
    }
    
    private func handleDetailResult(_ result: Result<PersonInfo, RequestError>) async {
        switch result {
        case let .success(fetchedDetail):
            self.detail = fetchedDetail
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
}

