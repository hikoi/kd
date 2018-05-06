package welink.user
/**
 * 出库记录里的发货详情
 */
class OrderGoods {
    static mapping = {
         table 'order_goods'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Long id
    String orderSn
    String code
    Boolean codeType
    Integer goodsId
    String goodsName
    Byte goodsNumber
    java.math.BigDecimal marketPrice
    java.math.BigDecimal goodsPrice
    Boolean isGift
    Date addTime

    //封装商品图片路径的属性
    String goodsPic
    static transients = ["goodsPic"]

    static constraints = {
        id(max: 9223372036854775807L)
        orderSn(size: 1..22, blank: false)
        code(size: 0..20)
        codeType(nullable: true)
        goodsId(max: 2147483647)
        goodsName(size: 0..225)
        goodsNumber(nullable: true)
        marketPrice(nullable: true)
        goodsPrice(nullable: true)
        isGift(nullable: true)
        addTime(nullable: true)
    }
    String toString() {
        return "${id}" 
    }
}
