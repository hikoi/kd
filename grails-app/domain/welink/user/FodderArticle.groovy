package welink.user
/**
 * The FodderArticle entity.
 *
 * @author    
 *
 *
 */
class FodderArticle {
    static mapping = {
         table 'fodder_article'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Integer id
    Integer cateId
    String title
    String headImg
    Integer likes
    Byte isShow
    Integer reads
    String content
    Byte sort
    Long addTime

    String cateName//分类名称
    static transients = ["cateName"]

    static constraints = {
    }
    String toString() {
        return "${id}"
    }
}
