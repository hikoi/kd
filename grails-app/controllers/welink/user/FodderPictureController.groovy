package welink.user

import grails.converters.JSON
import grails.orm.PagedResultList
import org.grails.datastore.mapping.query.api.BuildableCriteria

/**
 * 素材列表控制器
 */
class FodderPictureController {
    /**
     * 素材列表
     */
    def index() {
        //搜索字段
        def cateLv2Selected = params.int("cateLv2")
        if(params.cid){//从素材分类列表点击查看素材按钮过来
            cateLv2Selected = params.int("cid")
        }
        def isShowSelected = params.byte("isShow")

        def fodderPicture = FodderPicture.createCriteria()
        PagedResultList pagedResultList = fodderPicture.list(max: 12, offset: params.offset ?: 0) {
            order("addTime", "desc")
            if(cateLv2Selected) eq("cateId", cateLv2Selected)
            if(isShowSelected || isShowSelected == 0) eq("isShow", isShowSelected)
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
    /**
     * 二级分类
     */
    def selCate() {
        def pid = params.int("pid")//是空的话会不会报错
        Map<String, Object> data = new HashMap<>()
        if(pid){//选择一级分类是存在的
            data.put("status", 1)
            data.put("msg", "")
            def list = FodderCategory.findAllByPid(pid)
            List<Map<String,String>> dataList = new ArrayList<>()
            list.each{
                Map<String, String> fodderCategoryMap = new HashMap<>()
                fodderCategoryMap.put("id", it.id)
                fodderCategoryMap.put("title", it.title)
                fodderCategoryMap.put("cate_type", it.cateType)
                dataList.add(fodderCategoryMap)
            }
            data.put("result", dataList)
        }else {
            data.put("status", 0)
            data.put("msg", "没有你想要的分类")
            data.put("result", "")
        }
        render data as JSON
    }
}
