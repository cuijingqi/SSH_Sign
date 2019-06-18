package cui.sign.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import cui.sign.domain.Sign;
import cui.sign.domain.Student;
import cui.sign.service.impl.AdminService;
import cui.sign.service.impl.StudentService;
import org.apache.struts2.ServletActionContext;
import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

public class StudentAction extends ActionSupport implements ModelDriven<Student> {
    private Student student=new Student();
    private StudentService studentService;
    private AdminService adminService;

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    @Override
    public Student getModel() {
        return student;
    }
    //签到
    public String Sign(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String stuId = student.getStuId();
        String stuName = student.getStuName();
        if (stuId!=null&&!stuName.trim().isEmpty()){
            request.setAttribute("msg", studentService.insertSign(stuId));
        }else {
            request.setAttribute("msg", "fail");
        }
        return  SUCCESS;
    }
    //ajax查询by学号
    public String Find(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("application/json;charset=utf-8");
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String stuId = request.getParameter("stuId");
        if (stuId.isEmpty()) stuId=0+"";
        if (stuId.length()>20) stuId=0+"";
        Student byStuId = studentService.findByStuId(stuId);
        System.out.println(byStuId);
        if (byStuId==null){
            byStuId=new Student();
            byStuId.setStuName("");
            byStuId.setClassId("");
            byStuId.setClassId("");
        }
        byStuId.setSigns(null);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), byStuId);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return  NONE;
    }

    public String insertStudent(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(student);
        String s = adminService.insertStudent(student);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String updataStudent(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(student);
        String s = adminService.updataStudent(student);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectStudent(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String index=request.getParameter("index");
        String max=request.getParameter("max");
        String baidu=request.getParameter("baidu");
        List<Student> students = adminService.selectStudent(index, max, baidu);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(),students );
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String deleteStudent(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String stuId = request.getParameter("stuId");
        String s = adminService.deleteByStuId(stuId);
        try {
            response.getWriter().write(s);
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
        int i = adminService.numPages(max,"Student",null);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), i);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String signCount(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String stuId = student.getStuId();
        int i = adminService.signCount(stuId);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), i);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectSign(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String stuId = student.getStuId();
        List<Sign> signs = adminService.selectSignByStuId(stuId);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(),signs );
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
}
