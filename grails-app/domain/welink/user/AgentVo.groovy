package welink.user


class AgentVo {
    static mapping = {
        table 'agent'
        // version is set to false, because this isn't available by default for legacy databases
        version false
        id generator:'identity', column:'agentId'
        agentNo column: "agentNo"
    }
    Integer agentid
    String name
    String tel
    String weixin
    Byte star
    String agentNo
    String starStr   //星级的中文
    Byte stat
    String statStr   //状态的中文
    Integer parentId
    String parentName //推荐人
    Integer endtime
    String endtimeStr //格式化的日期
    Integer nextAgentNum  //下级的个数
    static transients = ["starStr","statStr","parentName","endtimeStr","nextAgentNum"]

    static constraints = {
    }
    String toString() {
        return "${agentid}"
    }
}
