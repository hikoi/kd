package welink.user

import org.grails.databinding.BindingFormat

/**
 *
 */
class Agent {
    static mapping = {
         table 'agent'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'agentId'
         agentNo column: "agentNo"
    }
    Integer agentid
    String name
    String domain
    String weixin
    Byte star
    Long startime
    Long endtime
    Integer baned
    Integer parentId
    String password
    Integer qty
    String area
    String wangwang
    String snNo
    String addTime
    String snDevice
    String dailidanwei
    String qq
    String agentNo
    String renzhenma
    String cardno
    String tel
    String pro
    Integer tbao
    String taobaourl
    String taobaoid
    Byte stat
    java.math.BigDecimal price
    String agentcode
    String province
    String city
    String county
    String address
    String payimg
    String rejectNote
    String alterNote

    //一对一
    Agent parentAgent
    //授权书,一对多
    static hasMany = [authAgentRelation: AuthAgentRelation]
    static fetchMode = [authAgentRelation:'lazy']

    static transients = ["authAgentRelation", "parentAgent"]
    static constraints = {
    }
    String toString() {
        return "${agentid}" 
    }
}
