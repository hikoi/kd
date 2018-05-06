package welink.user
class AuthBook {
    static mapping = {
         table 'auth_book'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         //id generator:'identity', column:'id'
    }
    Integer id
    String imgPath
    String name
    Byte authLv
    //Byte isShow
    Date addTime

    static constraints = {
    }
    String toString() {
        return "${id}" 
    }
}
