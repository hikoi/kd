package welink.user
/**
 * The AgentStar entity.
 *
 * @author    
 *
 *
 */
class AgentStar {
    static mapping = {
         table 'agent_star'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }
    Byte id
    String name

    static constraints = {
    }
    String toString() {
        return "${id}" 
    }
}
