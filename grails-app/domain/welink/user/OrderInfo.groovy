package welink.user

/**
 * 出库记录
 */
class OrderInfo {
    static mapping = {
         table 'order_info'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Long id
    String orderSn
    Integer memberId
    Integer adminId
    String adminName
    Boolean orderStatus
    Boolean shippingStatus
    Boolean payStatus
    String consignee
    Byte agentLv
    Short country
    Short province
    Short city
    Short district
    String address
    String zipcode
    String tel
    String mobile
    Integer bestTime
    Byte shippingId
    String shippingName
    Byte payId
    String payName
    java.math.BigDecimal shippingFee
    java.math.BigDecimal payFee
    Date addTime
    Integer confirmTime
    Integer payTime
    Integer shippingTime
    Integer collectTime
    String payAccount
    String paySn
    java.math.BigDecimal thirdPay

    String adminNameWeixin//发货人微信封装
    String consigneeWeixin//收货人微信封装
    static transients = ["adminNameWeixin", "consigneeWeixin"]

    static constraints = {
    }
    String toString() {
        return "${id}"
    }
}
