package welink.user
/**
 * The AuthAgentRelation entity.
 *
 * @author    
 *
 *
 */
class AuthAgentRelation {
    static mapping = {
         table 'auth_agent_relation'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity'
    }
    Long id
    Byte authId
    Integer agentId
    Byte authLv
    Byte isShow
    Date addTime

    static constraints = {
    }
    String toString() {
        return "${id}"
    }
}
