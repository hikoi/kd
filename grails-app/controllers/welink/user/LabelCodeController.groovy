package welink.user

import grails.orm.PagedResultList
import grails.transaction.Transactional

/**
 * 防伪管理控制器
 */
@Transactional(readOnly = true)
class LabelCodeController {
    //标签列表
    def index() {
        //搜索字段
        def codeType = params.codeType
        def codeValue = params.codeValue
        def status = params.status
        def minNumber = params.minNumber
        if(minNumber){
            minNumber = Byte.valueOf(minNumber)
        }

        def lc = LabelCode.createCriteria()
        PagedResultList pagedResultList = lc.list(max: 15, offset: params.offset ?: 0) {
            if(codeValue) eq(codeType, codeValue)
            if(status == "0" || status == "1") eq("status", status == "1"?true:false)
            if(minNumber) eq("minNumber", minNumber)
            order("status","asc")
        }
        return [
                params          : params,
                total           : pagedResultList.totalCount,
                pagedResultList : pagedResultList
        ]

    }
}
