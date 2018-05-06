package welink.user

import grails.orm.PagedResultList
import grails.transaction.Transactional

/**
 * 出库记录里的发货详情控制器
 */
@Transactional(readOnly = true)
class OrderGoodsController {
    /**
     * 发货详情
     */
    def index() {
        String aid = params.aid
        def orderInfo = OrderInfo.findByOrderSn(aid)
        //发货人的微信
        orderInfo.adminNameWeixin = Agent.findByAgentid(orderInfo.adminId).weixin
        orderInfo.consigneeWeixin = Agent.findByName(orderInfo.consignee).weixin
        def orderGoodsList = OrderGoods.findAllByOrderSn(aid)
        orderGoodsList.each {
            String pic = Goods.findById(it.goodsId).pic
            it.goodsPic = pic
        }
        return [
                orderInfo      : orderInfo,
                orderGoodsList : orderGoodsList
        ]
    }
}
