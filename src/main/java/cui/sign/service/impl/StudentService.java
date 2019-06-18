package cui.sign.service.impl;

import cui.sign.domain.Student;

public interface StudentService {
    public Student findByStuId(String StuId);
    public String insertSign(String StuId);

}
