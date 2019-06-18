package cui.sign.dao;

import cui.sign.dao.impl.SignDao;
import cui.sign.dao.impl.TimeLimitDao;
import cui.sign.domain.Sign;
import cui.sign.domain.TimeLimit;
import cui.sign.utils.PageNoUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Date;
import java.util.List;

public class TimeLimitDaoImpl implements TimeLimitDao {
    HibernateTemplate hibernateTemplate;
    private SignDao signDao;

    public void setSignDao(SignDao signDao) {
        this.signDao = signDao;
    }

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    @Override
    public List<TimeLimit> findTime() {
        List timeLimit = hibernateTemplate.find("from TimeLimit");
        return timeLimit;
    }

    @Override
    public TimeLimit findTimeByTLId(Long TLId) {
        TimeLimit timeLimit = hibernateTemplate.get(TimeLimit.class, TLId);
        return timeLimit;
    }

    @Override
    public TimeLimit findTimeByDate(Date date) {
        List<TimeLimit> list = hibernateTemplate.find("from TimeLimit  where startTime<=? and endTime>=?", date,date);
        return list.size()>=1?list.get(0):null;
    }

    @Override
    public TimeLimit findTimeLimit(Date startTime, Date endTime) {
        List<TimeLimit> list = hibernateTemplate.find("from TimeLimit  where startTime=? and endTime=?", startTime,endTime);
        return list.size()>=1?list.get(0):null;
    }

    @Override
    public TimeLimit insertTimeLimit(Date startTime, Date endTime) {
        TimeLimit timeLimit=new TimeLimit(startTime,endTime);
        hibernateTemplate.save(timeLimit);
        return timeLimit;
    }

    @Override
    public List<TimeLimit> selectTimeLimit(Integer index, Integer max) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from TimeLimit",new Date(0),index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public List<TimeLimit> selectTimeLimitLikeDate(Integer index, Integer max, Date date) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from TimeLimit where startTime<=:date and endTime>=:date",date,index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public TimeLimit updataTimeLimit(Long Tlid, Date startDate, Date endDate) {
        TimeLimit timeLimit=new TimeLimit(Tlid,startDate,endDate);
        hibernateTemplate.saveOrUpdate(timeLimit);
        return timeLimit;
    }

    @Override
    public TimeLimit deleteTimeLimit(TimeLimit timeLimit) {
        List<Sign> signs = signDao.selectSignByTimeLimit(timeLimit.getStartTime(), timeLimit.getEndTime());
        for(Sign s:signs){
            s.getStudent().getSigns().remove(s);
            s.setStudent(null);
            signDao.deleteSign(s);
        }
        hibernateTemplate.delete(timeLimit);
        return timeLimit;
    }

    @Override
    public int countTimeLimit() {
        Long count = (Long)hibernateTemplate.find("select count(*) from TimeLimit").listIterator().next();
        System.out.println(count);
        return count.intValue();
    }

}
