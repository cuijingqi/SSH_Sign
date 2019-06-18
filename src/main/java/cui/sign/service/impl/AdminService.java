package cui.sign.service.impl;

import cui.sign.domain.Admin;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.domain.TimeLimit;

import java.util.Date;
import java.util.List;

public interface AdminService {
    public boolean login(String username,String password);
    public TimeLimit findByTLId(String TLId);
    public String insertStudent(Student student);
    public String insertAdmin(Admin admin);
    public String insertTimeLimit(TimeLimit timeLimit,String blank,String count);
    public String updataStudent(Student student);
    public String updataAdmin(Admin admin);
    public String updataTimeLimit(TimeLimit timeLimit);
    public List<Student> selectStudent(String index,String max,String stuName);
    public List<Admin> selectAdmin(String index,String max,String competence,String name);
    public List<TimeLimit> selectTimeLimit(String index, String max, Date date);
    public List<Sign> selectSignByTLId(String TLId);
    public List<Sign> selectSignByStuId(String stuId);
    public List<Student> selectStudentByTLId(String TLId);
    public int numPages(String max,String table,String competence);
    public int signCount(String stuId);
    public String deleteByStuId(String stuId);
    public String deleteByAId(String AId);
    public String deleteBySignId(String SignId);
    public String deleteByTLId(String TLId);
    public String deleteByTLIdAndStuId(String TLId,String StuId);
}
