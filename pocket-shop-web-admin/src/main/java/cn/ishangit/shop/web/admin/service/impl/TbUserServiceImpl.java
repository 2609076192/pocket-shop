package cn.ishangit.shop.web.admin.service.impl;

import cn.ishangit.shop.domain.TbUser;
import cn.ishangit.shop.web.admin.dao.TbUserDao;
import cn.ishangit.shop.web.admin.service.TbUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.List;

/**
 * @author Chen
 * @create 2019-05-16 12:13
 */
@Service
public class TbUserServiceImpl implements TbUserService {

    @Autowired
    private TbUserDao tbUserDao;

    @Override
    public List<TbUser> selectAll() {
        return tbUserDao.selectAll();
    }

    @Override
    public TbUser login(String email, String password) {
        TbUser tbUser = tbUserDao.getByEmail(email);
        if (tbUser!= null){
            //对密码进行加密
            String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());
            //与数据库中的密码匹配
            if (md5Password.equals(tbUser.getPassword())){
                return tbUser;
            }
        }
        return null;
    }
}
