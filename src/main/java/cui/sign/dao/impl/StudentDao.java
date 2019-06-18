package cui.sign.dao.impl;

import cui.sign.domain.Admin;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;

import java.util.List;

public interface StudentDao {
    public Student findByStuId(String StuId);
    public Student insertStudent(String StuId,String StuName,String Sex,String ClassId,String Tel);
    public Student updataStudent(String StuId,String StuName,String Sex,String ClassId,String Tel);
    public List<Student> selectStudent(Integer index,Integer max);
    public List<Student> selectStudentLikeStuName(Integer index,Integer max,String stuName);
    public Student deleteStudent(Student student);
    public int countStudent();
}
