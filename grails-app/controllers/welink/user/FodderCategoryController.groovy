package welink.user

import grails.orm.PagedResultList

/**
 * 素材分类控制器
 */
class FodderCategoryController {
    /**
     * 素材分类
     */
    def index() {
        // 查看下级
        def pid = params.int("pid")
        def fodderCategory = FodderCategory.createCriteria()
        PagedResultList pagedResultList = fodderCategory.list(max: 10, offset: params.offset ?: 0) {
            if(pid){//pid不为空就是查看下级
                eq("pid", pid)
            }else{
                eq("cateLv",1 as byte)
            }
            order("sort", "asc")
        }
        if(pid){//pid不为空就是查看下级
            pagedResultList.each {
                def fc = FodderCategory.findById(pid)
                it.parentTitle = fc.title
            }
        }else{
            pagedResultList.each {
                it.junior = FodderCategory.countByPid(it.id)
                it.parentTitle = "没有上级"
            }
        }
        return [
                pid             : pid,
                params          : params,
                total           : pagedResultList.totalCount,
                pagedResultList : pagedResultList
        ]
    }
    /**
     * 跳转素材类型添加或更新页面
     */
    def createOrUpdateUI(){
        def id = params.int("id")//有id就是修改
        def pid = params.int("pid")//有pid就是下级操作
        if(id){//有id就是修改
            def fodderCategory = FodderCategory.findById(id)
            return [
                    fodderCategory : fodderCategory
            ]
        }else if(!pid){//一级添加
            //SELECT * FROM fodder_category WHERE pid=0 AND is_show=0
            def fodderCategorys = FodderCategory.findAllByPidAndIsShow(0, 1 as byte)
            return [
                    fodderCategorys : fodderCategorys
            ]
        }
    }
}
