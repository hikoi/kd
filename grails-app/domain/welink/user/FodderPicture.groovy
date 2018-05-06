package welink.user
/**
 * The FodderPicture entity.
 *
 * @author    
 *
 *
 */
class FodderPicture {
    static mapping = {
         table 'fodder_picture'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Integer id
    Integer cateId
    Integer artId
    String original
    String shrink
    Byte isShow
    Byte sort
    Integer addTime

    static constraints = {
    }
    String toString() {
        return "${id}" 
    }
}
