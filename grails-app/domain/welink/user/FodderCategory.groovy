package welink.user
/**
 * The FodderCategory entity.
 *
 * @author    
 *
 *
 */
class FodderCategory {
    static mapping = {
         table 'fodder_category'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Integer id
    String title
    String headImg
    Integer pid
    Byte cateLv
    Byte cateType
    Byte isShow
    Byte sort
    Date addTime

    Integer junior//下级个数
    String parentTitle//上级分类名字
    static transients = ["junior","parentTitle"]

    static constraints = {
    }
    String toString() {
        return "${id}" 
    }
}
