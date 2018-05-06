package welink.user
/**
 * The Goods entity.
 *
 * @author    
 *
 *
 */
class Goods {
    static mapping = {
         table 'goods'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Integer id
    String code
    String title
    java.math.BigDecimal price
    java.math.BigDecimal price1
    java.math.BigDecimal price2
    java.math.BigDecimal price3
    java.math.BigDecimal price4
    java.math.BigDecimal markPrice
    java.math.BigDecimal stockPrice
    String specs
    Integer stock
    String pic
    String descs
    Byte authId
    Byte authLv
    Date addTime

    static constraints = {
    }
    String toString() {
        return "${id}" 
    }
}
