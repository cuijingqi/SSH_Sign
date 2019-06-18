package cui.sign.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;

public class Sign {
    private Long SignId;
    private String IP;
    private Date Time;
    @JsonBackReference
    private Student student;

    public Sign() {
    }

    public Sign(Long signId, String IP, Date time, Student student) {
        this.SignId = signId;
        this.IP = IP;
        this.Time = time;
        this.student = student;
    }

    public String getIP() {
        return this.IP;
    }

    public void setIP(String IP) {
        this.IP = IP;
    }

    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    public Date getTime() {
        return this.Time;
    }

    public void setTime(Date time) {
        this.Time = time;
    }

    public Long getSignId() {
        return this.SignId;
    }

    public void setSignId(Long signId) {
        this.SignId = signId;
    }

    public Student getStudent() {
        return this.student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String toString() {
        return "Sign{SignId=" + this.SignId + ", IP=" + this.IP + ", Time=" + this.Time + '}';
    }
}
