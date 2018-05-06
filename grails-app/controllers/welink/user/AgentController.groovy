package welink.user

import com.upyun.UpYun
import grails.orm.PagedResultList
import grails.transaction.Transactional
import org.apache.shiro.SecurityUtils

import java.awt.Color
import java.text.SimpleDateFormat

/**
 * 代理控制器
 */
@Transactional(readOnly = true)
class AgentController {
    //首页的代理商三个统计
    def pageIndex = {
        def a = Agent.createCriteria()
        //有效代理总数
        def hql1 = "SELECT COUNT(*)FROM Agent WHERE stat=:stat"
        def validCount = Agent.executeQuery(hql1,["stat":1 as byte])
        //待审核
        def hql2 = "SELECT COUNT(*)FROM Agent WHERE stat in(:one , :two)"
        def stayCount = Agent.executeQuery(hql2,["one": 0 as byte, "two": -2 as byte])
        //总代理数
        def allCount = a.count {
        }
        def data = "{\"validCount\":" + validCount[0] +",\"stayCount\":" + stayCount[0] +",\"allCount\":" + allCount + "}"

        render data
    }
    /**
     * 代理商列表和待审核代理商列表
     */
    def index = {
        //搜索的条件
        def searchStar = (params.star ? Byte.parseByte(params.star) : 0)
        String searchField = params.searchField
        def searchValue = params.searchValue
        Integer aid = params.int("aid")
        //待审核代理商列表
        def audit = params.audit

        def a = AgentVo.createCriteria()
        PagedResultList pagedResultList = a.list(max: 10, offset: params.offset ?: 0) {
            if(!aid){//不是点击下级按钮过来
                if(audit){//待审核代理商列表
                    notEqual('stat', 1 as byte)
                }else {//代理商列表
                    eq('stat', 1 as byte)
                }
            }
            if (searchStar) eq("star", searchStar as byte)
            if (searchValue) eq(searchField, searchValue)
            //下级
            if (aid) eq("parentId", aid)
            order("star", "asc")
        }
        pagedResultList.each {//代理商列表数据封装
            //级别
            it.starStr = AgentStar.findById(it.star?:1).name
            //状态
            it.statStr = status(it.stat)
            //推荐人
            def parentName = (Agent.get(it?.parentId))?.name
            it.parentName = parentName != "罗单单" ? parentName : "酷兜公司"
            //到期时间
            Long timestamp = ((Long) it.endtime) * 1000
            Date date = new Date(timestamp)

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
            def endtimeStr = sdf.format(date)
            it.endtimeStr = endtimeStr
            //下级个数
            it.nextAgentNum = Agent.countByParentId(it.agentid)
        }
        def agentStars = AgentStar.findAll()
        return [
                parentAgent         : Agent.findByAgentid(aid),
                total       : pagedResultList.totalCount,
                params      : params,
                agentList   : pagedResultList,
                agentStars  : agentStars,
                searchStar  : searchStar,
                searchF : searchField,
                searchValue : searchValue
        ]

    }
    /**
     * 处理代理商列表的状态
     */
    def status(stat) {
        def statStr = null
        switch(stat){
            case 1:
                statStr = "已审核"
                break
            case 0:
                statStr = "待总部审核"
                break
            case -1:
                statStr = "黑名单"
                break
            case -2:
                statStr = "待上级审核"
                break
            case -3:
                statStr = "驳回修改"
                break
        }
        return statStr
    }
    /**
     * 跳转到代理商添加或修改页面
     */
    def agentCreateOrUpdateUI(Integer aid) {
        def agentStars = AgentStar.findAll()
        def authBooks = AuthBook.findAll()
        if (aid){
            //该代理商的授权书
            def agent = Agent.findById(aid)
            def list = AuthAgentRelation.findAllByAgentIdAndIsShow(aid, 1 as byte)
            agent.authAgentRelation = list
            return [
                    agent : agent,
                    agentStars: agentStars,
                    authBooks : authBooks
            ]
        }
        //产生随机授权编号
        def agentNo = "KUDOU"+(((long)System.currentTimeMillis()/1000)+200000000+new Random().nextInt(1000000)+Agent.count)
        return [
                agentNo   : agentNo,
                agentStars: agentStars,
                authBooks : authBooks
        ]
    }
    /**
     * 添加或修改代理商
     */
    @Transactional
    def createOrUpdateAgent(Agent agentForm) {
        //字段处理
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        agentForm.startime = (sdf.parse(params.startime).getTime())/1000//开始时间
        agentForm.endtime = (sdf.parse(params.endtime).getTime())/1000//结束时间
        String userName = SecurityUtils.getSubject().getPrincipal() //获取当前登录用户
        agentForm.parentId = Agent.findByName(userName) //获取当前登录用户的id
        agentForm.baned = 0

        //密码加密
        agentForm.password = UpYun.md5(agentForm.password)
        //代理商保存
        def agent = agentForm.save()

        //授权书保存
        def authIds = params.list("authAgentRelation")
        if(agent?.id){
            for(i in 1..AuthBook.count){
                AuthAgentRelation aar = AuthAgentRelation.findByAgentIdAndAuthId(agent.id, i)
                if (!aar && authIds?.contains(i+"")) {// 前台有传,数据库没有
                    aar = new AuthAgentRelation()
                    aar.agentId = agent.id
                    aar.authId = i
                    aar.authLv = 2 as byte
                }
                aar?.isShow = (authIds.contains(i)?0:1) as byte
                aar?.save()
            }
        }
        redirect([uri: "/agent/index"])
        /*Long id = params.long("id")
        Agent agent = agentForm
        if (id) {//修改
            agent = Agent.findById(id)
        }
        def authBooks = params.list("authBooks")*/
    }
    /**
     * 验证微信是否存在
     */
    def verificationWeixin() {
        def agent = Agent.findByWeixin(params.weixin)
        if (agent){
            render "该微信号已经存在,请重新输入"
        }
    }
    /**
     * 查看证书
     */
    def showAuthBook() {
        /*def id = params.int("aid")
        def agent = Agent.findByAgentid(id)
        def authAgentRelations = AuthAgentRelation.findAllByAgentId(id)
        //AuthBook.findByAuthLv(authAgentRelation.authLv)
        authAgentRelations.each {
            def AuthBook = AuthBook.findById(it.authId)//byte自动转int
        }*/

        //给图片添加文字
        String filePath = servletContext.getRealPath("/") + "/Uploads/Authbook/2017-04-01/58df4b0b79649.jpeg"                 //源文件
        String content = ""                       //添加的文字
        Color contentColor = new Color(0f, 0f, 0f)  //文字颜色
        float qualNum = 1f                                  //图片质量
        String targetFile = servletContext.getRealPath("/") + "/myFile/"              //目标路径
        int x = -120                                      //文字距离图片中心横向偏移
        int y = -50                                       //文字距离图片中心纵向偏移
        /*ImageHandleHelper.drawStringForImage(filePath, content, contentColor, qualNum, targetFile, x, y)*/
    }
    /**
     * 删除代理商
     */
    @Transactional
    def deleteAgent() {
        Long aid = params.long("aid")
        Agent agent = Agent.findById(aid)
        // 如果这个角色存在，首先删除这个角色对应的权限，然后再删除角色
        if (agent) {
            agent.stat = -1 as byte
            agent.save(failOnError: true, flush: true)
            render("删除成功")
            return
        }
    }
}