package cui.sign.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

public class Admin {
    private Integer AId;
    private String Name;
    private String UserName;
    private String Password;
    private Integer Competence;
    private String Email;
    private String Tel;
    private Date CreateDate;

    public Admin() {
    }

    public Admin(Integer AId, String name, String userName, String password, String email, String tel) {
        this.AId = AId;
        Name = name;
        UserName = userName;
        Password = password;
        Email = email;
        Tel = tel;
    }

    public Admin(String name, String userName, String password, Integer competence, String email, String tel, Date createDate) {
        Name = name;
        UserName = userName;
        Password = password;
        Competence = competence;
        Email = email;
        Tel = tel;
        CreateDate = createDate;
    }

    public Admin(Integer AId, String name, String userName, String password, Integer competence, String email, String tel, Date createDate) {
        this.AId = AId;
        Name = name;
        UserName = userName;
        Password = password;
        Competence = competence;
        Email = email;
        Tel = tel;
        CreateDate = createDate;
    }

    public Integer getAId() {
        return AId;
    }

    public void setAId(Integer aId) {
        this.AId = aId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }
//    @Column(updatable=false)  字段不更新
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")//jackson序列化时间格式
    public Date getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(Date createDate) {
        CreateDate = createDate;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getTel() {
        return Tel;
    }

    public void setTel(String tel) {
        Tel = tel;
    }

    public Integer getCompetence() {
        return Competence;
    }

    public void setCompetence(Integer competence) {
        Competence = competence;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "AId=" + AId +
                ", Name='" + Name + '\'' +
                ", UserName='" + UserName + '\'' +
                ", Password='" + Password + '\'' +
                ", Competence=" + Competence +
                ", Email='" + Email + '\'' +
                ", Tel='" + Tel + '\'' +
                ", CreateDate=" + CreateDate +
                '}';
    }
}
