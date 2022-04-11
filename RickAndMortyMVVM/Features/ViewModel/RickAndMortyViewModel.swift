//
//  RickAndMortyViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Machine on 11.04.2022.
//

import Foundation

protocol IRickAndMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickAndMortyCharacters: [Result] { get set }
    var rickyAndMortyServices: IRickAndMortyService { get }

    var rickAndMortyOutput: RickAndMortyOutput? { get }
    
    func setDelegate(output: RickAndMortyOutput)

}

final class RickAndMortyViewModel: IRickAndMortyViewModel {
    
    var rickAndMortyOutput: RickAndMortyOutput?
    
    func setDelegate(output: RickAndMortyOutput) {
        rickAndMortyOutput = output
    }
    
    
    var rickAndMortyCharacters: [Result] = []
    private var isLoading = false
    
    var rickyAndMortyServices: IRickAndMortyService = RickMortyService()
    
    init() {
        rickyAndMortyServices = RickMortyService()
    }
    
    func fetchItems() {
        rickyAndMortyServices.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickAndMortyCharacters = response ?? []
            self?.rickAndMortyOutput?.saveDatas(values: self?.rickAndMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickAndMortyOutput?.changeLoading(isLoad: isLoading)
    }
    

    
    
}
