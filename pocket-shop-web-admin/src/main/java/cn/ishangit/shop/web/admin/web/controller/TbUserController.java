package cn.ishangit.shop.web.admin.web.controller;

import cn.ishangit.shop.commons.dto.BaseResult;
import cn.ishangit.shop.commons.dto.PageInfo;
import cn.ishangit.shop.domain.TbUser;
import cn.ishangit.shop.web.admin.abstracts.AbstractBaseController;
import cn.ishangit.shop.web.admin.service.TbUserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Chen
 * @create 2019-05-16 19:55
 * 用户管理
 */
@RequestMapping(value = "user")
@Controller
public class TbUserController extends AbstractBaseController<TbUser,TbUserService> {

    @ModelAttribute
    public TbUser getTbUser( Long id){
        TbUser tbUser = new TbUser();
        if (id != null){
            tbUser = service.getById(id);
            return tbUser;
        }else
        return tbUser;
    }

    /**
     * 跳转到用户列表页
     * @param model
     * @return
     */
    @Override
    @RequestMapping(value = "list",method = RequestMethod.GET)
    public String list(Model model){
        return "user_list";
    }

    /**
     * 跳转到用户表单页
     * @return
     */
    @Override
    @RequestMapping(value = "form",method = RequestMethod.GET)
    public  String form(){
        return "user_form";
    }

    /**
     * 用户信息保存
     * @param tbUser
     * @return
     */
    @Override
    @RequestMapping(value = "save",method = RequestMethod.POST)
    public String save(TbUser tbUser, RedirectAttributes redirectAttributes,Model model){
        BaseResult baseResult = service.save(tbUser);
        if (baseResult.getStatus() == BaseResult.STATUS_SUCCESS) {
            redirectAttributes.addFlashAttribute("baseResult", baseResult);
            return "redirect:/user/list";
        }
        else {
            model.addAttribute("baseResult",baseResult);
            return "user_form";
        }
    }


    /**
     * 批量删除用户信息
     * @param ids
     * @return
     */
    @Override
    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public BaseResult delete(String ids){
        BaseResult baseResult = null;
        if (!StringUtils.isBlank(ids)) {
            String[] idsArr = ids.split(",");
            service.deleteMulti(idsArr);
            baseResult = BaseResult.success("删除成功！");
            return baseResult;
        }
        else {
            baseResult = BaseResult.fail("删除失败！");
            return baseResult;
        }
    }

    /**
     * 分页查询
     * @param request
     * @param tbUser
     * @return
     */
    @Override
    @RequestMapping(value = "page",method = RequestMethod.GET)
    @ResponseBody
    public PageInfo<TbUser> page(HttpServletRequest request,TbUser tbUser){
        Map<String, Object> res = new HashMap<>();

        String str_draw = request.getParameter("draw");
        String str_start = request.getParameter("start");
        String str_length = request.getParameter("length");

        int draw = str_draw  == null?0: Integer.parseInt(str_draw);
        int start = str_start  == null?0: Integer.parseInt(str_start);
        int length = str_length  == null?10: Integer.parseInt(str_length);
        PageInfo<TbUser> pageInfo = service.page(length, start,draw,tbUser);

        return pageInfo;
    }

    /**
     * 用户详情
     * @param tbUser
     * @return
     */
    @Override
    @RequestMapping(value = "detail",method = RequestMethod.GET)
    public String detail(TbUser tbUser){
        return "user_detail";
    }
}
