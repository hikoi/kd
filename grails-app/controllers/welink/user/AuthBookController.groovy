package welink.user

import grails.orm.PagedResultList
import grails.transaction.Transactional

import java.text.SimpleDateFormat

@Transactional(readOnly = true)
class AuthBookController {

    def index(String name) {

        def ab = AuthBook.createCriteria()
        def condition = name ? ("%"+name+"%"): "%"

        PagedResultList pagedResultList = ab.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            like("name", condition)
        }
        return [
                total    : pagedResultList.totalCount,
                authBookList: pagedResultList,
                params      : params
        ]

    }
    /**
     * 跳转到授权书添加、修改页面
     */
    def authBookCreateHtml(Integer aid) {
        if (aid){
            def authBook = AuthBook.findById(aid)
            return [authBook : authBook]
        }
    }
    /**
     * 添加、修改授权书
     */
    @Transactional
    def createOrUpdateAutoBook(AuthBook ab){
        withForm {
            Long id = params.long("id")
            def f = request.getFile("images") //表单中type="file"的input的name属性值
            AuthBook authBook = new AuthBook(id: id, name: ab.name)
            if (id){//修改
                authBook = AuthBook.findById(id as long)
                authBook.name = ab.name
            }
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
                def imgPath = "Uploads/Authbook/"+now+"/"+System.currentTimeMillis()+new Random().nextInt(100)+fileType
                File file = new File(dirPath + imgPath)
                if(!file.exists()){
                    file.mkdirs()
                }
                f.transferTo(file)//上传文件
                authBook.imgPath = imgPath
                //def fileType = fileName.substring(fileName.indexOf("."))//获取文件类型
            }
            //保存数据到数据库
            authBook.authLv = 2
            authBook.save(failOnError: true, flush: true)
            redirect(uri: '/authBook/index')
        }.invalidToken {
            response.status = 405
        }
    }

    def save = {

        AuthBook a = new AuthBook(id:10,name:"我是名字")
        a.save()
    }
}
