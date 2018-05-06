package welink.user

import grails.orm.PagedResultList
import grails.transaction.Transactional

/**
 * 出库管理控制器
 */
@Transactional(readOnly = true)
class OrderInfoController {
    /**
     * 出库记录
     */
    def index() {
        //搜索字段
        def star = params.byte("star")
        String searchField = params.searchField
        String searchValue = params.searchValue
        //搜索字段是条形码
        def og = OrderGoods.findByCode(searchValue)
        if("code" == searchField && og){
            searchField = "orderSn"
            searchValue = og.orderSn
        }
        def orderInfo = OrderInfo.createCriteria()
        PagedResultList pagedResultList = orderInfo.list(max: 10, offset: params.offset ?: 0) {
            if(star || star==0) eq("agentLv", star)
            if(searchValue) eq(searchField, searchValue)
            order("orderSn", "desc")
        }
        return [
                agentStars      : AgentStar.findAll(),
                star            : star,
                searchField     : searchField,
                searchValue     : searchValue,
                params          : params,
                total           : pagedResultList.totalCount,
                pagedResultList : pagedResultList
        ]
    }
}
