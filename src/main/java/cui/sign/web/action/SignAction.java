package cui.sign.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import cui.sign.domain.Sign;
import cui.sign.service.impl.AdminService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SignAction extends ActionSupport implements ModelDriven<Sign> {
    private Sign sign=new Sign();
    private AdminService adminService;

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    @Override
    public Sign getModel() {
        return sign;
    }
    public String deleteSign(){
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        response.setContentType("text/html;charset=utf-8");
        String signId = String.valueOf(sign.getSignId());
        String s = adminService.deleteBySignId(signId);
        try {
            response.getWriter().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }
}
