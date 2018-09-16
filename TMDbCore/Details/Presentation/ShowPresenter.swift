//
//  ShowPresenter.swift
//  TMDbCore
//
//  Created by Juan Foncuberta on 15/9/18.
//  Copyright © 2018 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

final class ShowPresenter: DetailPresenter {
    private let repository: ShowRepositoryProtocol
    private let detailNavigator: DetailNavigator
    private let identifier: Int64
    private let disposeBag = DisposeBag()
    
    weak var view: DetailView?
    
    init(repository: ShowRepositoryProtocol, identifier: Int64,detailNavigator:DetailNavigator) {
        self.repository = repository
        self.identifier = identifier
        self.detailNavigator = detailNavigator
    }
    
    func didLoad() {
        view?.setLoading(true)

        repository.show(withIdentifier: identifier)
            .map { [weak self] show in
                self?.detailSections(for: show) ?? []
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] sections in
                self?.view?.update(with: sections)
                }, onDisposed: { [weak self] in
                    self?.view?.setLoading(false)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelect(item: PosterStripItem) {
        detailNavigator.navigateToPerson(withIdentifier: item.identifier)
    }
    
    private func detailSections(for show: ShowDetail) -> [DetailSection] {
        print("juan detailSections")
        var detailSections: [DetailSection] = [
            .header(DetailHeader(show: show))
        ]
        
        if let overview = show.overview {
            detailSections.append(.about(title: "Overview", detail: overview))
        }
        
        let items = show.credits?.cast.map { PosterStripItem(castMember: $0) }
        
        if let items = items {
            detailSections.append(.posterStrip(title: "Cast", items: items))
        }
        
        return detailSections
    }
}

