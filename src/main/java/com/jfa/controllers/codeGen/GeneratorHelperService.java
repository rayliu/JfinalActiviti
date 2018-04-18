package com.jfa.controllers.codeGen;

import com.google.common.base.Joiner;
import com.google.common.collect.Maps;
import com.jfa.controllers.leave.LeaveController;
import com.jfinal.kit.PropKit;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

import static java.lang.System.getProperty;

/**
 * Created by Ray Liu on 2018/4/17.
 */
public class GeneratorHelperService {
    private Log logger = Log.getLog(GeneratorHelperService.class);
    private String projectPath = System.getProperty("user.dir");


    public boolean allTables(String dbname) {
        String sql = "SELECT TABLE_NAME as tableName,TABLE_COMMENT as tableComment from information_schema.`TABLES`" +
                " where TABLE_SCHEMA=?";
        List<Record> tables = Db.find(sql, dbname);
//        for (Record item : tables) {
//            Object[] arr = (Object[]) item;
//            TableInfo tableInfo = new TableInfo(arr);
//            boolean success = generateCode(dbname, tableInfo);
//            if (!success) {
//                logger.error("generator code table=[{}] fail", item.toString());
//            }
//        }
        return true;
    }

    public boolean oneTable(String dbname, String tableName)  throws Exception{
        String sql = "SELECT TABLE_NAME as tableName,TABLE_COMMENT as tableComment from information_schema.`TABLES`" +
                " where TABLE_SCHEMA=? and TABLE_NAME=?";
        Record table = Db.findFirst(sql, dbname, tableName);

        return generateCode(dbname, tableName, table);
    }

    private boolean generateCode(String dbname, String tableName, Record tableRec) throws Exception {
        String sql = "select COLUMN_NAME as columnName," +
                "COLUMN_TYPE as columnType," +
                "COLUMN_DEFAULT as columnDefault," +
                "COLUMN_COMMENT as columnComment," +
                "CHARACTER_MAXIMUM_LENGTH as columnCharacterMaximumLength" +
                " from information_schema.columns where table_schema = ? and table_name = ?";
        List<Record> colList = Db.find(sql, dbname,
                tableName);

//        List<Record> columnInfos = new ArrayList<Record>(colList.size());
//
//        for (Record col : colList) {
//
//        }

//        createModel(item, columnInfos);
//        createOther(item,"dao");
//        createOther(item,"service");
//        createOther(item,"serviceImpl");

        createController(tableName, colList);
        createHtml(tableName, colList);

        return true;
    }

    private void createController(String tableName, List<Record> colList) throws Exception {
        String packagePath = PropKit.get("packagePath");


        String dir = packagePath+"/"+tableName;
        File file = new File(projectPath+dir);
        if(!file.exists()){
            file.mkdirs();
        }
        String templatePath = PropKit.get("templatePath");
        String filePath = dir+"/"+tableName+"Controller.java";

        Map<String, Object> data = Maps.newHashMap();
        data.put("className", tableName+"Controller");
        data.put("tableName", tableName);

        packagePath= packagePath+"/"+tableName;
        data.put("packagePath", Joiner.on(".").join(packagePath.split("/")).substring(15));

        createTempleteFile(tableName, filePath, templatePath+"/java/", "controller.flt", data);
    }

    private void createHtml(String tableName, List<Record> colList) throws Exception {
        String webappPath = PropKit.get("webappPath");


        String dir = webappPath+"/"+tableName;
        File file = new File(projectPath+dir);
        if(!file.exists()){
            file.mkdirs();
        }
        String templatePath = PropKit.get("templatePath");

        //list page
        String listFilePath = dir+"/list.html";

        Map<String, Object> listPageData = Maps.newHashMap();
        listPageData.put("pathName", tableName);
        listPageData.put("colList", colList);

        createTempleteFile(tableName, listFilePath, templatePath+"/html/", "list.flt", listPageData);

        //edit page
        String editFilePath = dir+"/edit.html";

        Map<String, Object> editPageData = Maps.newHashMap();
        editPageData.put("pathName", tableName);
        listPageData.put("colList", colList);

        createTempleteFile(tableName, editFilePath, templatePath+"/html/", "edit.flt", editPageData);
    }

    private void createTempleteFile(String tableName, String filename, String templatePath, String templateName,
                                    Map<String, Object> data) throws Exception {
        try {
            Configuration cfg = new Configuration();
            String path = projectPath+templatePath;
            logger.debug("DirectoryForTemplateLoading: "+path);
            cfg.setDirectoryForTemplateLoading(new File(path));
            cfg.setObjectWrapper(new DefaultObjectWrapper());

            //设置字符集
            cfg.setDefaultEncoding("UTF-8");

            //设置尖括号语法和方括号语法,默认是自动检测语法
            //  自动 AUTO_DETECT_TAG_SYNTAX
            //  尖括号 ANGLE_BRACKET_TAG_SYNTAX
            //  方括号 SQUARE_BRACKET_TAG_SYNTAX
            cfg.setTagSyntax(Configuration.AUTO_DETECT_TAG_SYNTAX);

            String filePath = projectPath+filename;
            logger.debug("生成文件: "+filePath);
            Writer out = new OutputStreamWriter(new FileOutputStream(filePath),"UTF-8");

            String templateFilePath=templateName;
            logger.debug("模板文件: "+templateFilePath);
            Template temp = cfg.getTemplate(templateFilePath);
            temp.process(data, out);
            out.flush();
            out.close();
        }catch (Exception e) {
            logger.error("process due to erro",e);
            throw e;
        }
    }



//    private void createOther(TableInfo item,String type) {
//        String path = getUpPath();
//        String lastDir = type;
//        if("serviceImpl".equals(type)){
//            lastDir = "service/impl";
//        }
//
//        String dir = String.format("%s/%s",path,lastDir);
//        File file = new File(dir);
//        if(!file.exists()){
//            file.mkdirs();
//        }
//        String templetePath = String.format("%s%s", localProjectPath,propertyMap.get("templetePath"));
//        String filePath = String.format("%s/%s.java", dir,item.getModleName()+type.substring(0,1).toUpperCase()+type.substring(1));
//
//        Map<String, Object> data = Maps.newHashMap();
//        data.put("modelParam", String.format("%s%s",item.getModleName().substring(0, 1).toLowerCase(),item.getModleName().substring(1)));
//        data.put("modellower", item.getModleName().toLowerCase());
//        data.put("item", item);
//        data.put("packagePath", Joiner.on(".").join(propertyMap.get("packagePath").split("/")).substring(15));
//
//        createTempleteFile(filePath,templetePath,String.format("%s.flt", type),data);
//    }
}
