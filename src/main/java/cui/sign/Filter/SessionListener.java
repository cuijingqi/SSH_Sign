package cui.sign.Filter;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * session监听器
 * @author bojiangzhou
 * @date 2016年2月28日
 */
public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    //属性添加时间
    private long addTime;

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("session 创建");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        System.out.println("session 销毁");
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        System.out.println("添加属性："+event.getName());
        //当属性保存的时候保存当前时间
        addTime = System.currentTimeMillis();
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        System.out.println("移除属性："+event.getName());
        //当属性移除的时候计算属性保存时间
        long removeTime = System.currentTimeMillis();
        long t = (removeTime-addTime)/1000;
        System.out.println("数据保存时间："+t+"秒");
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
        System.out.println("更改属性："+event.getName());
    }

}