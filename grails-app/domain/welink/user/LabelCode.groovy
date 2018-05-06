package welink.user
/**
 *  防伪管理
 */
class LabelCode {
    static mapping = {
         table 'label_code'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Long id
    String maxCode
    String middleCode
    String minCode
    String securityCode
    Byte minNumber
    Byte middleNumber
    Boolean status
    Date addTime

    static constraints = {
        id(max: 9223372036854775807L)
        maxCode(size: 0..13)
        middleCode(size: 0..13)
        minCode(size: 0..13)
        securityCode(size: 0..17)
        minNumber(nullable: true)
        middleNumber(nullable: true)
        status(nullable: true)
        addTime(nullable: true)
    }
    String toString() {
        return "${id}" 
    }
}
