package com.jfa.controllers.login;

import com.jfa.util.MD5Util;
import com.jfinal.captcha.CaptchaRender;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

public class LoginController extends Controller {
	private static final String RANDOM_CODE_KEY = "jfa";
	private Log logger = Log.getLog(LoginController.class);
	Subject currentUser = SecurityUtils.getSubject();

	public void index() {
		render("login.html");
	}

	public void captcha() {
		CaptchaRender cr = new CaptchaRender();
		cr.setContext(this.getRequest(), this.getResponse());
		cr.setCaptchaName(RANDOM_CODE_KEY);
		cr.render();
		renderNull();
	}

	public void do_login() {
		String username = getPara("username");

		if (username == null) {
			redirect("/login");
			return;
		}
		String sha1Pwd = MD5Util.encode("SHA1", getPara("password"));
		UsernamePasswordToken token = new UsernamePasswordToken(username, sha1Pwd );


		/*String inputRandomCode = getPara("inputRandomCode");
		boolean loginSuccess = CaptchaRender.validate(this, inputRandomCode);
		if (!loginSuccess) {
			String errMsg = "验证码不正确";
			setAttr("errMsg", errMsg);
			logger.debug(errMsg);
			redirect("/login");
			return;
		}*/

		if (getPara("remember") != null && "Y".equals(getPara("remember")))
			token.setRememberMe(true);

		String errMsg = "";
		try {
			currentUser.login(token);
//            if (getPara("remember") != null && "Y".equals(getPara("remember"))){
//                // timeout:-1000ms 这样设置才能永不超时
//            	currentUser.getSession().setTimeout(-1000L);
//            }

		} catch (UnknownAccountException uae) {
			errMsg = "用户名不存在";
			errMsg = "用户名/密码不正确";
			logger.debug(errMsg);
		} catch (IncorrectCredentialsException ice) {
			errMsg = "密码不正确";
			errMsg = "用户名/密码不正确";
			logger.debug(errMsg);
		} catch (LockedAccountException lae) {
			errMsg = "用户名已被停用";
			logger.debug(errMsg);
		} catch (AuthenticationException ae) {
			errMsg = "其它原因";
			logger.debug(ae.getMessage());
		}

		if (errMsg.length()==0) {
			Record userRec = Db.findFirst("select * from t_rbac_user where name=?", username);
			//记录user session到Ehcache中, 方便踢人(只允许唯一登录)
			Session oldSession = CacheKit.get("userSessionCache", userRec.get("id"));
			if(oldSession==null) {
				CacheKit.put("userSessionCache", userRec.get("id"), currentUser.getSession());
			}else{
				//如果用户相同，Session不相同，那么就要处理了
				Serializable oldSessionId=oldSession.getId();
				Serializable newSessionId=currentUser.getSession().getId();
				if (!oldSessionId.equals(newSessionId)){
					oldSession.setAttribute("kick_out", Boolean.TRUE);
					logger.debug("kick out user: "+username+", old session id:"+oldSessionId);
				}
			}
			setLoginLog(username);
			redirect("/");
		} else {
			setAttr("errMsg", errMsg);
			redirect("/login");
		}
	}

	private void setLoginLog(String user_name) {

		String localip = getIpAddress(this.getRequest());
		Record rec = new Record();
		rec.set("create_stamp", new Date());
		rec.set("user_name", user_name);
		rec.set("ip", localip);

		Db.save("t_login_log", rec);
	}

	public static String getIpAddress(HttpServletRequest request){
		String ipAddress = request.getHeader("x-forwarded-for");

		if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0 || "unknow".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
			ipAddress = request.getRemoteAddr();

			if(ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")){
				//根据网卡获取本机配置的IP地址
				InetAddress inetAddress = null;
				try {
					inetAddress = InetAddress.getLocalHost();
				} catch (UnknownHostException e) {
					e.printStackTrace();
				}
				ipAddress = inetAddress.getHostAddress();
			}
		}

		//对于通过多个代理的情况，第一个IP为客户端真实的IP地址，多个IP按照','分割
		if(null != ipAddress && ipAddress.length() > 15){
			//"***.***.***.***".length() = 15
			if(ipAddress.indexOf(",") > 0){
				ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
			}
		}
		return ipAddress;
	}
}





