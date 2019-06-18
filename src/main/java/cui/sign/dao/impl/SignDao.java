package cui.sign.dao.impl;

import cui.sign.domain.Sign;
import cui.sign.domain.Student;

import java.util.Date;
import java.util.List;

public interface SignDao {
    public Sign insertSign(String StuId);
    public Sign findByStuId(Long SignId);
    public Sign ipLiminTime(String ip,Date startdate,Date enddate);
    public Sign stuIdLiminTime(String stuId,Date startdate,Date enddate);
    public List<Sign> selectSignByStuId(String stuId);
    public List<Sign> selectSignByTimeLimit(Date startdate,Date enddate);
    public Sign deleteSign(Sign sign);
}
