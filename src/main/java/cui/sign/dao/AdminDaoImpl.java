package cui.sign.dao;

import cui.sign.dao.impl.AdminDao;
import cui.sign.domain.Admin;
import cui.sign.utils.PageNoUtil;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class AdminDaoImpl implements AdminDao {
    HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    @Override
    public Admin findByAId(Integer AId) {
        Admin admin= hibernateTemplate.get(Admin.class, AId);
        System.out.println(admin);
        return admin;
    }

    @Override
    public Admin findByUserName(String username) {
        List<Admin> list = hibernateTemplate.find("from Admin where userName=?", username);
        return list.size()==0?null:list.get(0);
    }


    @Override
    public Admin adminByUP(String username, String password) {
        List<Admin> list = hibernateTemplate.find("from Admin where userName=? and password=?", username, password);
        return list.size()==0?null:list.get(0);
    }

    @Override
    public Admin insertAdmin(String name, String userName, String password, Integer competence, String email, String tel, Date createDate) {
        Admin admin=new Admin(name,userName,password,competence,email,tel,createDate);
        hibernateTemplate.save(admin);
        return admin;
    }

    @Override
    public Admin updataAdmin(Integer AId, String name, String userName, String password, String email, String tel) {
        Admin admin = new Admin(AId,name,userName,password,email,tel);
        hibernateTemplate.saveOrUpdate(admin);
        return admin;
    }

    @Override
    public List<Admin> selectAdmin(Integer index, Integer max,Integer competence) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from Admin where Competence=:competence order by AId asc",competence,null,index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public List<Admin> selectAdminLikeName(Integer index, Integer max, Integer competence, String name) {
        List list1 = hibernateTemplate.executeFind(
                new  HibernateCallback() {
                    @Override
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        List list2 = PageNoUtil. getList(session,"from Admin where Competence=:competence and name like :name order by AId asc",competence,name,index,max);
                        return list2;
                    }
                });
        return list1;
    }

    @Override
    public Admin deleteAdmin(Admin admin) {
        deleteAdmins(admin);
        return admin;
    }

    @Override
    public void deleteAdmins(Admin admin){
        List<Admin> list = hibernateTemplate.find("from Admin where competence=?", admin.getAId());
        if (list==null){
            return;
        }
        for(Admin a:list){
            deleteAdmin(a);
            hibernateTemplate.delete(a);
        }
        hibernateTemplate.delete(admin);
    }

    @Override
    public int countAdminByCompetence(Integer competence) {
        Long count = (Long)hibernateTemplate.find("select count(*) from Admin where competence=?",competence).listIterator().next();
        System.out.println(count);
        return count.intValue();
    }


}
