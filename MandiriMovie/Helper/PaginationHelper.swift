//
//  PaginationHelper.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//


import Foundation

final class PaginationHelper {
    private(set) var currentPage = 1
    private(set) var totalPages  = 1
    private(set) var isFetching  = false

    var canLoadMore: Bool {
        return currentPage <= totalPages && !isFetching
    }

    func startFetching() {
        isFetching = true
    }

    func finishFetching(totalPages: Int) {
        self.totalPages = totalPages
        self.currentPage += 1
        self.isFetching = false
    }

    func failedFetching() {
        isFetching = false
    }

    func reset() {
        currentPage = 1
        totalPages  = 1
        isFetching  = false
    }
}