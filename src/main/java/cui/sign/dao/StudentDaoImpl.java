package cui.sign.dao;

import cui.sign.dao.impl.StudentDao;
import cui.sign.dao.impl.TimeLimitDao;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.utils.IpAddress;
import cui.sign.utils.PageNoUtil;
import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class StudentDaoImpl implements StudentDao {
    HibernateTemplate hibernateTemplate;
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }
    @Override
    public Student findByStuId(String StuId){
        Student student = hibernateTemplate.get(Student.class, StuId);
        System.out.println(student);
        return student;
    }

    @Override
    public Student insertStudent(String StuId, String StuName, String Sex, String ClassId, String Tel) {
        Student student=new Student(StuId,StuName,Sex,ClassId,Tel);
        hibernateTemplate.save(student);
        return student;
    }

    @Override
    public Student updataStudent(String StuId, String StuName, String Sex, String ClassId, String Tel) {
        Student student=new Student(StuId,StuName,Sex,ClassId,Tel);
        hibernateTemplate.saveOrUpdate(student);
        return student;
    }

    @Override
    public List<Student> selectStudent(Integer index, Integer max) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from Student order by StuId asc","",index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public List<Student> selectStudentLikeStuName(Integer index, Integer max, String stuName) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from Student where StuName like :stuname order by StuId asc",stuName,index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public Student deleteStudent(Student student) {
        hibernateTemplate.delete(student);
        return student;
    }

    @Override
    public int countStudent() {
        Long count = (Long)hibernateTemplate.find("select count(*) from Student").listIterator().next();
        System.out.println(count);
        return count.intValue();
    }

}
