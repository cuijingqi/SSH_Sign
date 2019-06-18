package cui.sign.service;

import cui.sign.dao.impl.AdminDao;
import cui.sign.dao.impl.SignDao;
import cui.sign.dao.impl.StudentDao;
import cui.sign.dao.impl.TimeLimitDao;
import cui.sign.domain.Admin;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.domain.TimeLimit;
import cui.sign.service.impl.AdminService;
import javafx.animation.Timeline;
import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class AdminServiceImp implements AdminService {
    public AdminDao adminDao;
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

    public void setAdminDao(AdminDao adminDao) {
        this.adminDao = adminDao;
    }

    @Override
    public boolean login(String username, String password) {
        Admin admin = adminDao.adminByUP(username, password);
        HttpSession session = ServletActionContext.getRequest().getSession();
        if (admin!=null){
            session.setAttribute("admin", admin);
//            session.setAttribute("Tip", 0);
        }
        return admin!=null;
    }

    @Override
    public TimeLimit findByTLId(String TLId) {
        return timeLimitDao.findTimeByTLId(Long.parseLong(TLId));
    }

    @Override
    public String insertStudent(Student student) {
        if (student.getStuId().toString().length()>20)return "fail";
        Student stu = studentDao.findByStuId(student.getStuId());
        if (stu==null){
            Student student1 = studentDao.insertStudent(student.getStuId(), student.getStuName(), student.getSex(), student.getClassId(), student.getTel());
            if (student1.getStuId()!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String insertAdmin(Admin admin) {
        if (admin.getUserName().length()>15)return "fail";
        if (admin.getCompetence()==null)return "once";
        Admin adm = adminDao.findByAId(admin.getCompetence());
        if (adm!=null) {
            Admin adm1 = adminDao.findByUserName(admin.getUserName());
            if (adm1==null) {
                Admin admin1 = adminDao.insertAdmin(admin.getName(), admin.getUserName(), admin.getPassword(), admin.getCompetence(), admin.getEmail(), admin.getTel(), new Date());
                if (admin1.getAId()!= null) {
                    return "win";
                } else {
                    return "fail";
                }
            }else {
                return "once";
            }
        }else {
            return "failing";
        }
    }

    @Override
    public String insertTimeLimit(TimeLimit timeLimit, String blank, String count) {
        Date startTime = timeLimit.getStartTime();
        Date endTime = timeLimit.getEndTime();
        int blank1=Integer.parseInt(blank);
        int count1=Integer.parseInt(count);
        int win=0;
        int fail=0;
        int once=0;
        for(int i=0;i<count1;i++){
            TimeLimit timeLimit2 = timeLimitDao.findTimeLimit(startTime, endTime);
            if (timeLimit2==null) {
                TimeLimit timeLimit1 = timeLimitDao.insertTimeLimit(startTime, endTime);
                if (timeLimit1.getTLId() != null) {
                    win++;
                } else {
                    fail++;
                }
            }else {
                once++;
            }
            Calendar clr=Calendar.getInstance();
            clr.setTime(startTime);
            clr.add(Calendar.DATE,blank1);
            startTime=clr.getTime();
            clr.setTime(endTime);
            clr.add(Calendar.DATE,blank1);
            endTime=clr.getTime();
        }
        return "成功:"+win+"  重复:"+once+"  失败:"+fail;
    }


    @Override
    public String updataStudent(Student student) {
        Student stu = studentDao.findByStuId(student.getStuId());
        if (stu!=null){
            Student student1 = studentDao.updataStudent(student.getStuId(), student.getStuName(), student.getSex(), student.getClassId(), student.getTel());
            if (student1.getStuId()!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String updataAdmin(Admin admin) {
        Admin byAId = adminDao.findByAId(admin.getAId());
        if (byAId!=null){
            if (!byAId.getUserName().equals(admin.getUserName())){
                Admin byUserName = adminDao.findByUserName(admin.getUserName());
                if (byUserName==null) {
                    Admin admin1 = adminDao.updataAdmin(admin.getAId(), admin.getName(), admin.getUserName(), admin.getPassword(), admin.getEmail(), admin.getTel());
                    if (admin1.getAId() != null) {
                        return "win";
                    } else {
                        return "fail";
                    }
                }else {
                    return "onceing";
                }
            }else {
                Admin admin1 = adminDao.updataAdmin(admin.getAId(), admin.getName(), admin.getUserName(), admin.getPassword(), admin.getEmail(), admin.getTel());
                if (admin1.getAId() != null) {
                    return "win";
                } else {
                    return "fail";
                }
            }

        }else {
            return "once";
        }
    }

    @Override
    public String updataTimeLimit(TimeLimit timeLimit) {
        TimeLimit timeLimit1=timeLimitDao.findTimeByTLId(timeLimit.getTLId());
        if (timeLimit1!=null){
            TimeLimit timeLimit2 = timeLimitDao.updataTimeLimit(timeLimit.getTLId(), timeLimit.getStartTime(), timeLimit.getEndTime());
            if (timeLimit2.getTLId()!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public List<Student> selectStudent(String index, String max,String stuName) {
        int in=Integer.parseInt(index);
        int ma=Integer.parseInt(max);
        in=in==0?0:in;
        ma=ma==0?8:ma;
        in=(in-1)*ma;
        in=in<0?0:in;
        if (stuName==null){
            return studentDao.selectStudent(in,ma);
        }else {
            return studentDao.selectStudentLikeStuName(in,ma,stuName);
        }
    }

    @Override
    public List<Admin> selectAdmin(String index, String max, String competence,String name) {
        int in=Integer.parseInt(index);
        int ma=Integer.parseInt(max);
        int com = Integer.parseInt(competence);
        in=in==0?0:in;
        ma=ma==0?8:ma;
        in=(in-1)*ma;
        in=in<0?0:in;
        if (name==null){
            return adminDao.selectAdmin(in,ma,com);
        }else {
            return adminDao.selectAdminLikeName(in,ma,com,name);
        }
    }

    @Override
    public List<TimeLimit> selectTimeLimit(String index, String max, Date date) {
        int in=Integer.parseInt(index);
        int ma=Integer.parseInt(max);
        in=in==0?0:in;
        ma=ma==0?8:ma;
        in=(in-1)*ma;
        in=in<0?0:in;
        if (date.toString().equals(new Date(0).toString())){
            return timeLimitDao.selectTimeLimit(in,ma);
        }else {
            return timeLimitDao.selectTimeLimitLikeDate(in,ma,date);
        }
    }

    @Override
    public List<Sign> selectSignByTLId(String TLId) {
        TimeLimit timeByTLId = timeLimitDao.findTimeByTLId(Long.parseLong(TLId));
        if (timeByTLId!=null){
            List<Sign> signs = signDao.selectSignByTimeLimit(timeByTLId.getStartTime(), timeByTLId.getEndTime());
            if (signs!=null){
                return signs;
            }else {
                return null;
            }
        }else {
            return null;
        }
    }

    @Override
    public List<Sign> selectSignByStuId(String stuId) {
        Student byStuId = studentDao.findByStuId(stuId);
        if (byStuId!=null){
            List<Sign> signs = signDao.selectSignByStuId(stuId);
            if (signs!=null){
                return signs;
            }else {
                return null;
            }
        }else {
            return null;
        }
    }

    @Override
    public List<Student> selectStudentByTLId(String TLId) {
        TimeLimit timeByTLId = timeLimitDao.findTimeByTLId(Long.parseLong(TLId));
        if (timeByTLId!=null){
            List<Sign> signs = signDao.selectSignByTimeLimit(timeByTLId.getStartTime(), timeByTLId.getEndTime());
            if (signs!=null){
                List<Student> students=new ArrayList<>();
                for (Sign s:signs){
                    students.add(s.getStudent());
                }
                if (students!=null){
                    return students;
                }else {
                    return null;
                }
            }else {
                return null;
            }
        }else {
            return null;
        }
    }


    @Override
    public int numPages(String max,String table,String competence) {
        if (table.equals("Student")){
            int max1=Integer.parseInt(max);
            int i = studentDao.countStudent();
            return i%max1==0?i/max1:i/max1+1;
        }else if (table.equals("Admin")){
            int max1=Integer.parseInt(max);
            int i = adminDao.countAdminByCompetence(Integer.parseInt(competence));
            return i%max1==0?i/max1:i/max1+1;
        }else if (table.equals("TimeLimit")){
            int max1=Integer.parseInt(max);
            int i = timeLimitDao.countTimeLimit();
            return i%max1==0?i/max1:i/max1+1;
        }
        return 0;
    }

    @Override
    public int signCount(String stuId) {
        Student byStuId = studentDao.findByStuId(stuId);
        if (byStuId!=null){
            List<Sign> signs = signDao.selectSignByStuId(stuId);
            if (signs!=null){
                return signs.size();
            }else {
                return 0;
            }
        }else {
            return 0;
        }
    }


    @Override
    public String deleteByStuId(String stuId) {
        Student byStuId = studentDao.findByStuId(stuId);
        if (byStuId!=null){
            Student student = studentDao.deleteStudent(byStuId);
            if (student!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String deleteByAId(String AId) {
        Admin byAId = adminDao.findByAId(Integer.parseInt(AId));
        if (byAId!=null){
            Admin admin = adminDao.deleteAdmin(byAId);
            if (admin!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String deleteBySignId(String SignId) {
        Sign sign = signDao.findByStuId(Long.parseLong(SignId));
        if (sign!=null){
            Sign sign1 = signDao.deleteSign(sign);
            if (sign1!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String deleteByTLId(String TLId) {
        TimeLimit timeByTLId = timeLimitDao.findTimeByTLId(Long.parseLong(TLId));
        if (timeByTLId!=null){
            TimeLimit timeLimit = timeLimitDao.deleteTimeLimit(timeByTLId);
            if (timeLimit!=null){
                return "win";
            }else {
                return "fail";
            }
        }else {
            return "once";
        }
    }

    @Override
    public String deleteByTLIdAndStuId(String TLId, String StuId) {
        TimeLimit timeByTLId = timeLimitDao.findTimeByTLId(Long.parseLong(TLId));
        if (timeByTLId!=null){
            Sign sign = signDao.stuIdLiminTime(StuId, timeByTLId.getStartTime(), timeByTLId.getEndTime());
            if (sign!=null){
                Sign sign1 = signDao.deleteSign(sign);
                if (sign1!=null){
                    return "win";
                }else {
                    return "fail";
                }
            }else {
                return "onceing";
            }
        }else {
            return "once";
        }
    }

}
