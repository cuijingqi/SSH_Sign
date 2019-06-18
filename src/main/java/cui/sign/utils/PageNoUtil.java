package cui.sign.utils;


import org.hibernate.Query;

import org.hibernate.Session;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**

 *本工具类主要用来实现分页

 */

public class PageNoUtil {

    /**

     * @param             session :一个会话

     * @param            hql:是需要执行的hql语句，

     * @param            offset 设置开始位置

     * @param              length:读取记录条数

     * return             返回结果集List<?>表示一个泛型的List

     */

    public static List<?> getList(Session session , String hql ,String stuName, int offset, int length){
        if (stuName=="") {
            Query q = session.createQuery(hql);

            q.setFirstResult(offset);

            q.setMaxResults(length);

            List<?> list = q.list();

            return list;
        }else {
            Query q = session.createQuery(hql);
            q.setString("stuname", "%"+stuName+"%");
            q.setFirstResult(offset);

            q.setMaxResults(length);

            List<?> list = q.list();

            return list;
        }
    }
    public static List<?> getList(Session session , String hql ,int competence,String name, int offset, int length){
            if (name==null) {
                Query q = session.createQuery(hql);
                q.setString("competence", competence + "");
                q.setFirstResult(offset);

                q.setMaxResults(length);

                List<?> list = q.list();

                return list;
            }else {
                Query q = session.createQuery(hql);
                q.setString("competence", competence + "");
                q.setString("name", "%"+name+"%");
                q.setFirstResult(offset);

                q.setMaxResults(length);

                List<?> list = q.list();

                return list;
            }
    }
    public static List<?> getList(Session session , String hql , Date date, int offset, int length){
        if (date.toString().equals(new Date(0).toString())) {
            Query q = session.createQuery(hql);
            q.setFirstResult(offset);

            q.setMaxResults(length);

            List<?> list = q.list();

            return list;
        }else {
            Query q = session.createQuery(hql);
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            q.setString("date", df.format(date));
            q.setFirstResult(offset);

            q.setMaxResults(length);

            List<?> list = q.list();

            return list;
        }
    }

}
