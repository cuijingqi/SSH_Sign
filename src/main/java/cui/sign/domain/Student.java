package cui.sign.domain;

import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import cui.sign.domain.Sign;

public class Student {
    private String StuId;
    private String StuName;
    private String Sex;
    private String ClassId;
    private String Tel;
    @JsonManagedReference
    private Set<Sign> signs=new HashSet<>();

    public Student() {
    }

    public Student(String stuId, String stuName, String sex, String classId, String tel) {
        StuId = stuId;
        StuName = stuName;
        Sex = sex;
        ClassId = classId;
        Tel = tel;
    }

    public Student(String stuId, String stuName, String sex, String classId, String tel, Set<Sign> signs) {
        StuId = stuId;
        StuName = stuName;
        Sex = sex;
        ClassId = classId;
        Tel = tel;
        this.signs = signs;
    }

    public String getStuId() {
        return StuId;
    }

    public void setStuId(String stuId) {
        StuId = stuId;
    }

    public String getStuName() {
        return StuName;
    }

    public void setStuName(String stuName) {
        StuName = stuName;
    }

    public String getClassId() {
        return ClassId;
    }

    public void setClassId(String classId) {
        ClassId = classId;
    }

    public String getTel() {
        return Tel;
    }

    public void setTel(String tel) {
        Tel = tel;
    }

    public String getSex() {
        return Sex;
    }

    public void setSex(String sex) {
        Sex = sex;
    }

    public Set<Sign> getSigns() {
        return signs;
    }

    public void setSigns(Set<Sign> signs) {
        this.signs = signs;
    }


    @Override
    public String toString() {
        return "Student{" +
                "StuId=" + StuId +
                ", StuName='" + StuName + '\'' +
                ", Sex='" + Sex + '\'' +
                ", ClassId='" + ClassId + '\'' +
                ", Tel='" + Tel + '\'' +
                '}';
    }
}
