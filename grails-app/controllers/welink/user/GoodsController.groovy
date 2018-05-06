package welink.user

import grails.orm.PagedResultList
import grails.transaction.Transactional

import java.text.SimpleDateFormat

/**
 * 商品管理控制器
 */
@Transactional(readOnly = true)
class GoodsController {
    //商品列表
    def index() {
        //搜索字段
        def code = params.code
        def title = params.title

        def goods = Goods.createCriteria()
        PagedResultList pagedResultList = goods.list(max: 10, offset: params.offset ?: 0) {
            if(code) eq("code", code)
            if(title) like("title", "%" + title + "%")
        }
        return [
                prams           : params,
                total           : pagedResultList.totalCount,
                pagedResultList : pagedResultList
        ]
    }
    //跳转到商品添加和商品修改页面
    def goodsCreateOrUpdateUI() {
        def authBooks = AuthBook.findAll()
        if(params.goodsId){//商品修改
            def goods = Goods.findById(params.int("goodsId"))
            def picList = goods.pic.split(";")
            return [
                    picList     : picList,
                    goods       : goods,
                    authBooks   : authBooks
            ]
        }
        return [
                authBooks   : authBooks
        ]
    }
    //保存或修改商品
    @Transactional
    def saveOrUpdate(Goods goods){
        //处理规格
        if(!goods.specs) goods.specs = ""
        def f = request.getFile("images") //表单中type="file"的input的name属性值
        def fileName = f.getOriginalFilename()//获取文件名称
        if(fileName){
            def fileType = null
            if(fileName != null && fileName != ''){
                def beginIndex = fileName.indexOf(".")
                fileType = fileName.substring(beginIndex)//获取文件类型
            }
            //获取项目的全路径
            String dirPath = servletContext.getRealPath("/")
            //File file = new File(dirPath + File.separator + fileName)
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd")
            def now = format.format(new Date())
            def imgPath = "Goods/"+now+"/"+System.currentTimeMillis()+new Random().nextInt(100)+fileType
            File file = new File(dirPath + "Uploads/" + imgPath)
            if(!file.exists()){
                file.mkdirs()
            }
            f.transferTo(file)//上传文件
            goods.pic = imgPath
        }

        goods.save()
        redirect([uri: "/goods/index"])
    }
}
