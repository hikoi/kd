package welink.user

import grails.orm.PagedResultList

class FodderArticleController {

    /**
     * 根据文章搜索
     */
    def index(){
        //搜索字段
        def cateLv2Selected = params.int("cateLv2")
        if(params.cid){//从素材分类列表点击查看素材按钮过来
            cateLv2Selected = params.int("cid")
        }
        def isShowSelected = params.byte("isShow")

        def fodderArticle = FodderArticle.createCriteria()
        PagedResultList pagedResultList = fodderArticle.list(max: 12, offset: params.offset ?: 0) {
            order("id", "desc")
            if(cateLv2Selected) eq("cateId", cateLv2Selected)
            if(isShowSelected || isShowSelected == 0) eq("isShow", isShowSelected)
        }
        pagedResultList.each {
            it.cateName = FodderCategory.findById(it.cateId).title//封装分类名称
        }
        // 一级分类
        def cateLv1s = FodderCategory.findAllByCateLv(1 as byte)
        return  [
                cateLv1s        : cateLv1s,
                params          : params,
                total           : pagedResultList.totalCount,
                pagedResultList : pagedResultList
        ]
    }
}
