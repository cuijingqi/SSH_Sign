package cui.sign.dao;


import cui.sign.dao.impl.SignDao;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.utils.IpAddress;
import org.apache.struts2.ServletActionContext;
import org.springframework.orm.hibernate3.HibernateTemplate;
import java.util.Date;
import java.util.List;

public class SignDaoImpl implements SignDao {
    HibernateTemplate hibernateTemplate;
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }
    @Override
    public Sign insertSign(String StuId) {
        Student student = hibernateTemplate.get(Student.class, StuId);

        Sign sign=new Sign();
        sign.setIP(IpAddress.getIpAddress(ServletActionContext.getRequest()));
        sign.setTime(new Date());

        sign.setStudent(student);
        student.getSigns().add(sign);

        hibernateTemplate.saveOrUpdate(student);
        return sign;
    }

    @Override
    public Sign findByStuId(Long SignId) {
        Sign sign = hibernateTemplate.get(Sign.class, SignId);
        System.out.println(sign);
        return sign;
    }

    @Override
    public Sign ipLiminTime(String ip, Date startdate, Date enddate) {
        List<Sign> list = hibernateTemplate.find("from Sign where IP=? and time>=? and time<=?", ip, startdate, enddate);
        return list.size()>=1?list.get(0):null;
    }

    @Override
    public Sign stuIdLiminTime(String stuId, Date startdate, Date enddate) {
        List<Sign> list = hibernateTemplate.find("from Sign where student.id=? and time>=? and time<=?", stuId, startdate, enddate);
        return list.size()>=1?list.get(0):null;
    }

    @Override
    public List<Sign> selectSignByStuId(String stuId) {
        List<Sign> list = hibernateTemplate.find("from Sign where student.id=?", stuId);
        return list;
    }

    @Override
    public List<Sign> selectSignByTimeLimit(Date startdate, Date enddate) {
        List<Sign> list = hibernateTemplate.find("from Sign where  time>=? and time<=?", startdate, enddate);
        return list;
    }

    @Override
    public Sign deleteSign(Sign sign) {
        hibernateTemplate.delete(sign);
        return sign;
    }
}
