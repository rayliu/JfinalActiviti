package com.jfa.controllers.codeGen;

/**
 * Created by a13570610691 on 2018/4/18.
 */
public class GenVO {
    public GenVO(String tableName, String type, String packagePath, String className, String htmlPath, String pageShowType) {
        this.tableName = tableName;
        this.type = type;
        this.packagePath = packagePath;
        this.className = className;
        this.htmlPath = htmlPath;
        this.pageShowType = pageShowType;
    }

    String tableName ="";
    String type = "";
    String packagePath = "";
    String className = "";
    String htmlPath = "";
    String pageShowType="";
    
    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPackagePath() {
        return packagePath;
    }

    public void setPackagePath(String packagePath) {
        this.packagePath = packagePath;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getHtmlPath() {
        return htmlPath;
    }

    public void setHtmlPath(String htmlPath) {
        this.htmlPath = htmlPath;
    }
    
    public String getPageShowType() {
        return pageShowType;
    }

    public void setPageShowType(String pageShowType) {
        this.pageShowType = pageShowType;
    }
}
