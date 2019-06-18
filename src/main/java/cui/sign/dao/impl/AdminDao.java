package cui.sign.dao.impl;

import cui.sign.domain.Admin;
import cui.sign.domain.Student;

import java.util.Date;
import java.util.List;

public interface AdminDao {
    public Admin findByAId(Integer AId);
    public Admin findByUserName(String username);
    public Admin adminByUP(String username,String password);
    public Admin insertAdmin(String name, String userName, String password, Integer competence, String email, String tel, Date createDate);
    public Admin updataAdmin(Integer AId, String name, String userName, String password, String email, String tel);
    public List<Admin> selectAdmin(Integer index, Integer max,Integer competence);
    public List<Admin> selectAdminLikeName(Integer index, Integer max,Integer competence,String name);
    public Admin deleteAdmin(Admin admin);
    public void deleteAdmins(Admin admin);
    public int countAdminByCompetence(Integer competence);
}
