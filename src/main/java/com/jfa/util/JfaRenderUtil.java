package com.jfa.util;

import cn.hutool.core.io.FileUtil;
import com.jfinal.core.Controller;
import com.jfinal.kit.LogKit;
import com.jfinal.template.Engine;
import com.jfinal.template.Template;
import com.jfinal.template.source.ClassPathSourceFactory;
import lombok.NonNull;

import java.io.StringWriter;

/**
 * Created by a13570610691 on 2018/5/23.
 */
public class JfaRenderUtil {
    public static void render(@NonNull String path, @NonNull Controller cont){
        LogKit.info("path: "+path);
        if(FileUtil.exist("src/main/webapp/"+path)) {
            LogKit.debug("src/main/webapp/"+path+" exist...");
            cont.render("processList.html");
        } else {
            if(FileUtil.exist(path)) {
                LogKit.debug(path+" exist...");
                cont.render("processList.html");
            } else {
                Engine renderEngine = Engine.use("myEngine");
                if (renderEngine == null) {
                    renderEngine = Engine.create("myEngine");
                    if(FileUtil.exist("template/layui/common/_layout.html")) {
                        renderEngine.addSharedFunction("template/layui/common/_layout.html");
                        renderEngine.setSourceFactory(new ClassPathSourceFactory());
                    }else{
                        renderEngine.setSourceFactory(new ClassPathSourceFactory());
                        renderEngine.addSharedFunction("META-INF/resources/template/layui/common/_layout.html");
                    }
                }

                Template t = renderEngine.getTemplate("META-INF/resources/template/layui/workflow/processList.html");
                StringWriter writer = new StringWriter();
                t.render(writer);
                String theString = writer.toString();
                cont.renderHtml(theString);
            }
        }
    }
}
