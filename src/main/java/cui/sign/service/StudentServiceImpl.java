package cui.sign.service;

import cui.sign.dao.impl.SignDao;
import cui.sign.dao.impl.StudentDao;
import cui.sign.dao.impl.TimeLimitDao;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.domain.TimeLimit;
import cui.sign.service.impl.StudentService;
import cui.sign.utils.IpAddress;
import org.apache.struts2.ServletActionContext;
import sun.net.util.IPAddressUtil;

import java.util.Date;

public class StudentServiceImpl implements StudentService {
    public StudentDao studentDao;
    public TimeLimitDao timeLimitDao;
    public SignDao signDao;

    public void setSignDao(SignDao signDao) {
        this.signDao = signDao;
    }
    public void setTimeLimitDao(TimeLimitDao timeLimitDao) {
        this.timeLimitDao = timeLimitDao;
    }
    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    @Override
    public Student findByStuId(String StuId){
        return studentDao.findByStuId(StuId);
    }
    @Override
    public String insertSign(String StuId) {
        TimeLimit timeByDate = timeLimitDao.findTimeByDate(new Date());
        if (timeByDate!=null){
            Sign stuIdLiminTime = signDao.stuIdLiminTime(StuId, timeByDate.getStartTime(), timeByDate.getEndTime());
            if(stuIdLiminTime==null) {
                Sign ipLiminTime = signDao.ipLiminTime(IpAddress.getIpAddress(ServletActionContext.getRequest()), timeByDate.getStartTime(), timeByDate.getEndTime());
                if (ipLiminTime == null) {
                    Sign sign = signDao.insertSign(StuId);
                    if (sign.getStudent() != null) {
                        return "win";
                    }
                    return "fail";
                } else {
                    return "once";
                }
            }else {
                return "wining";
            }
        }else {
            return "timeout";
        }
    }
}
