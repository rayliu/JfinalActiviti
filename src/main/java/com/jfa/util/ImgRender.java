package com.jfa.util;

import com.jfinal.kit.LogKit;
import com.jfinal.render.Render;
import com.jfinal.render.RenderException;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by ray.liu on 2017/11/30.
 */
public class ImgRender extends Render {
    // 默认的图片大小
    protected static final int WIDTH = 200, HEIGHT = 100;
    private InputStream inputStream;

    public ImgRender(InputStream inputStream){
        this.inputStream = inputStream;
    }

    /**
     * 生成图片
     */
    public void render() {

        response.setHeader("Pragma","no-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        ServletOutputStream sos = null;
        try {
            sos = response.getOutputStream();
            BufferedImage image = ImageIO.read(inputStream);
            ImageIO.write(image, "jpeg", sos);
        } catch (IOException e) {
            if (getDevMode()) {
                throw new RenderException(e);
            }
        } catch (Exception e) {
            throw new RenderException(e);
        } finally {
            if (sos != null) {
                try {sos.close();} catch (IOException e) {
                    LogKit.logNothing(e);}
            }
        }
    }
}
