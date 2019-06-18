package cui.sign.web.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import cui.sign.dao.impl.AdminDao;
import cui.sign.dao.impl.TimeLimitDao;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.domain.TimeLimit;
import cui.sign.service.impl.AdminService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.ref.ReferenceQueue;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class TimeLimitAction extends ActionSupport implements ModelDriven<TimeLimit> {
    private TimeLimit timeLimit=new TimeLimit();
    private AdminService adminService;

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    @Override
    public TimeLimit getModel() {
        return timeLimit;
    }
    public String Find(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("application/json;charset=utf-8");
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String tlId = request.getParameter("TLId");
        if (tlId.isEmpty()) tlId=0+"";
        TimeLimit byTLId = adminService.findByTLId(tlId);
        System.out.println(byTLId);
        if (byTLId==null){
            byTLId=new TimeLimit();
            byTLId.setTLId(0l);
            byTLId.setStartTime(new Date(0));
            byTLId.setEndTime(new Date(0));
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), byTLId);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return  NONE;
    }
    public String insertTimeLimit(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(timeLimit);
        String blank = request.getParameter("blank");
        String count = request.getParameter("count");
        String startTime=request.getParameter("startTime");
        String endTime=request.getParameter("endTime");
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            Date start = df.parse(startTime);
            Date end = df.parse(endTime);
            timeLimit.setStartTime(start);
            timeLimit.setEndTime(end);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String s = adminService.insertTimeLimit(timeLimit, blank, count);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String updataTimeLimit(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        TimeLimit timeLimit1=new TimeLimit();
        timeLimit1.setTLId(Long.parseLong(request.getParameter("TLId")));
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            timeLimit1.setStartTime(df.parse(request.getParameter("startTime")));
            timeLimit1.setEndTime(df.parse(request.getParameter("endTime")));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println(timeLimit1);
        String s = adminService.updataTimeLimit(timeLimit1);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String deleteTimeLimit(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String tlId = request.getParameter("TLId");
        String s = adminService.deleteByTLId(tlId);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String deleteSign(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String stuId = request.getParameter("stuId");
        String tlId = request.getParameter("TLId");
        String s = adminService.deleteByTLIdAndStuId(tlId, stuId);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectTimeLimit(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String index=request.getParameter("index");
        String max=request.getParameter("max");
        String baidu=request.getParameter("baidu");
        ObjectMapper objectMapper=new ObjectMapper();
        List<TimeLimit> timeLimits;
        try {
            if (baidu!=null){
                SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm");
                timeLimits = adminService.selectTimeLimit(index, max, df.parse(baidu));
            }else {
                timeLimits = adminService.selectTimeLimit(index, max, new Date(0));
            }
            objectMapper.writeValue(response.getWriter(),timeLimits );
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectSign(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String tlId = request.getParameter("TLId");
        List<Sign> signs = adminService.selectSignByTLId(tlId);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(),signs);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectStudent(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String tlId = request.getParameter("TLId");
        List<Student> students = adminService.selectStudentByTLId(tlId);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(),students);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String indexPage(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String max=request.getParameter("max");
        int i = adminService.numPages(max,"TimeLimit",null);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), i);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
}
