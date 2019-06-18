package cui.sign.domain;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
public class TimeLimit {
    private Long TLId;
    private Date startTime;
    private Date endTime;

    public TimeLimit() {
    }

    public TimeLimit(Long TLId, Date startTime, Date endTime) {
        this.TLId = TLId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public TimeLimit(Date startTime, Date endTime) {
        this.startTime = startTime;
        this.endTime = endTime;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")//jackson序列化时间格式
    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")//jackson序列化时间格式
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Long getTLId() {
        return TLId;
    }

    public void setTLId(Long TLId) {
        this.TLId = TLId;
    }

    @Override
    public String toString() {
        return "TimeLimit{" +
                "TLId=" + TLId +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}
