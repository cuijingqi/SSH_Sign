package cui.sign.dao.impl;


import cui.sign.domain.TimeLimit;
import java.util.Date;
import java.util.List;

public interface TimeLimitDao {
    public List<TimeLimit> findTime();
    public TimeLimit findTimeByTLId(Long TLId);
    public TimeLimit findTimeByDate(Date date);
    public TimeLimit findTimeLimit(Date startTime,Date endTime);
    public TimeLimit insertTimeLimit(Date startTime,Date endTime);
    public List<TimeLimit> selectTimeLimit(Integer index, Integer max);
    public List<TimeLimit> selectTimeLimitLikeDate(Integer index, Integer max, Date date);
    public TimeLimit updataTimeLimit(Long Tlid, Date startDate,Date endDate);
    public TimeLimit deleteTimeLimit(TimeLimit timeLimit);
    public int countTimeLimit();
}
