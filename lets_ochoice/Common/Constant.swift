//
//  Constant.swift
//  lets_ochoice
//
//  Created by homechoic on 1/18/25.
//
class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    var baseMBSURL: String {
        return "https://dev-mbs.ochoice.co.kr/mbs"
    }
    var basePVSURL: String {
        return "https://dev-pvs.ochoice.co.kr/PVS/api"
    }

}


///mainCategoryList
//final response = await _dio.get(baseUrl, queryParameters: {'terminalKey': token, 'includeRrated': isAdult});
//
//      final bannerList = response.data['categoryList'];
