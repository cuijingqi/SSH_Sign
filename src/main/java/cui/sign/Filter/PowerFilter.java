package cui.sign.Filter;

import cui.sign.domain.Admin;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class PowerFilter implements Filter {
    /**
     * 需要排除的页面
     */

    private String excludedPages;
    private String[] excludedPageArray;
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        String reqServletPath = req.getServletPath();
        HttpSession session = req.getSession();
        if (reqServletPath.endsWith(".css") || reqServletPath.endsWith(".js")) {
            filterChain.doFilter(servletRequest, servletResponse);
        }else {
            boolean isExcludedPage = false;
            String servletPath = reqServletPath.replace("//", "");
            for (String page : excludedPageArray) {//判断是否在过滤url之外
                if(servletPath.equals(page)){
                    isExcludedPage = true;
                    break;
                }
            }
            if (isExcludedPage){
                filterChain.doFilter(servletRequest, servletResponse);
            }else {
                Admin admin = (Admin) session.getAttribute("admin");
                if (admin != null && !String.valueOf(admin.getAId()).trim().equals("")) {
                    // 如果现在存在了session，则请求向下继续传递
                    filterChain.doFilter(servletRequest, servletResponse);
                } else {
                    // 跳转到提示登陆页面
                    servletRequest.getRequestDispatcher("/Admin.jsp").forward(servletRequest, servletResponse);
                }
            }
        }

    }


    @Override
    public void destroy() {

    }

    /**
     * 初始化函数，获取需要排除在外的url
     */

    public void init(FilterConfig fConfig) throws ServletException {
        excludedPages = fConfig.getInitParameter("excludedPages");
        if (StringUtils.isNotEmpty(excludedPages)) {
            excludedPageArray = excludedPages.split(",");
        }
        return;
    }
}
