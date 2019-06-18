package cui.sign.web.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import cui.sign.domain.Admin;
import cui.sign.domain.Student;
import cui.sign.service.impl.AdminService;
import org.apache.struts2.ServletActionContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminAction extends ActionSupport implements ModelDriven<Admin> {
    private AdminService adminService;
    private Admin admin=new Admin();

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }
    @Override
    public Admin getModel() {
        return admin;
    }
    public String admin(){
        return SUCCESS;
    }
    public String login(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(admin);
        boolean login = adminService.login(admin.getUserName(), admin.getPassword());
        if (login){
            return LOGIN;
        }else {
            request.setAttribute("msg", "fail");
        }
        return ERROR;
    }
    public String quit(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        request.getSession().removeAttribute("admin");
        return NONE;
    }
    public String updataAdmin(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(admin);
        String s = adminService.updataAdmin(admin);
        if (s=="win"){
            request.getSession().removeAttribute("admin");
        }
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String deleteAdmin(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String AId = request.getParameter("AId");
        String s = adminService.deleteByAId(AId);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String selectAdmin(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String index=request.getParameter("index");
        String max=request.getParameter("max");
        String competence=request.getParameter("competence");
        String baidu=request.getParameter("baidu");
        List<Admin> admins = adminService.selectAdmin(index,max,competence,baidu);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(),admins );
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
    public String insertAdmin(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        System.out.println(admin);
        String s = adminService.insertAdmin(admin);
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
        String competence=request.getParameter("competence");
        int i = adminService.numPages(max,"Admin",competence);
        ObjectMapper objectMapper=new ObjectMapper();
        try {
            objectMapper.writeValue(response.getWriter(), i);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
}
