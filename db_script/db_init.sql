CREATE DATABASE  IF NOT EXISTS `jfinal_activiti` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jfinal_activiti`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: jfinal_activiti
-- ------------------------------------------------------
-- Server version	5.6.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACT_EVT_LOG`
--

DROP TABLE IF EXISTS `ACT_EVT_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_EVT_LOG` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_EVT_LOG`
--

LOCK TABLES `ACT_EVT_LOG` WRITE;
/*!40000 ALTER TABLE `ACT_EVT_LOG` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_EVT_LOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_GE_BYTEARRAY`
--

DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_GE_BYTEARRAY`
--

LOCK TABLES `ACT_GE_BYTEARRAY` WRITE;
/*!40000 ALTER TABLE `ACT_GE_BYTEARRAY` DISABLE KEYS */;
INSERT INTO `ACT_GE_BYTEARRAY` VALUES ('2',1,'flow/leave.bpmn','1','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.kafeitu.me/activiti/leave\">\n  <process id=\"leave\" name=\"è¯·å‡æµç¨‹-åŠ¨æ€è¡¨å•\" isExecutable=\"true\">\n    <documentation>è¯·å‡æµç¨‹æ¼”ç¤º-åŠ¨æ€è¡¨å•</documentation>\n    <startEvent id=\"startevent1\" name=\"Start\" activiti:initiator=\"applyUserId\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"è¯·å‡å¼€å§‹æ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"è¯·å‡ç»“æŸæ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"è¯·å‡åŽŸå› \" type=\"string\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"validScript\" type=\"javascript\" default=\"alert(\'è¡¨å•å·²ç»åŠ è½½å®Œæ¯•\');\"></activiti:formProperty>\n      </extensionElements>\n    </startEvent>\n    <userTask id=\"deptLeaderAudit\" name=\"è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹\" activiti:candidateGroups=\"deptLeader\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"è¯·å‡å¼€å§‹æ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"è¯·å‡ç»“æŸæ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"è¯·å‡åŽŸå› \" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"deptLeaderApproved\" name=\"å®¡æ‰¹æ„è§\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"åŒæ„\"></activiti:value>\n          <activiti:value id=\"false\" name=\"æ‹’ç»\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <exclusiveGateway id=\"exclusivegateway5\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <userTask id=\"modifyApply\" name=\"è¯·å‡å•-è°ƒæ•´ç”³è¯·\" activiti:assignee=\"${applyUserId}\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"è¯·å‡å¼€å§‹æ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"è¯·å‡ç»“æŸæ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"è¯·å‡åŽŸå› \" type=\"string\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reApply\" name=\"é‡æ–°ç”³è¯·\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"é‡æ–°ç”³è¯·\"></activiti:value>\n          <activiti:value id=\"false\" name=\"å–æ¶ˆç”³è¯·\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"hrAudit\" name=\"è¯·å‡å•-äººäº‹å®¡æ‰¹\" activiti:candidateGroups=\"hr\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"è¯·å‡å¼€å§‹æ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"è¯·å‡ç»“æŸæ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"è¯·å‡åŽŸå› \" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"hrApproved\" name=\"å®¡æ‰¹æ„è§\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"åŒæ„\"></activiti:value>\n          <activiti:value id=\"false\" name=\"æ‹’ç»\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <exclusiveGateway id=\"exclusivegateway6\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <userTask id=\"reportBack\" name=\"è¯·å‡å•-é”€å‡\" activiti:assignee=\"${applyUserId}\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"è¯·å‡å¼€å§‹æ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"è¯·å‡ç»“æŸæ—¥æœŸ\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"è¯·å‡åŽŸå› \" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reportBackDate\" name=\"é”€å‡æ—¥æœŸ\" type=\"date\" default=\"${endDate}\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <exclusiveGateway id=\"exclusivegateway7\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <sequenceFlow id=\"flow2\" sourceRef=\"startevent1\" targetRef=\"deptLeaderAudit\"></sequenceFlow>\n    <sequenceFlow id=\"flow3\" sourceRef=\"deptLeaderAudit\" targetRef=\"exclusivegateway5\"></sequenceFlow>\n    <sequenceFlow id=\"flow4\" name=\"æ‹’ç»\" sourceRef=\"exclusivegateway5\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${deptLeaderApproved == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow5\" name=\"åŒæ„\" sourceRef=\"exclusivegateway5\" targetRef=\"hrAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${deptLeaderApproved == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow6\" sourceRef=\"hrAudit\" targetRef=\"exclusivegateway6\"></sequenceFlow>\n    <sequenceFlow id=\"flow7\" name=\"åŒæ„\" sourceRef=\"exclusivegateway6\" targetRef=\"reportBack\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${hrApproved == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow8\" name=\"é”€å‡\" sourceRef=\"reportBack\" targetRef=\"endevent1\">\n      <extensionElements>\n        <activiti:executionListener event=\"take\" expression=\"${execution.setVariable(\'result\', \'ok\')}\"></activiti:executionListener>\n      </extensionElements>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow9\" name=\"æ‹’ç»\" sourceRef=\"exclusivegateway6\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${hrApproved == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow10\" name=\"é‡æ–°ç”³è¯·\" sourceRef=\"exclusivegateway7\" targetRef=\"deptLeaderAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${reApply == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow11\" sourceRef=\"modifyApply\" targetRef=\"exclusivegateway7\"></sequenceFlow>\n    <sequenceFlow id=\"flow12\" name=\"ç»“æŸæµç¨‹\" sourceRef=\"exclusivegateway7\" targetRef=\"endevent1\">\n      <extensionElements>\n        <activiti:executionListener event=\"take\" expression=\"${execution.setVariable(\'result\', \'canceled\')}\"></activiti:executionListener>\n      </extensionElements>\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${reApply == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <textAnnotation id=\"textannotation1\" textFormat=\"text/plain\">\n      <text>è¯·æ±‚è¢«é©³å›žåŽå‘˜å·¥å¯ä»¥é€‰æ‹©ç»§ç»­ç”³è¯·ï¼Œæˆ–è€…å–æ¶ˆæœ¬æ¬¡ç”³è¯·</text>\n    </textAnnotation>\n    <association id=\"association1\" sourceRef=\"modifyApply\" targetRef=\"textannotation1\"></association>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_leave\">\n    <bpmndi:BPMNPlane bpmnElement=\"leave\" id=\"BPMNPlane_leave\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"10.0\" y=\"30.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"deptLeaderAudit\" id=\"BPMNShape_deptLeaderAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"90.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway5\" id=\"BPMNShape_exclusivegateway5\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"250.0\" y=\"27.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"modifyApply\" id=\"BPMNShape_modifyApply\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"218.0\" y=\"108.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"hrAudit\" id=\"BPMNShape_hrAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"358.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway6\" id=\"BPMNShape_exclusivegateway6\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"495.0\" y=\"27.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"reportBack\" id=\"BPMNShape_reportBack\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"590.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"625.0\" y=\"223.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway7\" id=\"BPMNShape_exclusivegateway7\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"250.0\" y=\"220.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"textannotation1\" id=\"BPMNShape_textannotation1\">\n        <omgdc:Bounds height=\"57.0\" width=\"120.0\" x=\"361.0\" y=\"174.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow2\" id=\"BPMNEdge_flow2\">\n        <omgdi:waypoint x=\"45.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"90.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow3\" id=\"BPMNEdge_flow3\">\n        <omgdi:waypoint x=\"195.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"250.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow4\" id=\"BPMNEdge_flow4\">\n        <omgdi:waypoint x=\"270.0\" y=\"67.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"270.0\" y=\"108.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"280.0\" y=\"67.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow5\" id=\"BPMNEdge_flow5\">\n        <omgdi:waypoint x=\"290.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"358.0\" y=\"47.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"300.0\" y=\"30.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow6\" id=\"BPMNEdge_flow6\">\n        <omgdi:waypoint x=\"463.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"495.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow7\" id=\"BPMNEdge_flow7\">\n        <omgdi:waypoint x=\"535.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"590.0\" y=\"47.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"544.0\" y=\"30.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow8\" id=\"BPMNEdge_flow8\">\n        <omgdi:waypoint x=\"642.0\" y=\"75.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"642.0\" y=\"223.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"652.0\" y=\"75.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow9\" id=\"BPMNEdge_flow9\">\n        <omgdi:waypoint x=\"515.0\" y=\"67.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"514.0\" y=\"135.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"323.0\" y=\"135.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"525.0\" y=\"67.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow10\" id=\"BPMNEdge_flow10\">\n        <omgdi:waypoint x=\"250.0\" y=\"240.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"142.0\" y=\"239.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"142.0\" y=\"75.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"44.0\" x=\"152.0\" y=\"221.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow11\" id=\"BPMNEdge_flow11\">\n        <omgdi:waypoint x=\"270.0\" y=\"163.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"270.0\" y=\"220.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow12\" id=\"BPMNEdge_flow12\">\n        <omgdi:waypoint x=\"290.0\" y=\"240.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"625.0\" y=\"240.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"44.0\" x=\"429.0\" y=\"247.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"association1\" id=\"BPMNEdge_association1\">\n        <omgdi:waypoint x=\"323.0\" y=\"135.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"421.0\" y=\"174.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('3',1,'flow/leave.leave.png','1','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0Á\0\0\0\0\0h\çÊˆ\0\0FÀIDATx\Ú\í˜T\Õù‡G4Š\Æ»1‰=šÄ \ÑcŒbŒ&–$þQga\Í\ZÁ‚\Z)‚RDPˆ¨4‘\"\nŠB6¤ƒ\é M! ô\" ½œÿù\Ý9w¹;\Ì\ì\îl›™\Ý÷}ž\ï¹\í\Ì\ì\Ý{\ïw\Îo¾ûsB!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0€8cª.[¶l\å”)S\Ì\èÑ£\ÍÈ‘#±4°Q£F™	&´Öƒ§¨/0\êÀ?ñO(e\ä0\'N46l0{÷\î\Å\Ò\È6n\ÜhÆw\Ð:P\'žT ¾À¨/\0ÿ\Ä?¡\Ñ/F&½\Çþ’\ÜË“\n\Ôõ\àŸø\'”\"ze\ÂÃ™Þ¦\×)<©@}Q_\0þ‰B)¢Âƒ‰\Ó\0P_P_\0þ‰\áŸ8M\Ûñ\ÍZ³lú«fÁ¨6ži]ûx¨q\Z ¾ ¾ ¾\0ü\Ã?+¤\Ólß²\Ú\Ì\Ñ\Â\Ì\Ö8ŸiŸŽñ`\ã4i\Ä9\\\ê\ê|\Zÿ\Ä?ñO(§Y¹\à½\ÃÆ·U\Þ\çÁ\ÆiÒ…\\k\Æ-ú‚úŸ\Æ?ñOüJ\æ4‹\Æ>›\ÐitŒ§IšX;hm–[¶\æ’P_P_\à\Óø\'þ‰B‰œfþ\ÈV	F\Çx°qš4i,[¢Gh4©/¨/ðiüÿ\Ä?O>ù\ä9Ý»wÿ¤mÛ¶;sssÔ¯_\ßÔ®]\Û\Üu\×]ž\Ýw\ß}¦I“&Û´i³Ë–[Ø²e\Ë\ëq\Zœ†F-£\Z\Ë\Âö§Æ˜\ë­O}Q_d¾O§ÚŸñOü3.O?ýtóV­Z\íªS§ŽiÑ¢…y\çwÌ¼yó¼A¥÷\ï\ßo|6m\Úd/^l†n:u\êd²³³%Š÷\Û\Ïô¯^½z\Õ\Ê*‚\Õ{4‘\Ó\è6ZŠ\È-¤Qô\ç–C\ãwT\Ó\ÞÓ¾\É}uÎºx¦c*£²=&›Q‡}=K\Öø\å\É;[˜¿\Ò\ß\Ö1\ê¬\×i\áÓ™\ê\Ïø\'þ™\r\Zü¾Y³f»\êÖ­k\ì‰\ÜdØ·oŸ™4i’\'œ\ë×¯À~\ÏÓ•Q/™\Ô5¡\Ó\è6Z\n\Ë\Â\Z\Ãr‰©Al\Öoö†D\ÇuLe¬i­\ÎrcZ5\ï;k£]ÿ‡¬iï™›w\ÓD\ÇT†ú«„õE\Úøt¦ú3þ‰\æa…\ë\à{\ï½×¼ö\Úkf\çÎ¦¤LŸ>\ÝÔ«W\Ï<ø\àƒk#‘\È•IoZ=\Ï\Ìÿø©\Ã_\Ø}:ÆƒM£–¢×¥¹eT¾Ø\æG[LoE‚‚6|‹\éh4o\í5\Õ|\\©õV\Éê‹´ò\éLõgüÿôx\â‰\'>ô\ÐCf\æÌ™¦4Ù¶m›\éÖ­›\É\É\É\Ù\Çw\\ZYD°lùŒ\×s\Z\íã¡¦QKQcÙºŒ\ÙbGŽ\ìúAFŽ\ÜñšM{O\ß\Òñýõs‚¦}:F}U²ú\"\í|:Sýÿ\Ä?=üð\Ã{ù¾e\ÅÀM:u\Þy\ç7T\n¼gY2¹\Ç\á¯N\ì>\ãÁ¦QKóÆ²\Ì_£Í†\Ý\'\î\í3\Ã—5\ê>q,\Ðh\ÖiúÊ§[Ÿÿxç” iŸŽQ_`•¨¾HKŸ\ÎT\Æ?+¹*B\à²À>\ï¾û®„p\ÆG„s\Z\Í óÅ¤.	sˆtŒYfh\ÔÊ\ÜRj\ìrËº\ÑTÇ™¼?öÚ¼µ•IS_P_TŸ\ÎT\Æ?+±ªœr€\çÌ™cÊ‹7\Þxc\íÚµ\×fò\È	\Æþ\"\\»dŒùlxó„\ã›Ê¨,¿\"Áe\ÜX–\Ök\Ï&e\Ùh6\ì:þ\ÛvCW,”i=¶ÑœaLG»~\ácZ\Û\åCo1½\ìòkWo3¦õV	ê‹´ö\éLõgü³û\çO<±[\àÊ›G}ô@8T‘Dpa¿ùI£–‚×¥~cY\ÅZ/·L†\ØÏ•j>aL\á©AÓ¾f}g~\í:\Ò\\¥\Î5vy‘‹*U\í2v\ß»¼e\à3¨YŸY*w\rõVë‹´÷\éLõgü³’ú§\Æ\Ö0h¥1\nD²¬^½\Údee´Bø¢Š\"‚‹òk± _‘<\èˆ\à2Šî¨±û\\\í’[VI¢±Œ÷¹Rm4ƒ¯Mûÿñd¿9\ë5d’Û¾\ÇEª\Æó©7}\Õ\ê\Í\Å_ºô_\ÖnL\ç\Îq\Ô\Ô•Á§3ÕŸñ\ÏJêŸšcÈ!&Ut\è\Ða\Ï]w\Ý5¥¢ˆ\à\â:Œo<\èˆ\à2z½\Ù\Ë5z&‰F3\ØXú\Ö3\ÎkY¦c¥¾ ¾À§ñOü3³üSS!k&¸d\'\Â(\åhð+‚fbnpQ‡TÁh\ÔÊ‘DX¼Æ¯ F³¨å›„\Â\Ô\Ôø4þ‰ešö\è\ÑcŠftK5<ðÀ\ÞH$R§ÁÁ¡ýQ¸©˜þPX‡™¢6‚\É6®e>¡FE¸_\Ô•·¾À§ñO,\rý³mÛ¶;\ßÿý”‹\àÎ;oK§”œ§Iñógœm\n‡\Ãu“|]ZX£UXc˜lcüû*cD¸¨÷‹ú¢R‹`|\Zÿ\Ä\Ò\Í?sssÌ›7/\å\"x\êÔ©»¬\èÜ‚\Ó`ˆ\à|ÏŸoùQ–\ì\ë\ËD\âQ\Ål,{m[YDp÷‹úŒO\ãŸX\Zùgýúõ\ËerŒ\ÂX·n\Ý~ûPÀi0Dp\Ü\ç/\ïGYœç°¸ù{ñ\ZÍ½%h,Kz>IÇ½_\Ôˆ`|\Zÿ\Ä\Ò\È?k×®mö\ï\ßo\Ò=”8M\Ñm×®]fÇŽñg¶Ù¾=©\ïÚ½{w¾\í­[·ù³\ß|ó\r\"¸üž¿¼e\î\rEI£4ñ\ZÍ’4–É¾Æ­\è\"8\ßý*­ú\"]|ß·D\çk{ö\ì1\ë×¯÷–E)¯²w²ÿkšŠ`|º‚ùg&ûraV>—Rÿ\Ô.dˆN‰Ó´n\Ý\Ú<ýô\Ó\Þz×®]•CmjÔ¨aªU«\æ­Ë¾ø\â‹\è.s\çš\ÓN;Í´l\Ù\Òüõ¯õ¬K—.^y{Íš5ùD\ì…^hÆ\çm+=\æ\ÄO4«V­*°\Ñ[»v­iÞ¼¹ùóŸÿ\ì­\Ëz÷\î÷7d£FJ¹.Â½\ÌH\Óýt\rÛ¬>\îGÅ‰\íuûKÂ¬Šz\í‹kÅ©/\Ò\Í÷c\íó\Ï?÷ž™x\r¹Ž5i\Ò$\Ïy\ä¯¬–Áý*§1\ãœg76\'œp‚4hP¾ý¾0þð\Ã½s\×úO~ò\ï\ÚJP\èû—.]š‘õ>yþ™\é¾ü\Ì3Ï˜H$\â­ýõ×¦OŸ>\Þú1\Çãƒþ\æüùó‹uND‚‹!‚qšøöé§Ÿš3\Î8\Ã<÷\Üs\Þøøã›?þñ\æ‚.ð\Ö5jd,X\à•}ø\á‡\ÍW\\atoÿþ÷¿›¿ý\ío\æþû\ï7šP\"U\âò\åË½²3f\Ìðœñ¶\Ûn3\×^{­·~ýõ×›\Ë/¿\Ü[\×ñx\ç£Î”±Q†\ã?\Þ<ö\Øc\æOú“\éÞ½»©R¥JžC	.µa;ì¯Ö\áK:}*Q£r¼_Å©/\Ò\Í÷cm\áÂ…ž¯\Ç;¶l\Ù2¯‘}ò\É\'=kØ°¡wZúût\\\åtmŽ=öXs\Ã\r7$´\ï|\ç;fÒ¤IÞž}ûö5\çž{®ùò\Ë/\Í\ÙgŸmFŒQ*\"8‘`|:ƒý3“}Yod\Î?ÿ|\Ï\ïN?ýtóüó\Ï{\ç7zôhO¿û\î»\ÞQùg²\çDNp’lÜ¸1\Ýs‚S\â4A\Ó/DE[_x\á\ïÁ=õ\ÔS\Íq\Ç\ç­_y\å•y¿õ\ëOZ=¨š	ðž{\îñT«\ZŠ\àƒ*g<\ï¼ó¼r\Ù\Ù\Ù\Þ1-µ­ý:ž\Èyzö\ìi^ýu\ïõHƒ\r\Ìð\á\Ã=ü\ÐC™šs\Î9§È¯=Á…>±\r%ùƒx¿Š[_¤“\ï\Ç\Ú\ÇlŽ<òH³yó\æ¸\Ç\ßz\ë-\ï\\ó›ß˜_ý\êW\Þ\ß\ÑR\ÛÚ¯\ã*7a\Âs\Í5\×\ä{•«o0’¥~ö\ìÙ¦W¯^\Þ\ß\Ôw©¡Á}ô‘†\Ý,0\"\rD0>]Aü3S}YoSŽ>úh3f\ÌO(+Šû\Ê+¯x\âWûûõ\ë\ç}V~•\ì9e\Òdõ\Ë#F‡°\æVœ\æpkÛ¶­\ç¿ÿý\ïÍ¬Y³\Ìw\Ü\á\Ùe—]f\Î<óÌ¼mýS\ã QŸÑƒª_u—\\r‰÷\ZF…>#ó=\à?ÿùÏ½[VŸ\ÕR\ÛÚŸ\Èy\ä/¾ø¢\×h-Y²\Äû%9mÚ´<|ë­·š\'žx‚œ\à’?\Û\í\ÃöE˜H&\Ù(\r=\ÉSp¿’­/\Ò\Ñ÷cM‘&}VõA\"|\Ê)§x\å?þñ¯¬–\Ú\Ö~_\ËÔê’o*û\Ý\ï~7o[§`\î§CH\ë5\í¿þõ¯¼·RÁ\Åi\ËA\ã\Ó\Ä?3Ý—•š!ß¹ýö\Û=›3gN¼·fúô\éIŸSF¬\Ê$M\Æ	ž†\Ón—/½ô’÷zB¿ \Õ\Ø(§.hzØ•T¯^=\ïõ…ÿ *B»xñb3e\ÊÓ±c\Ç<ó_o\È9ô w\è\ÐÁh\Ò=\äZj[û9^\å\Äs–û\î»\ÏÁŠò\è\Õ\n\"¸\Ø\Ï_AQ¢’Fk\ÊjL\Ñ\ìP\å\'¸H÷+\Ùú\"}?\Ö\Ô\'\à\Ç?þ±ù\éO\Z÷\Í\ÏÄ‰½úB¦<_ý-ý}S§N\Í\'l¹RŠÃ¢E‹¼²:®í«®º\ÊÁ²Š+ˆ£†ü\ßÿþ·wô-\Ó0Ÿ®`þY|YoV\á•/JÀê³Ÿ|ò‰·.S€K\"8\ÙsÊ˜ö¼[·n\ÓÛµk—rüð\Ã\ï±b³N“8\ïNÎ£õ\Ü\Ü\\/\âõë®»\ÎK¬÷_µ(I\ÝPõ=¸jtŽ:\ê(\ï‰\"+z\È}\çQ¢©³kÖ¬\é9€–\Ú\ÖþDÎ£\×#z\r:lØ°<“£ø‘\à\Ï>ûÌœ|ò\ÉfÅŠˆ\àò¥°¨MY\Ï.\Õ>¥Z_¤›\ïM\rö÷¿ÿ}/÷‡?ü¡ù\àƒ+Ó¿\ï|dw\Þy§÷w´Ô¶^û…|a{\ÄG˜\ï}\ï{ù\"Á\ÚVúƒ/‚\'Ož\ì\å$ê¸­§3\"\'Ÿ®˜þ™É¾<s\æLï­Œ„\î\Í7\ß\ì¥8\ê³z«¢\è´Lþ¨¶=\ÙsÊ˜ö¼Q£F—\ê\"\ìÜ¹3•cP\ïÄœœœqš‚GC \Èyôú¯”T\ï;,ø ¶i\Ó&oÿM7\Ý\ä\íW¤Å\Ø\èW r€d\ê™*\Ð\Òß§\ã‰\ÎI¯2\å`]t‘·®{\è‹`Wª„œ\n\\\î$Š%\Ûµ<¸Dp:ù¾lÛ¶mæ·¿ým\Þ\ß\Ñ\ëR“¢\\~5¾—^ziž]|ñ\Å\Þ\ß\ÑR\Û\'tR^G!_K+7Q%•Õ«cm_}õ\Õy\"X£\ÎH\ëÿ÷\Ó!*°Æ§+˜N_V*£Þ HÌªÓ›üOŸ2dˆ¹–U­Z\ÕÁÉžSFµ\çM›6Ý§^ü©¢k×®;\í¯ù\Å8MÁÎ£žÑ·\Ür‹×£úw¿ûiß¾½gJNO\ä<úŒ’\î\ß|óM¯7µzqû‘Eh”\Ë\ã›^›\È´\îW¹D\"X¯Bü_µ¾\Ö/B‰_5fj˜Á)‹Å¾\Æ\ìUŒ×¡ñ\ZÍžID© Dpºù¾‚&òw¥#lÙ²%oŒ\Ò_ÿú\×^¢Ÿ‹«!—†šw¾ÁWµ\ÚVOs\Ûþx\å|Š?ªg±\éÁœ\àXÜ¬Y3oHµ\nT_\à\Ó@§›/\Ë~ðƒ˜ñ\ã\Ç{>¬\Ïþò—¿ô~\à\Êô·\â‰\à‚\Î)\ã\Úó\'žx¢‹†\æH\ÅPiªL³²²Ú‹z%N“Ø”n ‡SI”7t½òH\ä<º¯jô\ÚR¯[ôrÀu\ë\Öy\rE0ATt\\\Ë\àþDQ‰\à{\ï½\×sfõ\ÚöEðƒ>\èý\rý²LõÀÚ•X³\Ü8_2c}®R\rƒ–ªú\"\Ý|_û”Ÿ«N>±`4\Zƒ\"¶guV\ÞØ¢Š*iø\'™\êýJ\ä\ï^CªúDck\Ô\"•U´J\Û\êM¯\á\Ñ|Á­\ÆW\"X)WJ¨U«–7Üš>3v\ìXó‡?üÁ½¦‚\Õøt·\ç\éØŽ\ë-‹Ò4¼šþ–>«||ßŸ%v•6‘\Ì9ed{n+¥\êÀP\Þ\Øºû®»îš‹\Ól\êü¡\×~\ÔUBS\ë\ï½÷ž÷\0ÿóŸÿ,ð5ŠR”;§\ïÑƒª\ïˆýz©9ø:³ “VoVõ\ÂV(6‚\ã\Òò5jõIvˆ¤\Ø\Ï\å†À\åR_¤›\ï÷\è\Ñ\Ãk0ýp¬i¿:\Ë\Å\nP\åJ¬\êµo\ì\ÌV‰¾G\ç¤Nq±\ÇþóŸÿx¹ŠŠžih5¬\Ý\É7\Þx£÷9\r\Ñø\ÕW_U\ÄúŸ\Î\Ðö<\ÛqýÕˆ\ê´\çV\"X?H•\ë+?ò\'\Â)\î9eD{^¯^½f\êý§Š§¼˜5kÖ¾¬¬¬}V<\Ó\Ýô ú½þ‹ý\å¥\\:Í¾¤Àw„7\æ\ã7\ÞtŠú.õ\ÄÖ²(ç¡¿\ãGzµ\Ñ\ß\Ô/Ç²þ%ˆ.q£Y¯e¡\ê‹tñý\ÂDl¼\ã\ZGX\çUìŸ«r\ã\ÍD\ï.¶¸¹‰R_\à\ÓÞž§‹/ÇšþžÿYE‰ƒþZ\ÜsÊ˜öüX¥WN\å‘¡‹«4ˆZµj5Ái0Dp\Æ4š•n\"\ê\ê|\Zÿ\Ä*j8°{\î¹\ç[½\Æ*K5\Ì\É\É\ÑqCq\ZŒF­\Ü(\é\ëNR ¨/¨/ðiü«¸þ‡/ªS§\ÎAuf(«°ð]w\Ý5§Áh\ÔR\Öh&õ¡õõ>b\ß?5Rƒ\Âûûö\í{ r€V„0Nƒ\Ód0É¾þ\äu)õõ>b•\Ç?¶bx­FPtI‡A\Ó(\ê—\é9À8\rNSÉ„pvˆ‰0¨/¨/ðiü«Œþi\Åð +^<ýô\Ó{–-[v Ù™\àºw\ï¾S\Ñ_û=2yœ§©€–\è÷§±¤¾ ¾À§ñO¬rú§\Ä\ë]w\Ý5\Î\Úþû\î»ooÇŽ·3f\çŠ+ò\r#±iÓ¦S§N\ÝÕ¹s\çm?üð«™\à2u\"œ§©\Äa^—R_P_\à\Óø\'†\ÆD†\ë:A¼\ÑÚ·ÖŒoVô°\Ë\íÖ¦\Ùõ999\'\â4Z\Æ5š4–\Ô\Ôø4þ‰áŸ€\Ó\à4•JÏ¢±¤¾ ¾À§ñOÿœ§©L\ä\êN¨¨C&S\ÅsqÑŠš³\ëg\ê³\Ôõ>b´\ç8\r†Ó¤®Á,b{i\Îh3ðóeZi\ì®Or_›·6höøC®\\½Nmž\á\ÖOh\Ôc\â\î=\Æ<n\×\Ã\ÖN¥¾À¨/\ÊM€…O\ãŸø\'\à48\r”¢¶\r\ÝM£¶›—›öšþ\Í:crs,X­4^\Ù6ƒ–.µ\Çn±vòó\ïœ\Òú­%ÿ{}®y\ïñ\î÷\Ú}WR_`\Ôe\Ã\Í7\ß|>âŸ€\Ó\à4Pº\"ø\Öw×˜×š¾2u\Û\"cžQƒ\Ù:d…yS6|‹\é\ã\Ê]\ØfÐ²/f\Óñ™¡k>k\Øuü·›iú\æ\"3\ä©‹Vú‘%\êŒú¢ô\É\Î\Î>Ÿ\Æ?ñOÀip\Z(E|uª×¡j0—\ÓZ¯DeM{Oß¢2cö˜\îj\ï1Á\î6—5\ê9eû»+Mÿ&¯D—Ú¦¾À¨/\ÊÌŸÏ²vŸ\Æ?ñO(FÍƒ‰\ÓT>\í@SOQ gþûÕ¢\ØW§\Êô\×\ÕhN1\æyo¿-\ç½Nuy‡þ6õF}Qú\ä\ä\ä\\‡\â\Óø\'þ	e\ÂÄ‰lØ°‡3MmÕªU_Y§\ÙË“Zº\"XŸï®÷\Ô‹¾ò>­«!”)7\ÐE–®n\ÜsÊŽ\Î#¶Mýx‹\éÕ¬ÏŒM­\Þ\\ü¥¢JZ>\Ùo\Îz\êŒú¢l¨]»ö\ÅÖ§\à\Óø\'þ	eÂ˜1cž7n\ÜÁõ\ë\×ó¦¡ÃŒ\Z5\ê[kxRK9\Êß“\ÜE.V\Ïpg\'»2™oL»<\Ï\ÚQ±Q\"÷™[©/0\ê‹2ñ\ç\Ë5\Ó+>\âŸPfØ›\Ò\Úþ:Ù¡0}&\ÛÀ½™ÿ2ýÿ\Ø^¦LEð™1\r\æqÊœ§5Š(õ™a†\ç¾:g\Ýw\\ðµ\êˆ\í¦\'õF}Qú„\Ã\á«4³+>]yý³¨múð#Íˆó\ïûpxtl\Ùa\ÃñO¨˜hFcKr5Á…4–W«ñ°À¼£m¯1ŒST\Ã-\Ùr\Ì0¦“]ž®r™ÿ>\ÙoÞº–o,\\!\Ó\ëW{\ìG\\y€\Ò\'‰\\g}z>M^JoqþSí²½†ÀÓ°w\ê©6v»†{Nþ¡!òd-\Ì_™ûú¼5úQ¤õf}f}mÿŒ«™1¨+gq–\Ë¡\Â€ŒÁ7UC\å­\Ó5\ZH\Ãn\ã÷yù\ß\Ñ1 ¯ð\Ç~^eL‹fýfoP\ê‹Ê¶\Zøùr\í\Ó&m\Óa\Ú\rY½ ²ý\ÇQ\ÖDð®&\0d¼?\ßjmW‚:½ &0]{L6£•\Öb­ªµk.6ƒ[\\øÕ‹#·MÑºRe¬]\Ú\à¥1vaª5}\åÓ­\Ý\Æ;®\ÉË“wZ\ÕÜ¶\Ë\Ø}´Ž†Lt’\ì€\0ö,·\æ\ÊPa@æ’••U\Ãúôn®uzA(\Åaðr3ð±®\ãöK\ÌN8`º<÷þúÙš4E\æ\"Á\×Kô6\è2\î€Dpó¾³6ºYo”8v\ë2\Ò)!\ãœd]¬V4˜\Ü`*L\0\È\\\"\ëÓ»¸\Ôé…ˆ\àÁ\ÕpwZ*÷»¹]W~·¬Q‰»%‚½|à·½t‰jš¥\Ý\Ð•®\áñ”¡	S\ì±W2\ÉA²\ã`\ÏlýÙž+D…	\0]¿“\ÞF^˜¾½ã°¯g=\Þuü·Zj\n\ì¡k\Ì\ëþðx\Ï]©\\\ß\ëU\ÖÁ\Í_£\èp5k\ç(b1Í•/l·\æªC&9\È\ÆD\"\Ø\Úv®&\0d&®\Ã3õ8uz‘ð;»)¢i¯\éß´´\ìY\Ã\î÷ÆŠ`/<hù\ç¯\Í5\ïji\å÷ži>\äŠC¦E	LAFn0&\0d&‘H¤¾õ\é­\\	\êôB1¦J\Ó\Þ37+\n\Üc²\ë9^$\Ø\å	Ÿ¥¡òv\ÓD£Ktüh\Ót	€LpŽu…‰`^¥Qa@ÆŠ\àÖ¶p%¨\Ó\×À\æ\Âg†®ù\Ì.³&ó‚\Æ\Öþ\ç>øz¦¦\É\Ö0jA\ìG5Žp›AK—hô\å÷›m\Þ\çª\"¸ÿ\0RjÕª\Õ\Äúô&®uzi‘—ókL•|K\0¸ÿ\0.dee5‡\Ã¹\Ô\é\0€\Ã\0÷ 2ùs+k\ë¹\Ô\é\0€\Ã\0÷ 2ùó3\Ö\Ör%¨\Ó\0‡\î?@¥!++«c8^Å• N\0¸ÿ\0•†H$\Ò\Ùúô\n®u:\0\à0Àý¨Lþ\Ü\Õ\Úr®u:\0\à0Àý¨4„\Ãáž‘Hd)W‚:\0p\àþT\Z¬\0\îk}ús®u:\0\à0Àý¨LþüºµE\\	\êt\0Àa€ûPi‡\Ã­O\Ï\çJP§\0\Ü€JC$l…ð®u:\0\à0Àý¨LþüŽµ™\\	\êt\0Àa ÿ½^§û]ˆ\í\àJd¬¿om\ZW‚6\0p\È¯³Á\áp¸5W\n 3±þ;\Üúñ®m:\0\à0pøý\ÞX€\Þ^½zõª\\%€Œõ\ïQ\Ö&r%h\Ó\0‡\Ã\ïw\Âhp$i\Ï\Èhÿgm,W‚6\0pˆ\Ï\ã\å\ï \nñ¾ýI8É• M\0\â\ßólr*¤oOQ^0W‚6\0pH|\ß\×¨p~=M#Dp%h\Ó\0‡„\Ã\áºœ\Ë¨~=+‰\åJÐ¦\0\ß{/7˜(0@…ñ\é¹V\âJÐ¦\0\ßûl\î?@…ò\éùV\äJÐ¦\0S\êcª.[¶l\å”)S\Ì\èÑ£\ÍÈ‘#±4°Q£F™	&´Öƒ§*q}¾\È\Ú\ë\\	\Út\0ÀaJ	\à‰\'š\r6˜½{÷bid7n4\ãÆ;hq\'žT¨ŒD\"‘/jÕªÕ‡+A›\08L©£08½…ðÈ‘#÷ò¤B%­\Ïÿ‡_\æJÐ¦\0S\ê(±™Þ¦ôžT¨¤õùrk]¹´\é\0€Ã”:XMD0@š\Ö\ç+\"‘Hg®m:\0\à0)Á;¾Yk–M\Õ,\Õ\Æ3­k\"P†õù\êp8üW‚6\0p˜”ˆ\à\í[V›ù#Z˜¹\Ã\Z\ç3\í\Ó1„*\" Œ\êóµ‘H\äi®m:\0\à0)Á+¼w˜\0ömÕ‚÷ªˆ`€²ª\Ï\×[kÅ• M\0&%\"x\Ñ\ØgŠ`C¨\"‚Ê‚p8¼1++«9W‚6\0p˜”ˆ\àù#[%Á:†PE”Q}¾\ÉZ#®m:\0\à0ˆ`D0@¥!o±uú¿¸´\é\0€Ã¤Dk4ˆD\"X\Çªˆ`€² ‰l­U«\Ö\\	\Út\0ÀaR\"‚—L\êšP\ëBPFõùöp8\\—+A›\08LJDð¦\Õó\ÌüŸ:<\Â\î\Ó1„*\" Œ\êóÖ²¹´\é\0€Ã¤DË–\Ïxý0¬}ˆTD0@Y‡wÕ®];Ì• M\0&5\"x\Ï³dr\ÃS!\ì>C¨\"‚Ê¨>\ß]«V­Û¹´\é\0€Ã”»ÖŒp_L\ê’0\'XÇ˜5PFõùk·r%h\Ó\0‡)?¼gY»dŒùlxó„\Ø7•QY¢Âˆ`€R®\Ï÷E\"‘¹´\é\0€Ã”‹.,úKTPNõù·µjÕº–+A›\08L¹ˆ\à¢DŠ\n#\\Á\0¥TŸ\ï·ö[®m:\0\à0\å\"‚‹+€}C¸\"‚JQ_Î• M\0¦\\D0†H“úü@\íÚµ/\æJÐ¦\0ƒF\Ç{æ³­­\ái†\nXŸ‡\Ãp%h\Ó\0‡A#‚c\Å\ï:=ó<÷P±ø\à\Ýw\ßý#®m:\0\à0ˆ`Dða\â¹>\Ï\Î\Î>+A›\08\"¸‹\àp8\\Wi±\â¹>¿ù\æ›O\àJÐ¦\0“¶\"x×®]fÇŽñgÛ¾=©\ïÚ½{w¾\í­[·–º°\Ôù\îÜ¹3o{OMôQ\Ðu)ª\r8\ÐÄ‹ü\"‚¡2\Ô\ç5k\Ö<š+A›\08LZˆ\àÖ­[›§Ÿ~\Ú[\ïÚµ«\éÜ¹³©Q£†©V­š·.û\â‹/¢Ã­ÍkN;\í4Ó²eKó×¿þÕ³.]ºx\åý\í5k\Ö\ä}÷7\ß|c.¼ðB3n\Ü8o{Þ¼y\æ\ÄO4«V­*ðœÚ¶mk:u\ê\ä­ÿ\ßÿýŸ¹\å–[³\éÓ§›>ú\È\Üw\ß}\æ\Úk¯5]t‘·.‘iZs÷\Ýw{W¶~ýú\ÃþÆ†\rÌ‘Gi¾üò\Ë_—d¬0ñ‹aÙ¨¥iÓ¹\n\08LÚˆ\àO?ýÔœq\Æ\æ¹\çžó\Ä\í\ã?nþø\Ç?š.¸À[oÔ¨‘Y°`Wö\á‡6W\\q…©]»¶ùû\ßÿnþö·¿™û\ï¿ß¼ö\Úk¦w\ïÞºWfùò\å^\Ù3fx\âñ¶\ÛnóDªÖ¯¿þzsù\å—{\ë:ž\èœ&OžlN9\åóê«¯šc=\Ö\ÚO=õ”\'r\ß|óMó\ãÿ\Ø>\ÜÌŸ?\ß<ðÀ\Þ÷ÿô§?õ\Ö_|ñES¥Js\Ýu×™_ü\âžhŸ2eŠ÷½|ð\'le¹¹¹\Þù6i\Ò$oŸŽ\çº\'¢V­ZM\ìó½±\0\0´\é\0€Ã¤@\Ë\Ñ\\»v­y\á…\Ìù\çŸoN=õTs\Üq\Çy\ëW^ye^TWQ\Ü\æÍ›{\"¸nÝº\æž{\îñD°þ\îˆ#ò‰`‰\Çó\Î;\Ï+—\í\ÓR\ÛÚ¯\ã“\î–-[<ü\ïÿ\Ûüú×¿öÄ¯Ä«Ä­DðW_}e~ø\ÃzZÿ\Ý\ï~g\Î9\çs\ÄG˜·\Þz\Ë\ä\ä\ä˜nÝº\å}§Dô¥—^êƒ\"\Å:§¬¬,o[ûu<\Ù\ëR\n\ãr­mE\0m:\0\à0\å$‚•v 1÷û\ßÿ\ÞÌš5\Ë\Üq\Çž]v\Ùe\æ\Ì3\Ï\Ì\ÛV”·W¯^žh\Ôg$‚%½\ä’K¼´Ewõ™Ÿ\ê ‘ûóŸÿ\ÜÍ=ö˜÷Y-µ­ý‰D°N7\Üpƒ·-<j\Ô(/\n}\Í5\×xQ]_+õ\âê«¯ö\Ä\é	\'œ\à\ïß¿¿\ÑU$YQ\àÍ›7\çÁŠ¯\\¹\Ò\Ù:§iÓ¦y\Û\Ú\ï‹\àd®Ki\r‘\æ\"\Ã[Á\0@›\08L‹`	À—^z\És\Ì1^\ÄS©<òH>“hU.o½zõ<¡\é‹\à\r\Z˜Å‹{¢´cÇŽy¶lÙ²<,‘Ü¡CÓ¢EOpj©m\íO$‚uN\Ï?ÿ¼9ù\ä“óDðŸþô\'ó½\ï}\Ïüñ^¤\×ÁcÇŽõ„\ê\Å_l\Î>ûl/UC\"XZÛŠ+Ubö\ì\Ùy\"¸jÕªæ¤“Nò¢\Ú:\'-µ­ý¾Næº”ÁdŠo\çi\0\Út\0\ÊH\Ë.\\\è‰=­+\Õ@\Ùüh¤òj\Õ\ÌO\rPÚ/‚õ‰\âÆ›£Ž:\ÊKuø\îw¿k>ù\ä“<,!Z§N¯£š§–\Ú\Öþ‚\Ò!}\rŠ\à¡C‡z¢S6hÐ <¬\Üau “h~ô\ÑG½\Üa¥AH 3\Æœ>ø`^4X\"·aÃ†y\ãtN~\Ç8\í¦Cõº0m2\0\0m:\0“Á\"XC™I\ì)…ÀOmP\'° \ØŠ\à6m\Ú\ä\í¿é¦›¼ý\Êõõ‡\'Sôõ•W^ñL#)Hpj\é\ïó£³‰`\r{ö\ï|Ç‹ÿö·¿õr|•\Ë\ë‹`ô¥DÈ”–¡¿\ão\Ë4bE0â¬³\Î2Õ«W7ø\Ãò\Êj[û\ã‰\à¢\\D0\0\0m:\0“\"XBSÃŽ=ù\ä“^\ç²ö\í\Û{¦Žo‰D°>£Nb\Z­¡oß¾ÞˆþbJI õM\éœZ÷«\\\"¬ô¥:}ô\Ñ\Þ÷ÿ\æ7¿ñ¢Í±\"Xvó\Í7›Ñ£G\ç\åùªœoúÿür\ÊûÕˆo¼ñ†\'\ÄUV\ÑcmG\"oÄ‡\â\\D0\0\0m:\0“a\"xØ°až\Ô(J7Š=¥.$ÁŒ\Z	By±J\ÐwH0®[·\Î,]º\Ôû^ß”¢ \ãZ÷«\\¼s\Z0`€—¡¨«„óÌ™3½a\Êd\Z\Ø\"MwlÜ¸\Ñü\êW¿2ÿý\ï\ÍÔ©S½¿Ó½{÷<S\Þr¼	>b\Ó!Jr]Á\0\0´\é\08L†‰`u«4?÷U9´Z\ï½÷¼\Îhÿü\ç?L‡Ðˆ\áp\Øû‰`}G\ì\ßP\ç2	J-‹rN¦“&Mò\ÆV§´\à÷ø\Ù4\n…¢¸\ÊC.\ÌT.Yœ\ÌuA\0Ð¦\à0&‚cÅª?Ä™¦VT7x\\#?¬^½\ÚŸ\×´Š\Ä§+Ž7-²¾KQZ-“=§\àt\È2_\ì¾\â˜\ÎU\ß;­sq®\"\0€6\0‡\É`Œ•½!‚€6\0pD0\"\0€6\0pD0\"\0€6\0‡ÁaÁˆ`\0\0\Út\0Áˆ`\0\0\Út\0Áˆ`\0\0\Út\0Œ\ÐD\0Ð¦\à0ˆ`\0@›€\Ã ‚1D0\0\0m:\0ƒ\ÆÁ\0\0´\é\08\"C\0Ð¦\à0ˆ`\0@›€\Ã ‚±\âÙ°aÃŒ}®\Ï\åi\0\Út\0ÀaÁ•\Æ:v\ì(,k\Ä\0´\é\0€Ã”£GFh¦¹u\è\ÐAxw$ù‹\îY8~\Ønß™““S•\'\0h\Ó\0‡)\'N<°a\Ã\ÄfšÚªU«¾\Z9r\ä^+€O\Õý²\Â÷D+‚·\è9·Ë«\Ü>\Ä0\0Ð¦\à08L2Œ3\æ™q\ã\Æ\\¿~=¢3\rð¨Q£¾µ\ÖÉ¿_Õ«W?\Ê\n\â:ö9\ï\ï‹b»¾\ÖZžf\0 MÀa 	¬\Èj=r\ä\È\Ê\Ît\Óý¯ÿ‡³½A\'ˆ¿µö‘{þÏµV§\Z\0h\Óp\àþWh¬þY8®\æþÿŽºv_{ž\0 NÀa€û_Yþ‰\à\í~¾°]Ïµö@Íš5\ç\é\0\0\êt\0¸ÿ_ð\Æt¢«\æ\ï\ã)\0\êt\0¸ÿ\Z+~o³×¤•»6\çº(q/®\0P§\à0Àý¯:Ñ½\êr5\ìa\0\0\êt\0¸ÿ–Úµkÿ¸fÍš?p×ª3\Ñ\0u:\0\Üÿ\Êv­\ZY[bEñO´‰Dj\è\0€:\0‡\î¥@Ã¬¹T‰\í~\ç9¿3\0\0u:\0\ÜÿŠ,„¯±\×/\'°®T‰÷¹2\0@€\Ã\0÷¿²\ânxµŽ\îºV·û\ê\æ\ä\äT\å\ê\0\0u:\0\Üÿ\n‹\Ò\"üü`E„ƒ\èªW¯~”]˜R4\0\0\êt\0¸ÿ\éE$¹]B\Ø\Ï¶\ëS.¹\äD0\0P§\à0Àý¯¨Ãœ:\ÑD0\0\0u:\0\ÜÿŠF“8\æ˜cÁ\0@€\Ã\0÷¿Ò\0\êt\0¸ÿˆ`\0\0\êt\0¸ÿˆ\à\âs—\0¨\Óp\àþg¢~\Ô\Úõný:k7Zkh­¿[—˜\à³sœ~\Ã\Ú\é1\Ç\êY\Ç\ì;\Ú\Úø˜}¿´\Ö\"`?µV\×\ÚI\îøo¬5”¿\Í\Ú\Øm²\Z/ùg\î;n°V\Ã\Úc\Ö^¶ö¡µGb\Î\å\ïÖºÆ±ÿ‹)÷k`gºr\çr®¾\Ïc\n\Ô\é\08pÿ¡|Eð\É\Ö\Æ8ñ(Ñšc­½µ÷Üº\ìŒD°¸\Ü\ÚûO³–m\íkÕœøhmµn]v¶”™²6À\Ú\Õ\î\\\Æ9ñ;%F`\ÏœW<›(+?\ÕÚ“\Ö\î±ögw>\'\'øžµv§µs¦s\ëS®¾µ¾\Û³ý¨+WÍ‰\îD¶\Â-\Éc\n\Ô\é\08pÿ¡|E°8Ö‰Q‰OE€?vbR\ëÏ¹2Š¨Nˆ±õ‰nù“P4š\Û\ÔZ7k]B\Ñ¯\Ä\å(=\ÕÚˆP4R+†[ûžµ~\Ö~\äö)*»\Ø\Ú\'²}&ò¿LŠÁm’¸VÏºsh°¾qDp¢\É2\Ç¨\Óp\àþCù‹\àš\Ö^µ\ÖÒ‰\ÏVÎ´o|`û!|\\\àóÊ§¹uE=ÿóý=¬]\äD°\"½J‡ø\Ä»7Pn¢[Ž\nESF[kgM3\á)\Z;6En\çP4¥aˆµaNp\ÇÁ+Ý¾Dvg ¼~\\\Z\Ç\Î,–ðŸk\í#g³CÑ”	D0P§\à0Àý‡‰\àSœ “UTö·\ÖþcÝ¿:Áy´\Û^h\í%\'€%n\Ï\n|÷¯¬½c\ík\Ï8QýŸP4Bi»rG:\Ñre¾\ã¯–¾\Ë\íŠ\Ü\Þ\Ö\Îu\ëú»¯\ÇÁ·‡¢é¢ h³\ÒFÄ±¯¬ýº˜\"X)o¶{ºˆ` NÀa€û)Á>\Üò\'\\[9{\ÖmQ®o®µ&\Öv…¢y»\ãBùóv%š—Zû:\í„\Ö!\Í\×Uz\Å÷­e…¢\ïB\îs\ãœØœ\ê\Ä\ío\Âñ\ÅP4¢*†Vnn-÷ù\â\Ø\í1¢½[`û\áÀº„þ•ˆ`\0\êt\0¸ÿWk½³qD°øW(:‚ƒ?:„lõÀq	\ÞûCÑ‘‡¢\æ”ð\ïP4¢:\Ò\Úwc¾óL\'D{¹m‰Ú›C\ÑN{¡\"øC÷ý\Ãˆ\à\ÎN¼6w¢ûò€\Ý\ãŽ\ÇÁUbjIEð\â€ðþ\Ô\é\08pÿ!}D°†û§µŽ¡\èpb²\ÛcD°:¯=:”û\ë‹?¥,(\ï5({¥}”Ó­Švˆû\"\ÍAöQDY©\Z-\âoN8Ew·\Å|g¬ÈÇ¤˜ÿ\ëD\'‚ÿS\î÷ˆ\à?\Äxiˆ`‰ôŸ\ìhD0P§\à0Àý‡ÔŠ`Ed5ÊƒR}\Ù	OY½€þ±«—>;?°~²7Çˆ\à«B\Ñt\0¥=¨\ÃÝ»N¨ú\åŽ|‡†#kŠ\æK8öu\âºV Ì¬P4\êœ\Èf¹r\ê\Ð6È­K7E‡\"ó-\'F«žF¶¸Î‰Z‰U\å0kdˆkB‡r’a\í¡[g_5W^‘ò\Ó\â\\wý(˜\Ç\ã	\Ô\é\08pÿ!5\"ø„Ð¡h\ë=\Î\Ä%¡h*B[·­ˆ®?JÂƒ¡h\n\ÄÄ˜\ï:& }¬ŽiŠ¬*\êyK@0+?8\ËmŸ\ïD¯FzP>ð\ÌÐ¡	<Nq\"ú~·=9\íT—\È&»r÷:A\ë‹`¥NtØ€V„Z#7h¨6E€\ÏüOW;ñ>\Æý`PG\Âp\ì\'	®÷\Ñ\î\ï\è<\ß\ãñ\êt\0¸ÿ\Z\äXg\â\'j\ã¡\èf\ÕÀö‘q\ÊHgš«§\Ì|,U\n9÷#\n8v|\Ìùúbô„_Ç”\â=ùN\à\Ç\0u:\0\ÜH\Öh—$8¦Ngg„Û¿bR\ËZ…¢\é=\ã|Vù\Ã#\ÜzõP4­ hõc\î\'¦o\rES($:¯\rES2þn@ \è\ÖQV~²\Ò(f¸õ¿„\å\Ü\Æ2¹€\ëP’é£“e’\í=ü€\0 NÀa€ûe,‚%H•®ð»Pt<\Þ c„Ÿrs?v‚ô\íPtH3ü \Ñ4ZC‹\ì:¡”\å\çÖ±vq(:\ì\Ùc²š©®k@ŒªœF{Pú\ÄN,ž8;\å)k¤Š\Æ\Ö¹u™\Í>7\ÛØ·e1\Û\çÎ¡$\ÓG\'\âw\îµõn9\Ç]\Ç\ßò˜u:\0\ÜH–pœŠFv}\Ôq+6\r\áŠP4‡W\Ö.rBõ-k†E%$\í\Ü\ZŠŽ,N\n\Ê\çó„¢¹¶°­­\ÕEóv%Ê•\Ï\Û\'PV\Ñe¡\\\å81\Ù=\Ð\Â™ç»²Š6÷ˆ\ãÕõþ¡ü\Ñ\èP¨h\ÓG\'Ã©\îz\Å\ÚÂ˜\íSxL:\0‡\î?¤F_«\á\Ì\é=\Ê	\ÝP@\Äþ\Â	_	ã»­ý\Ù\Ú}¡hzÂŸ}Ï•F‚M\Îq\"[\ã\ä¾æ„®ö+õA\æZ…¢\éŠ«£žFsPø}·OQ\Ø?„¢\Óws\Ç~\àDµF‚PdY#2Œw\â\ÓÁÙÿ!8”Yv@\';}t2<\ëD¿ošz¤»>ú\áÐG¨\Óp\àþCjEpÈ‰ÓŸ†¢\Ê`\ÄV¯ö5F°\"£\ÊcU\ê\Ã¡\è¨\n\Zö\ìm·\ïŒ¬\áÅ”® \Ñ\Z”Ò 4Er5#›†I\Ó(\nw†¢Q\×_8ÁvÇ–„¢C´I\\k¦¹‡4¡aÇ”Z¡\â\Þ\îó§¸s	Dð\\wŽ²mõ¹œ\ìô\Ñ\É0Ý‰uY_w]_s\ï%\'À¨\Óp\àþCŠE°O;k\Ä\Ù?*°\ÞÐ‰fEƒƒcù^\àñ6\'œý\ÔPi­B\ÑT\0­\ß(¯ŽhÏ„¢\ïü\ï\ÔPmO‡¢Ã¥\Ý(+A]Ç‰\ç¿;A{’;¯ccÎµ¨‘`Ÿd¦.*Á	1º:\ÜÁ‰|\å(\Í#\n\Ô\é\08pÿ!u\"ø\ØÐ¡1‚	^\ÊUÁJ‰ŠFg}¬±5™†¢¦ÿˆÊ“\Ý>\Í@7Å­ÿ\Î;\Óý­·µtç¡¨©\ß1\î•P4\ÕArS(šƒ¬Hr›PtB\í»\Þ-e5\"Xâ—œm¬\\ˆ.\Êô\ÑEA“|0¥@(•Di!ñxu:\0\ÜHV*:~©#›&Á\ÐØ¹Êƒ\Õpam\Â\ØgŒµŸ\Ü>uP\ë\ì£Ÿ7\Ì	V\ÔW3\Ò)º¼Ø­\ç:Ñ¬ôƒ_‡¢)\Z6¬¡‡WDðq\î¸\"\Å~\äôt\' \Ïv\å4{\Ýyn\Û\Ñ\âŸ\îûª9[X×¬nYqDpQ¦\Ö\ßýQ÷@\×B\Ñn\å/\ß\é\Ö7¸ÿ\åB÷¿P§\à0Àý‡rÁz\Õv\"S9¹Ÿ…¥*H \Î¾gX\Ö·Åˆ<Eƒ#¡C\ãÞžÁ»\ÕC\Ñ|\àÉ¡CS\ë{Ou\"Z\Ñ\Öq\îo\Ü\åþöOBYõ\Î\rES	\Æ9\á.”¬1‚5Š„:œý¾€ÿuNÇŠ:}´\ÐHSŠp\í¯r\ç6Î‰jE¨5¦ñ‚P4C¹Î\Æ\\K\0\êt\0¸ÿP\"\ØG\é\rÃœp\"¡¦ü\Õ_…¢)\n\â¦PôÕ¾Êp¦4‰ñN\è©\ì<\'XƒHÇ¦X(\âü`\èÐ˜½·¾3h\'Š«‡\Í(§TMA|©\ÛV\Ç50‘]\\\Ô\é£\Åñ¡¢\r™öPþ\É0Žs?\"\Îq?†;1})P§\à0Àý‡Ôˆ`Ÿ‚¦>*\Íþ·c’<\Ï\ïñ{›>Z‘\êÓ‹y\ÎG\Æùñ@€\Ã\0÷R(‚ý|4fŸŸ\n¡´„\çc\ì\É„´R&Ns\æ\ç\Þ>X×„\Ç\'ø|¢\é\Õ	/˜?«\ï‘ÄµH—i“¨\Óp\àþCŠE°:•r¦\á\Ë>lg;‘©\×ú\ê§	*”/¬ ”\ëúkkB\ÑWúzÍ¿\Ú	U_HªÌ¹¡\è„\ê\0¦ow;AÝ¯€sJ”¶ tŠOB\Ñ\Ñ+\Ä\îün1_\\\ëo§r\Úd\0\êt\0Àa€ûŸ¦\"8H0ü\Â\ÇŽ·vñ‡Nø*\í@Ãý\Æ\×>ÿu¿rl5^ð\ÑNl^\ZÁš\àÂŸ\ÕM³\ÔM˜†KSµ1û/\nÛ‰\î{5²E÷½¾-sbY¤z\Úd\0\êt\0Àa€ûŸ†\"X\Þ\ÆL#Ch–6MM¼\Ý\ÚT·¿F@«3—:È­s\"¸®µf¡\è°a“\\9E}5I\Ä9n\Û²Sœ)š;,\ÎùH€v	E#ÁØŽGU\'ž‡»\í§Ü¶\"µÊ¥Ã´\É\0\Ô\é\0€\Ã\0÷?\ÍDpEs5)…òf\r\Ù%\ì\Ï.7Þ‰`ExG‡\ìsy(:np(”\Ö4_ÄŽóý½pž\ãp¿Î·A(:¾°/²•\"¡	;\îÁ©ž6€:\0p\àþ§™V\ÚÀ#Nj&¶¥¡hþ\î»Î”\Ó{DŒþ4\ân\n\Z…A\ÑÝ¡¡\Ã\'}Uz\ÄtkCön¬üÞŽnÝØª\ãÝƒq\Î[S2?°­™\àžˆS.¦M N\0¸ÿi&‚¯s\âQ\Ö(\Îq¥CT‰Á7º}\ã\"¸¾Ì±¨Œ:œ	Vg»A¡h¼X±\Ú#À\Â\çüPþTŠ¸¿­ö	qDpª§M N\0¦’\Þ\ëuºß…\Ø®TJD°&‰\Ð\È\ÄØ–8\"øPt˜³eN(Vu‚rQ\è\Ð\ÈBi]\ÜzA‘`}\×Û¡h\Ç7?wxG`])\ÊA¾Ã•\ï\ãÄ»\Ï \'ÌƒÏ§¬¦M\0\Út\0\n½\×Ù…‰\àp8Üš+•r¬\Îe§\ÄØŒ€\Öt¿\ãB\ÑÈ¬\"¨óC\Ñ\É\'^E§,¾Ò‰Hb	uZ;ß­\ÇF‚•\Ê0Æ­k\ì\Ý\Ø	$b‡H«\âÊœ\Ï\Zµ¢«µnrÿ\å\ÏKò½A’™6\0h\Óp(\Òý\ÞX€\Þ^½zõª\\¥”‹`Ekû\Å\Ø\ÆP\âÍ”\êpƒ¢>‹\ê §…>ýA,±­Q(ZC¬*\Ú[Ý“:\ã\å\Ä)£!\Ó\Êz\Úd\0 MÀa H÷;a48‰´\ç\n¥\\:<Ÿ6\ä\Äl\"Nq\Ë\Øi–\ãM»|l`]y¿Gr>§\áÿ*h\n\çDÂ½´¦M¨\Ìõ9)n\0ˆ`(…ŠsQ\à´Á\0\0E­\ËIq@CI+N*JD0\0dd}NŠ\0\"’¼\ïkˆ#‚ \ã\ërR\Ü\0Á\áp¸n ²\Ì\åŠ ‚ c\ÛqR\Ü\0ÁPœŠ“Š\0]—“\â€†d+\Î\Z5jpÿÁ\0ùõ9)n\0ˆ`H‚\\\'\ÊH‡@@CŠ@ŠD°1\ædk\Ç\Å\ì»3AÙ£\ì?\ÃÚü*q\Ê_\Å\Ý+M¬´6\Ë-yu†€\Ìn\ÏIq(+<ñ€\éú\ÌÐ•d-__°*÷õykžþ\Ïò\ÅÏ½·~®¥_œ.1¦u\Ó^Ó¿¹\ÇôÐº\ÝW£\ãû\ë\ç4uÎ†\ÜWç¬³\Û\Ç~÷„¦Ë»L¿x·ã°¯g-7¦•ýÜ/Œ\Þ5IÖ°\Ûø}þº\Ý+w²X\Ø¾Š\Z@#‚ ý	‡\ÃY{É¶\ß\Ó\"‘\È»\Ü3*\Ä\rf\Ë,¶\ë¯Y»†«Pl…\æõ=&›Ñ¾µ\è?u\ËóW÷©ŒL¢Ux\à3¨\ë\Ø}?\Þbz\rX`Þ‰\èŽ\Ùcº·øù2Y\ÓW>\ÝÚ¨\ç”\íþ¶Žþöñm-û\Â\Ø3Œ\éÔ¸\ç\ÔZ\Î7¦Cl\Z’À…\íD0\0¤µj\Õj“û›Œm·Ö›(1@ñD°R\êK\ÜÊ¢\á5Ÿù\Ûö\Ø®\Ì\Ñ\Ï~°~Ž¢¶o.2CVó\Ôcž±\ÝôŒýN‰e[\îvk\'\èø\æM­kŸŽ¹¿{Žµ+­¥\íu\Æ\äJøJk¹Ô˜¶\Ü\Å\"“[ˆ\Ðõ“O†€ôi§5úÃŽbŠ\ßXÛ«\è0W ”\\:DŸ\Ù\æƒîŸ˜±J]h7dõ¥Ah]\Ñ\Þ\×\çš÷TF¢TQ\Û&/O\ÞùD\ßYµ®(ð\ã=>\ÙÕ¼ÏŒM\r»O\Ø÷Ÿ\å\æ-_+MBQdE•s_›·V\ë\Ú\ç‹\ài\Ætn5ðó\åGlýT\ëí†®Xk\ÚÏ,²\0.L\àF@ú´\ÑSb…l\íÚµMûö\í\Í\àÁƒÍ‚\ÌÚµk\Í\îÝ»Ø·oŸÙ°aƒù\â‹/Ì!C¼r\Ù\Ù\Ùñ\ÄðFû=Wr…œ„nù\Æ\Â¨\Íú\ÎüZ9¾Z—€õE°ò}÷ó¸r…%~µ\îG‚í±›|q\ë‹\àUÆ´°ûo\é7Û¼oð(­k_°œ>\'¬uE %À}{\æ¿_-\â.J“Pr\Þd\Ë\"\0J‘H$r†\Ë÷\Í®999fÀ€ž\ÈM†;wšw\Þy\Ç4h\Ð v,\áƒöo4\àj\"¸ˆ\"X\â66\'X\ÑÞ€¾Vi\r¹¬~îƒ¯g\\l¿½Ä¼­4†x\"¸ÿ3t’1/(…BW\ëÚ—H?\Ñ{\Æf÷­iï™›¹‹E´­‹ù9„0\"\0\ÊY\0Û¶ykP°¶h\ÑÂ‹ø–„ýû÷›?üÐ‹$¾û Ã¸\ê€.¬7\æ‘E\Æ<#{\îýõ³;}´y†¿­c®\ÌQ\Z¢\Ï3|À\"ó_EwU\Îî¿¡¨\"XŸ{q\ä¶)A,A­¨ró¾³6n6¦©o\Ú\æ.–º\0.­\Ï\"\0’Áù\"ÀJ{€--V¯^m\Z7n\Ìs\0Éˆ`Æ¨cœRTF£7(\rB\"\ØúZ‰YEk\Õa.VK0û\ë\r‘f\Ë\Õi\ÐeÜ\Æ4Q^±\"Í¾)2\Ì]ŒKa\à\Êû{\0\0…·\Éùr€§Nj\Ê\å+_8\Î\ÊÊº…;\0ˆ\à8l3¦Q›·—.õM©²\à>•‘¶þuO£—\'\ír\Ñ\ßk•\á\Äl>D\Û4”Züò\ružs;«´´t‰„8w1¡p-­T\"Â¥+‚K\Ã\0 \âµ\ÇÙ±\à²D\èÚµk—o|aAÌ\0Dp‰šzS\ÅúW\Õ\"\ï‡\Ò$6—Wc3÷r\Ëdˆý9Âˆ`\0(C¬\0\Ý\Ì.\ÍˆDlÛ¶\ÍÔ«W/˜1‹;ˆ`\Èd\Ü: d?w¢\éó$„p¢\Ï!„\0\Ê\07F\Þ(%\í—3g\ÎÌ—Ás€†LÀ¢W(ô°(B8(€}NtBŽ0\0@\é·\Å\ë|!ªa\ÐÊ›N:…ð4\î ‚!SH$L\ã	Ú‚„pQË“#\0PJ(78F²\ã\0—ÿû\ßÿò|\ï½÷žÃD0dŠ\0\Î-¡°MV0“\Z\0Px»)‰\Ô/D¿\äPØ*‚“i\Øsn\Ï\ÝD0¤3E¢…	\Üdpð\ï\0H\Ø\Æ:\Ûd\Ån\Ýe¦•×ˆñö\Ûo\ÓAÁQ¸¨4‘\Ð=ª˜Ø‡a\0€\ÂE°oc#\ÃÁ\É1/^œ2¬1‰ƒ¢»ˆ`¨¸ !¼·¸¤\ç\0P\ÙDpž\ÈôÅ°]\ß\ï\ï/\ÏQ!bY±bE¾1ƒ¹{P™Tó‰tÃ¥°K\ß\ä¬\ß:\Û\çl¯µ=\Öv[\Ó8‡»\ìgw\Ú\åk\Û\í\ç5ú7vŸ~\ínv\Îÿµ]n°¶\Þ\îW¯\Ø5\ÖV\Ûý+\íò+k_\Úý\Ë\ìöR»¾\Ä\Ú\ç\Ö\Ù}¬}f\×\ç\Úc³\ír¦Ýžnmª›i\çk¬³6\Ú\îi—#l\Ùavù~­ZµÞµ6\Än\Î\Ê\Êz\Ë\î{\ÓZký\ìþ>v/»¿‡\Ý\îj\×_°ûž·\Û•e\íiM-iµ°ûškH»\ïqk\rì¾‡\ìövY\Ïn\ß\ã=Ï²\åkÚ²5ì±¿j6»}“]¿\ÞÚµu\êÔ¹ºv\í\ÚW\Úr—\Ûý\Õ\î¸ãŽŸ\å\ä\ä\\¨	w\ß}÷4|Íš5O¾ù\æ›O¨^½z\ÕV­Z)j[\Ò\Èk<!\\+„\É\0(¼Í‹·5“[ª\Ð\äÁs\á\îA¥@\âJ\"\Ë\n®\ã%º²³³O¯Q£Æ™cVœ] q&‘fE\Üemvý*#(1g—7J\ÜI\äY»]¢/¥ŽÄ r œ8|\ÈÚ¿$\Z%­5“˜´\Ö\Ê~¾­D¦-ûœD§Ä§\Ý\ßEb\Ô\î\ëi\×{K¤Z{]¢U\â\Õ\î$1k·ß±\åß“Èµû†;\Ñ;\Ú\ÚX\'†%Š\';‘<Í–›!ñl·\çHLKT\Ûý%²\íþ/\ìr©Ä·].——(·Û«œH_ë†±\Ù`÷©\â\Ú$Q\ï^e}#±o÷os\â_¶\Óý(\Ø\í~$\ìu¦\ßÚ²ßº²n¶žƒ¾\éH¼J\ÓÞ²’\æjIL\ÇF€÷ºý%aV*|\Ã0,¥\ZD0\0¤3%™H0\0@\ê#Á;ôfQ(\"Á\0\0\ÉNr‚\02K\ç‰\ß@r‚\0Š!<‹\Zyet\0€Ô‰`õi¿>Œ\0P|!\\˜\0-«q‚³CŒ\0P>,ò§\Ì\Üt\'X; ‚\çr÷\0 \Ý),[\Ö3\Æ1«\0@	p#¥|Æ¸Æ\'\Ë\èÄ€L QD8Ya[\Ôò`\0€R\Â\r•\é‰O»n¶mÛ–\Ò|`\'‚/\â\Î\0@¦ ˆpljB¯Pò)ñ„pÏ˜¿C0”\Z¶ý=+fûgÖªPþLY¿û2k4\æöó‚‡R\î\"¸GA¼„;\0™(„ƒå‚‚6™\În‰>\Ç0hP\Úøg¹¬\îk7hù\çvÿU2§Z»Þ·>³\Í²\à>k\'«\\³~³7\Ø\å\ÕÖ®±v\Ó\Ä¦k‡w\×\ÎÓº³Ó­\Ýú\Üû\ëg7\í=ss\Ó\ÞÓ·l6¦©>\×f\à\ç\Ëd-\ßX¸‚;\åM0%¢~ýú\å:T\Ú\êÕ«½t \Z\æŽ\0@&›\Z!\Û3”ü°g±Ÿ+\éø\Ä\0‡\Ñmü·\ãm\\\ÏÚ‰¹¯\ÎY\'{¬\ë¸ý\Íû\ÌØ¤õ	L{\ì/?\Ú4Ý·\'ú\Î\Ú(\î³enp‚ùú7™!o/1o·y{\é\Ò\'z\Ï\Ø\Üý3Ve´tBX‘\æð“ý\æ­\ÓgVó”\Ê\çý’´—;\å/x·/D\ßy\çrÁmÚ´	F\×p7\0 \"	\á’/\Õ D(r\Û\ê\Í\Å_*:Û¢ÿü¼hpl$Ø•­\ßg†.{jÀ¢•2\Û{Ä•¹q‡1M\ÜúqŠ\è\Ú\å\Ú~q\ä¶)ÛŒi\äŽ\Ý9`‘ùo£wk¹Ä˜ÖŠ\nwöõ,Y\ãžSwpw £ÁŠ\Ì~ù\å—e.€?üð\Ã|¹Àšù•;\0\á²\Ô\0³yNQ\×Ç»ŽÿÖ¶\Åu%hµÝ°\Ûø}\Íú\ÌúZ\ë¶*\Ûmü·\ã†}mú\Ú\íh]¦õ\ÛM\ÏF\ïš\ä‹\ê\Ü\×æ­•¨•\èmòÊ”\íOÿgùb‰\ê6ƒ–}Ñ´÷´ol™­]1p±,¼Ç˜\Ç…¶V-`rw UX!º\Î¤\r64;w\î,3<iÒ¤|i\Ö\Þ\ä\0@E¡¤)¤@@™¢T‡g?X?Ç­WµvFÀN÷\ËIôö›mÞ—Àõ#¶Z\ï¿ÀõE°ûŽ\ã|!»Ô˜¶Šþ*Gx\Ôvó²¢\Ë~‡;¥J4´\â{ø\Óçµ¹\æÝ§\ÞXôU\Ãnö)EB\ë¶\\„»©\àŽ;\î¸ÔŠ\Ñ¾0m×®7qY\àœœ:\Ã@¥\Â\ÉFr\ée-€/T\êA\ç[?m3h\éR\åÿ6}\åÓ­¨²\Ç{L\Ø({\ç\È=¦G§6\Ïh\ÔcÒ®F/OÚ¥u\í³\Çj\Ê]þü\Ç;§\ØeV b|¿\"Ä2õzL6£µï•©f„m\âÔ§\Þü|¹\"\ÏZ\ç\î@*	‡\Ãu­ôªrv7m\ÚTª)1\à‘H\ä®<\0TD’Mi \ÊCW›d\Ì®Ú––¨\Íûõ\ÓAM\Ù\Ú\rY½\à\ã-¦—\ì¹÷\ÖÏµû\î	–\é=\Ó|¸Î˜\ÜI\ÌKm1½ƒ\"\Ø.V§¸\×\çš÷$|}a¼Ù˜fJ™P$¸\åÀ…_µºb!wR¦X\æ\ê*j«iK:\n\ÄSO=•/\0\áCd‡˜\ÊG_ ±ú\ÌÐ•$H\ÕI­\çd3RbW¦\Îj~¹\ç>øz¦\ê\ìT\å\Ë\ìú	\Þ\èï¯Ÿc\×\ÏSY\ry¦\ßf}g~-q#‚¦²ö½O|\ì†`\Ë	VZwRM­ZµšX‘z0(Z5£\Ü\âÅ‹“žC\ã\0\ÇD½0\0T\n\ËñõG@\0Cyˆ\à{œ˜½B\ÛÓŒ\é¬”ª k\ÜsŠ7J\Ã*cZø£>\å÷\Êüm\ÓX¿ö{.u‘\à\æú.{w¥\é¯t	‰k\r«6ß˜þ\ç\Ü\ègú\ã\Íÿ<@ª\É\ÊÊºÅŠ\Õý1\â\Õ<ò\È#f\àÀf\âÄ‰\Þ(~Þ°–½Š\Z<\Ø4m\Ú4Vø\Ò	\0*-‰\"Â¤@\0\0¤!Š\ÖZ\Ñ:%6*\\L[\Ã0h\0€>$xÀ\0\0iN\íÚµ¯´\"vb°\Ó\\¶„™\à\0\0ò\ßY`\0€\Ì!\'\'\çD—/<M\Ûb\Ó%\"‘ˆ†X\Ûdm®\Ì/Y»ˆ«\0\å\0›Ã \0\0\0@%\ã.\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‡ÿeekUóžÁ\ä\0\0\0\0IEND®B`‚',1);
/*!40000 ALTER TABLE `ACT_GE_BYTEARRAY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_GE_PROPERTY`
--

DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_GE_PROPERTY`
--

LOCK TABLES `ACT_GE_PROPERTY` WRITE;
/*!40000 ALTER TABLE `ACT_GE_PROPERTY` DISABLE KEYS */;
INSERT INTO `ACT_GE_PROPERTY` VALUES ('cfg.execution-related-entities-count','false',1),('next.dbid','22501',10),('schema.history','create(6.0.0.4)',1),('schema.version','6.0.0.4',1);
/*!40000 ALTER TABLE `ACT_GE_PROPERTY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_ACTINST`
--

DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_ACTINST`
--

LOCK TABLES `ACT_HI_ACTINST` WRITE;
/*!40000 ALTER TABLE `ACT_HI_ACTINST` DISABLE KEYS */;
INSERT INTO `ACT_HI_ACTINST` VALUES ('10002','leave:1:4','2501','2504','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-09 01:32:41.407','2018-04-09 01:32:41.669',262,NULL,''),('10003','leave:1:4','2501','2504','hrAudit','10004',NULL,'è¯·å‡å•-äººäº‹å®¡æ‰¹','userTask',NULL,'2018-04-09 01:32:41.673','2018-04-13 15:04:38.808',394317135,NULL,''),('12502','leave:1:4','2501','2504','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:04:38.812','2018-04-13 15:04:38.844',32,NULL,''),('12503','leave:1:4','2501','2504','modifyApply','12504',NULL,'è¯·å‡å•-è°ƒæ•´ç”³è¯·','userTask','1','2018-04-13 15:04:38.846',NULL,NULL,NULL,''),('15005','leave:1:4','15001','15004','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 15:08:08.754','2018-04-13 15:08:08.755',1,NULL,''),('15006','leave:1:4','15001','15004','deptLeaderAudit','15007',NULL,'è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹','userTask',NULL,'2018-04-13 15:08:08.757','2018-04-13 15:08:34.845',26088,NULL,''),('15010','leave:1:4','15001','15004','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:08:34.846','2018-04-13 15:08:34.868',22,NULL,''),('15011','leave:1:4','15001','15004','hrAudit','15012',NULL,'è¯·å‡å•-äººäº‹å®¡æ‰¹','userTask',NULL,'2018-04-13 15:08:34.870','2018-04-13 15:40:21.648',1906778,NULL,''),('17502','leave:1:4','15001','15004','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:40:21.652','2018-04-13 15:40:21.689',37,NULL,''),('17503','leave:1:4','15001','15004','reportBack','17504',NULL,'è¯·å‡å•-é”€å‡','userTask','1','2018-04-13 15:40:21.691','2018-04-13 15:59:39.067',1157376,NULL,''),('20003','leave:1:4','15001','15004','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 15:59:39.106','2018-04-13 15:59:39.106',0,NULL,''),('20008','leave:1:4','20004','20007','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 16:18:12.150','2018-04-13 16:18:12.150',0,NULL,''),('20009','leave:1:4','20004','20007','deptLeaderAudit','20010',NULL,'è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹','userTask',NULL,'2018-04-13 16:18:12.150','2018-04-13 16:18:33.114',20964,NULL,''),('20013','leave:1:4','20004','20007','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:18:33.114','2018-04-13 16:18:33.135',21,NULL,''),('20014','leave:1:4','20004','20007','hrAudit','20015',NULL,'è¯·å‡å•-äººäº‹å®¡æ‰¹','userTask',NULL,'2018-04-13 16:18:33.138','2018-04-13 16:22:43.390',250252,NULL,''),('20018','leave:1:4','20004','20007','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:22:43.390','2018-04-13 16:22:43.391',1,NULL,''),('20019','leave:1:4','20004','20007','reportBack','20020',NULL,'è¯·å‡å•-é”€å‡','userTask','1','2018-04-13 16:22:43.393','2018-04-13 16:22:52.517',9124,NULL,''),('20023','leave:1:4','20004','20007','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 16:22:52.522','2018-04-13 16:22:52.522',0,NULL,''),('20028','leave:1:4','20024','20027','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 16:29:00.691','2018-04-13 16:29:00.691',0,NULL,''),('20029','leave:1:4','20024','20027','deptLeaderAudit','20030',NULL,'è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹','userTask',NULL,'2018-04-13 16:29:00.691','2018-04-13 16:29:19.657',18966,NULL,''),('20033','leave:1:4','20024','20027','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:29:19.658','2018-04-13 16:29:19.658',0,NULL,''),('20034','leave:1:4','20024','20027','hrAudit','20035',NULL,'è¯·å‡å•-äººäº‹å®¡æ‰¹','userTask',NULL,'2018-04-13 16:29:19.660','2018-04-13 16:29:33.284',13624,NULL,''),('20038','leave:1:4','20024','20027','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:29:33.284','2018-04-13 16:29:33.284',0,NULL,''),('20039','leave:1:4','20024','20027','reportBack','20040',NULL,'è¯·å‡å•-é”€å‡','userTask','1','2018-04-13 16:29:33.286','2018-04-13 16:30:55.293',82007,NULL,''),('20043','leave:1:4','20024','20027','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 16:30:55.294','2018-04-13 16:30:55.294',0,NULL,''),('2505','leave:1:4','2501','2504','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-07 00:04:58.494','2018-04-07 00:04:58.497',3,NULL,''),('2506','leave:1:4','2501','2504','deptLeaderAudit','2507',NULL,'è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹','userTask',NULL,'2018-04-07 00:04:58.500','2018-04-09 01:32:41.376',178062876,NULL,''),('7505','leave:1:4','7501','7504','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-08 11:42:04.744','2018-04-08 11:42:04.748',4,NULL,''),('7506','leave:1:4','7501','7504','deptLeaderAudit','7507',NULL,'è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹','userTask',NULL,'2018-04-08 11:42:04.751',NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `ACT_HI_ACTINST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_ATTACHMENT`
--

DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_ATTACHMENT`
--

LOCK TABLES `ACT_HI_ATTACHMENT` WRITE;
/*!40000 ALTER TABLE `ACT_HI_ATTACHMENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_HI_ATTACHMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_COMMENT`
--

DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_COMMENT`
--

LOCK TABLES `ACT_HI_COMMENT` WRITE;
/*!40000 ALTER TABLE `ACT_HI_COMMENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_HI_COMMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_DETAIL`
--

DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_DETAIL`
--

LOCK TABLES `ACT_HI_DETAIL` WRITE;
/*!40000 ALTER TABLE `ACT_HI_DETAIL` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_HI_DETAIL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_IDENTITYLINK`
--

DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_IDENTITYLINK`
--

LOCK TABLES `ACT_HI_IDENTITYLINK` WRITE;
/*!40000 ALTER TABLE `ACT_HI_IDENTITYLINK` DISABLE KEYS */;
INSERT INTO `ACT_HI_IDENTITYLINK` VALUES ('10005','hr','candidate',NULL,'10004',NULL),('15003',NULL,'starter','1',NULL,'15001'),('15008','deptLeader','candidate',NULL,'15007',NULL),('15013','hr','candidate',NULL,'15012',NULL),('20006',NULL,'starter','1',NULL,'20004'),('20011','deptLeader','candidate',NULL,'20010',NULL),('20016','hr','candidate',NULL,'20015',NULL),('20026',NULL,'starter','1',NULL,'20024'),('20031','deptLeader','candidate',NULL,'20030',NULL),('20036','hr','candidate',NULL,'20035',NULL),('2503',NULL,'starter','1',NULL,'2501'),('2508','deptLeader','candidate',NULL,'2507',NULL),('7503',NULL,'starter','1',NULL,'7501'),('7508','deptLeader','candidate',NULL,'7507',NULL);
/*!40000 ALTER TABLE `ACT_HI_IDENTITYLINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_PROCINST`
--

DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_PROCINST`
--

LOCK TABLES `ACT_HI_PROCINST` WRITE;
/*!40000 ALTER TABLE `ACT_HI_PROCINST` DISABLE KEYS */;
INSERT INTO `ACT_HI_PROCINST` VALUES ('15001','15001','3','leave:1:4','2018-04-13 15:08:08.747','2018-04-13 15:59:39.183',3090436,'1','startevent1','endevent1',NULL,NULL,'',NULL),('20004','20004','4','leave:1:4','2018-04-13 16:18:12.148','2018-04-13 16:22:52.557',280409,'1','startevent1','endevent1',NULL,NULL,'',NULL),('20024','20024','5','leave:1:4','2018-04-13 16:29:00.690','2018-04-13 16:30:55.316',114626,'1','startevent1','endevent1',NULL,NULL,'',NULL),('2501','2501','1','leave:1:4','2018-04-07 00:04:58.484',NULL,NULL,'1','startevent1',NULL,NULL,NULL,'',NULL),('7501','7501','2','leave:1:4','2018-04-08 11:42:04.725',NULL,NULL,'1','startevent1',NULL,NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `ACT_HI_PROCINST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_TASKINST`
--

DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_TASKINST`
--

LOCK TABLES `ACT_HI_TASKINST` WRITE;
/*!40000 ALTER TABLE `ACT_HI_TASKINST` DISABLE KEYS */;
INSERT INTO `ACT_HI_TASKINST` VALUES ('10004','leave:1:4','hrAudit','2501','2504','è¯·å‡å•-äººäº‹å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-09 01:32:41.675',NULL,'2018-04-13 15:04:38.783',394317108,NULL,50,NULL,NULL,NULL,''),('12504','leave:1:4','modifyApply','2501','2504','è¯·å‡å•-è°ƒæ•´ç”³è¯·',NULL,NULL,NULL,'1','2018-04-13 15:04:38.846',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('15007','leave:1:4','deptLeaderAudit','15001','15004','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 15:08:08.781',NULL,'2018-04-13 15:08:34.835',26054,NULL,50,NULL,NULL,NULL,''),('15012','leave:1:4','hrAudit','15001','15004','è¯·å‡å•-äººäº‹å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 15:08:34.870',NULL,'2018-04-13 15:40:21.625',1906755,NULL,50,NULL,NULL,NULL,''),('17504','leave:1:4','reportBack','15001','15004','è¯·å‡å•-é”€å‡',NULL,NULL,NULL,'1','2018-04-13 15:40:21.691',NULL,'2018-04-13 15:59:39.055',1157364,NULL,50,NULL,NULL,NULL,''),('20010','leave:1:4','deptLeaderAudit','20004','20007','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 16:18:12.151',NULL,'2018-04-13 16:18:33.109',20958,NULL,50,NULL,NULL,NULL,''),('20015','leave:1:4','hrAudit','20004','20007','è¯·å‡å•-äººäº‹å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 16:18:33.138',NULL,'2018-04-13 16:22:43.380',250242,NULL,50,NULL,NULL,NULL,''),('20020','leave:1:4','reportBack','20004','20007','è¯·å‡å•-é”€å‡',NULL,NULL,NULL,'1','2018-04-13 16:22:43.393',NULL,'2018-04-13 16:22:52.509',9116,NULL,50,NULL,NULL,NULL,''),('20030','leave:1:4','deptLeaderAudit','20024','20027','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 16:29:00.691',NULL,'2018-04-13 16:29:19.650',18959,NULL,50,NULL,NULL,NULL,''),('20035','leave:1:4','hrAudit','20024','20027','è¯·å‡å•-äººäº‹å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-13 16:29:19.660',NULL,'2018-04-13 16:29:33.279',13619,NULL,50,NULL,NULL,NULL,''),('20040','leave:1:4','reportBack','20024','20027','è¯·å‡å•-é”€å‡',NULL,NULL,NULL,'1','2018-04-13 16:29:33.286',NULL,'2018-04-13 16:30:55.287',82001,NULL,50,NULL,NULL,NULL,''),('2507','leave:1:4','deptLeaderAudit','2501','2504','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-07 00:04:58.528',NULL,'2018-04-09 01:32:41.205',178062677,NULL,50,NULL,NULL,NULL,''),('7507','leave:1:4','deptLeaderAudit','7501','7504','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,NULL,NULL,'2018-04-08 11:42:04.784',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `ACT_HI_TASKINST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_HI_VARINST`
--

DROP TABLE IF EXISTS `ACT_HI_VARINST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_HI_VARINST`
--

LOCK TABLES `ACT_HI_VARINST` WRITE;
/*!40000 ALTER TABLE `ACT_HI_VARINST` DISABLE KEYS */;
INSERT INTO `ACT_HI_VARINST` VALUES ('10001','2501','2501',NULL,'deptLeaderApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-09 01:32:41.102','2018-04-09 01:32:41.102'),('12501','2501','2501',NULL,'hrApproved','boolean',0,NULL,NULL,0,NULL,NULL,'2018-04-13 15:04:38.768','2018-04-13 15:04:38.768'),('15002','15001','15001',NULL,'applyUserId','string',0,NULL,NULL,NULL,'1',NULL,'2018-04-13 15:08:08.752','2018-04-13 15:08:08.752'),('15009','15001','15001',NULL,'deptLeaderApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 15:08:34.826','2018-04-13 15:08:34.826'),('17501','15001','15001',NULL,'hrApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 15:40:21.592','2018-04-13 15:40:21.592'),('20001','15001','15001',NULL,'reportBackDate','null',0,NULL,NULL,NULL,NULL,NULL,'2018-04-13 15:59:39.048','2018-04-13 15:59:39.048'),('20002','15001','15001',NULL,'result','string',0,NULL,NULL,NULL,'ok',NULL,'2018-04-13 15:59:39.105','2018-04-13 15:59:39.105'),('20005','20004','20004',NULL,'applyUserId','string',0,NULL,NULL,NULL,'1',NULL,'2018-04-13 16:18:12.148','2018-04-13 16:18:12.148'),('20012','20004','20004',NULL,'deptLeaderApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 16:18:33.096','2018-04-13 16:18:33.096'),('20017','20004','20004',NULL,'hrApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 16:22:43.372','2018-04-13 16:22:43.372'),('20021','20004','20004',NULL,'reportBackDate','null',0,NULL,NULL,NULL,NULL,NULL,'2018-04-13 16:22:52.481','2018-04-13 16:22:52.481'),('20022','20004','20004',NULL,'result','string',0,NULL,NULL,NULL,'ok',NULL,'2018-04-13 16:22:52.521','2018-04-13 16:22:52.521'),('20025','20024','20024',NULL,'applyUserId','string',0,NULL,NULL,NULL,'1',NULL,'2018-04-13 16:29:00.691','2018-04-13 16:29:00.691'),('20032','20024','20024',NULL,'deptLeaderApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 16:29:19.640','2018-04-13 16:29:19.640'),('20037','20024','20024',NULL,'hrApproved','boolean',0,NULL,NULL,1,NULL,NULL,'2018-04-13 16:29:33.272','2018-04-13 16:29:33.272'),('20041','20024','20024',NULL,'reportBackDate','null',0,NULL,NULL,NULL,NULL,NULL,'2018-04-13 16:30:55.279','2018-04-13 16:30:55.279'),('20042','20024','20024',NULL,'result','string',0,NULL,NULL,NULL,'ok',NULL,'2018-04-13 16:30:55.294','2018-04-13 16:30:55.294'),('2502','2501','2501',NULL,'applyUserId','string',0,NULL,NULL,NULL,'1',NULL,'2018-04-07 00:04:58.490','2018-04-07 00:04:58.490'),('7502','7501','7501',NULL,'applyUserId','string',0,NULL,NULL,NULL,'1',NULL,'2018-04-08 11:42:04.737','2018-04-08 11:42:04.737');
/*!40000 ALTER TABLE `ACT_HI_VARINST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_ID_GROUP`
--

DROP TABLE IF EXISTS `ACT_ID_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_ID_GROUP`
--

LOCK TABLES `ACT_ID_GROUP` WRITE;
/*!40000 ALTER TABLE `ACT_ID_GROUP` DISABLE KEYS */;
INSERT INTO `ACT_ID_GROUP` VALUES ('deptLeader',1,'éƒ¨é—¨é¢†å¯¼','assignment'),('hr',1,'äººäº‹éƒ¨é—¨','assignment');
/*!40000 ALTER TABLE `ACT_ID_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_ID_INFO`
--

DROP TABLE IF EXISTS `ACT_ID_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_ID_INFO`
--

LOCK TABLES `ACT_ID_INFO` WRITE;
/*!40000 ALTER TABLE `ACT_ID_INFO` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_ID_INFO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_ID_MEMBERSHIP`
--

DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_ID_MEMBERSHIP`
--

LOCK TABLES `ACT_ID_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `ACT_ID_MEMBERSHIP` DISABLE KEYS */;
INSERT INTO `ACT_ID_MEMBERSHIP` VALUES ('1','deptLeader'),('1','hr');
/*!40000 ALTER TABLE `ACT_ID_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_ID_USER`
--

DROP TABLE IF EXISTS `ACT_ID_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_ID_USER`
--

LOCK TABLES `ACT_ID_USER` WRITE;
/*!40000 ALTER TABLE `ACT_ID_USER` DISABLE KEYS */;
INSERT INTO `ACT_ID_USER` VALUES ('1',1,'Ray','Liu','ray.liu@eeda123.com',NULL,NULL);
/*!40000 ALTER TABLE `ACT_ID_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_PROCDEF_INFO`
--

DROP TABLE IF EXISTS `ACT_PROCDEF_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_PROCDEF_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_PROCDEF_INFO`
--

LOCK TABLES `ACT_PROCDEF_INFO` WRITE;
/*!40000 ALTER TABLE `ACT_PROCDEF_INFO` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_PROCDEF_INFO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RE_DEPLOYMENT`
--

DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RE_DEPLOYMENT`
--

LOCK TABLES `ACT_RE_DEPLOYMENT` WRITE;
/*!40000 ALTER TABLE `ACT_RE_DEPLOYMENT` DISABLE KEYS */;
INSERT INTO `ACT_RE_DEPLOYMENT` VALUES ('1',NULL,NULL,NULL,'','2018-04-06 15:46:31.298',NULL);
/*!40000 ALTER TABLE `ACT_RE_DEPLOYMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RE_MODEL`
--

DROP TABLE IF EXISTS `ACT_RE_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RE_MODEL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RE_MODEL`
--

LOCK TABLES `ACT_RE_MODEL` WRITE;
/*!40000 ALTER TABLE `ACT_RE_MODEL` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RE_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RE_PROCDEF`
--

DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RE_PROCDEF`
--

LOCK TABLES `ACT_RE_PROCDEF` WRITE;
/*!40000 ALTER TABLE `ACT_RE_PROCDEF` DISABLE KEYS */;
INSERT INTO `ACT_RE_PROCDEF` VALUES ('leave:1:4',1,'http://www.kafeitu.me/activiti/leave','è¯·å‡æµç¨‹-åŠ¨æ€è¡¨å•','leave',1,'1','flow/leave.bpmn','flow/leave.png','è¯·å‡æµç¨‹æ¼”ç¤º-åŠ¨æ€è¡¨å•',0,1,1,'',NULL);
/*!40000 ALTER TABLE `ACT_RE_PROCDEF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_DEADLETTER_JOB`
--

DROP TABLE IF EXISTS `ACT_RU_DEADLETTER_JOB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_DEADLETTER_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_DEADLETTER_JOB`
--

LOCK TABLES `ACT_RU_DEADLETTER_JOB` WRITE;
/*!40000 ALTER TABLE `ACT_RU_DEADLETTER_JOB` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RU_DEADLETTER_JOB` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_EVENT_SUBSCR`
--

DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_EVENT_SUBSCR`
--

LOCK TABLES `ACT_RU_EVENT_SUBSCR` WRITE;
/*!40000 ALTER TABLE `ACT_RU_EVENT_SUBSCR` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RU_EVENT_SUBSCR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_EXECUTION`
--

DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
  `TASK_COUNT_` int(11) DEFAULT NULL,
  `JOB_COUNT_` int(11) DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_EXECUTION`
--

LOCK TABLES `ACT_RU_EXECUTION` WRITE;
/*!40000 ALTER TABLE `ACT_RU_EXECUTION` DISABLE KEYS */;
INSERT INTO `ACT_RU_EXECUTION` VALUES ('2501',1,'2501','1',NULL,'leave:1:4',NULL,'2501',NULL,1,0,1,0,0,1,NULL,'',NULL,'2018-04-07 00:04:58.484','1',NULL,0,0,0,0,0,0,0,0,0),('2504',3,'2501',NULL,'2501','leave:1:4',NULL,'2501','modifyApply',1,0,0,0,0,1,NULL,'',NULL,'2018-04-07 00:04:58.491',NULL,NULL,0,0,0,0,0,0,0,0,0),('7501',1,'7501','2',NULL,'leave:1:4',NULL,'7501',NULL,1,0,1,0,0,1,NULL,'',NULL,'2018-04-08 11:42:04.725','1',NULL,0,0,0,0,0,0,0,0,0),('7504',1,'7501',NULL,'7501','leave:1:4',NULL,'7501','deptLeaderAudit',1,0,0,0,0,1,NULL,'',NULL,'2018-04-08 11:42:04.740',NULL,NULL,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `ACT_RU_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_IDENTITYLINK`
--

DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_IDENTITYLINK`
--

LOCK TABLES `ACT_RU_IDENTITYLINK` WRITE;
/*!40000 ALTER TABLE `ACT_RU_IDENTITYLINK` DISABLE KEYS */;
INSERT INTO `ACT_RU_IDENTITYLINK` VALUES ('2503',1,NULL,'starter','1',NULL,'2501',NULL),('7503',1,NULL,'starter','1',NULL,'7501',NULL),('7508',1,'deptLeader','candidate',NULL,'7507',NULL,NULL);
/*!40000 ALTER TABLE `ACT_RU_IDENTITYLINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_JOB`
--

DROP TABLE IF EXISTS `ACT_RU_JOB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_JOB`
--

LOCK TABLES `ACT_RU_JOB` WRITE;
/*!40000 ALTER TABLE `ACT_RU_JOB` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RU_JOB` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_SUSPENDED_JOB`
--

DROP TABLE IF EXISTS `ACT_RU_SUSPENDED_JOB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_SUSPENDED_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_SUSPENDED_JOB`
--

LOCK TABLES `ACT_RU_SUSPENDED_JOB` WRITE;
/*!40000 ALTER TABLE `ACT_RU_SUSPENDED_JOB` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RU_SUSPENDED_JOB` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_TASK`
--

DROP TABLE IF EXISTS `ACT_RU_TASK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_TASK`
--

LOCK TABLES `ACT_RU_TASK` WRITE;
/*!40000 ALTER TABLE `ACT_RU_TASK` DISABLE KEYS */;
INSERT INTO `ACT_RU_TASK` VALUES ('12504',1,'2504','2501','leave:1:4','è¯·å‡å•-è°ƒæ•´ç”³è¯·',NULL,NULL,'modifyApply',NULL,'1',NULL,50,'2018-04-13 07:04:38.846',NULL,NULL,1,'',NULL,NULL),('7507',1,'7504','7501','leave:1:4','è¯·å‡å•-éƒ¨é—¨é¢†å¯¼å®¡æ‰¹',NULL,NULL,'deptLeaderAudit',NULL,NULL,NULL,50,'2018-04-08 03:42:04.751',NULL,NULL,1,'',NULL,NULL);
/*!40000 ALTER TABLE `ACT_RU_TASK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_TIMER_JOB`
--

DROP TABLE IF EXISTS `ACT_RU_TIMER_JOB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_TIMER_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TIMER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_TIMER_JOB`
--

LOCK TABLES `ACT_RU_TIMER_JOB` WRITE;
/*!40000 ALTER TABLE `ACT_RU_TIMER_JOB` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACT_RU_TIMER_JOB` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACT_RU_VARIABLE`
--

DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACT_RU_VARIABLE`
--

LOCK TABLES `ACT_RU_VARIABLE` WRITE;
/*!40000 ALTER TABLE `ACT_RU_VARIABLE` DISABLE KEYS */;
INSERT INTO `ACT_RU_VARIABLE` VALUES ('10001',1,'boolean','deptLeaderApproved','2501','2501',NULL,NULL,NULL,1,NULL,NULL),('12501',1,'boolean','hrApproved','2501','2501',NULL,NULL,NULL,0,NULL,NULL),('2502',1,'string','applyUserId','2501','2501',NULL,NULL,NULL,NULL,'1',NULL),('7502',1,'string','applyUserId','7501','7501',NULL,NULL,NULL,NULL,'1',NULL);
/*!40000 ALTER TABLE `ACT_RU_VARIABLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_leave`
--

DROP TABLE IF EXISTS `t_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_leave` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `process_instace_id` varchar(64) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `leave_type` varchar(45) DEFAULT NULL,
  `reason` varchar(2000) DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  `reality_start_time` date DEFAULT NULL,
  `reality_end_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_leave`
--

LOCK TABLES `t_leave` WRITE;
/*!40000 ALTER TABLE `t_leave` DISABLE KEYS */;
INSERT INTO `t_leave` VALUES (1,'2501',1,'2018-04-06','2018-04-13',NULL,'test','2018-04-06 23:22:44',NULL,NULL),(2,'7501',1,'2018-04-08','2018-04-24',NULL,'å®¶é‡Œæœ‰äº‹','2018-04-08 10:57:50',NULL,NULL),(3,'15001',1,'2018-04-13','2018-04-26',NULL,'å®¶é‡Œæœ‰äº‹','2018-04-13 15:08:06',NULL,NULL),(4,'20004',1,'2018-04-13','2018-04-26',NULL,'fdads','2018-04-13 16:09:43',NULL,NULL),(5,'20024',1,'2018-04-14','2018-04-25',NULL,'å®¶é‡Œæœ‰äº‹','2018-04-13 16:28:58',NULL,NULL);
/*!40000 ALTER TABLE `t_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_log`
--

DROP TABLE IF EXISTS `t_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `create_stamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_log`
--

LOCK TABLES `t_login_log` WRITE;
/*!40000 ALTER TABLE `t_login_log` DISABLE KEYS */;
INSERT INTO `t_login_log` VALUES (1,'ray','192.168.0.108','2018-04-06 00:49:22'),(2,'ray','192.168.0.108','2018-04-06 01:07:55'),(3,'ray','192.168.0.108','2018-04-06 10:15:14'),(4,'ray','192.168.0.108','2018-04-06 11:22:58'),(5,'ray','192.168.0.108','2018-04-06 11:39:46'),(6,'ray','192.168.0.108','2018-04-06 14:58:05'),(7,'ray','192.168.0.108','2018-04-06 15:03:24'),(8,'ray','192.168.0.108','2018-04-06 15:16:43'),(9,'ray','192.168.0.108','2018-04-06 15:54:42'),(10,'ray','192.168.0.108','2018-04-06 15:56:40'),(11,'ray','192.168.0.108','2018-04-06 15:57:53'),(12,'ray','192.168.0.108','2018-04-06 16:28:46'),(13,'ray','192.168.0.108','2018-04-07 06:05:19'),(14,'ray','192.168.0.108','2018-04-07 14:34:44'),(15,'ray','192.168.0.108','2018-04-07 15:45:27'),(16,'ray','192.168.0.108','2018-04-07 15:48:10'),(17,'ray','192.168.0.108','2018-04-07 15:50:14'),(18,'ray','192.168.0.101','2018-04-08 02:20:02'),(19,'ray','192.168.0.101','2018-04-08 06:44:11'),(20,'ray','192.168.0.101','2018-04-08 07:12:20'),(21,'ray','192.168.0.102','2018-04-08 09:39:56'),(22,'ray','192.168.0.101','2018-04-08 09:57:02'),(23,'ray','192.168.0.108','2018-04-08 12:19:16'),(24,'ray','192.168.0.108','2018-04-08 16:48:34'),(25,'ray','192.168.0.108','2018-04-08 17:26:46'),(26,'ray','192.168.0.109','2018-04-10 06:51:29'),(27,'ray','192.168.0.109','2018-04-13 06:59:10'),(28,'ray','192.168.0.109','2018-04-13 06:59:56'),(29,'ray','192.168.0.109','2018-04-13 07:06:52'),(30,'ray','192.168.0.109','2018-04-13 07:26:16'),(31,'ray','192.168.0.109','2018-04-13 07:39:56'),(32,'ray','192.168.0.109','2018-04-13 07:46:59'),(33,'ray','192.168.0.109','2018-04-13 07:55:14'),(34,'ray','192.168.0.109','2018-04-13 08:42:13'),(35,'ray','192.168.0.109','2018-04-13 09:58:10'),(36,'ray','192.168.0.105','2018-04-17 02:46:28'),(37,'ray','192.168.0.102','2018-04-17 03:43:46'),(38,'ray','192.168.0.101','2018-04-18 08:00:00'),(39,'ray','192.168.0.101','2018-04-18 08:02:20'),(40,'ray','192.168.0.108','2018-04-18 13:21:36'),(41,'ray','192.168.0.108','2018-04-18 14:58:04'),(42,'ray','192.168.0.108','2018-04-18 16:04:50'),(43,'ray','192.168.0.108','2018-04-18 16:06:20'),(44,'ray','192.168.0.108','2018-04-18 16:06:42'),(45,'ray','192.168.0.108','2018-04-18 16:22:04'),(46,'ray','192.168.0.108','2018-04-18 16:22:10'),(47,'ray','192.168.0.101','2018-04-19 01:20:02');
/*!40000 ALTER TABLE `t_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_group`
--

DROP TABLE IF EXISTS `t_rbac_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_group`
--

LOCK TABLES `t_rbac_group` WRITE;
/*!40000 ALTER TABLE `t_rbac_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_group_role`
--

DROP TABLE IF EXISTS `t_rbac_group_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_group_role` (
  `group_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_group_role`
--

LOCK TABLES `t_rbac_group_role` WRITE;
/*!40000 ALTER TABLE `t_rbac_group_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_group_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_menu`
--

DROP TABLE IF EXISTS `t_rbac_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_menu`
--

LOCK TABLES `t_rbac_menu` WRITE;
/*!40000 ALTER TABLE `t_rbac_menu` DISABLE KEYS */;
INSERT INTO `t_rbac_menu` VALUES (1,'OAåŠžå…¬','/oa',NULL,1),(2,'ç³»ç»Ÿè®¾ç½®','/sys',NULL,2),(3,'åœ¨çº¿å¼€å‘','/generate',NULL,3),(4,'æµ‹è¯•','/test',NULL,1),(5,'dfsaf','fdsa',NULL,NULL);
/*!40000 ALTER TABLE `t_rbac_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_operation`
--

DROP TABLE IF EXISTS `t_rbac_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_operation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `filter_url_path` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_operation`
--

LOCK TABLES `t_rbac_operation` WRITE;
/*!40000 ALTER TABLE `t_rbac_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_page_element`
--

DROP TABLE IF EXISTS `t_rbac_page_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_page_element` (
  `id` bigint(20) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_page_element`
--

LOCK TABLES `t_rbac_page_element` WRITE;
/*!40000 ALTER TABLE `t_rbac_page_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_page_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_permission`
--

DROP TABLE IF EXISTS `t_rbac_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_permission`
--

LOCK TABLES `t_rbac_permission` WRITE;
/*!40000 ALTER TABLE `t_rbac_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_ref_group_user`
--

DROP TABLE IF EXISTS `t_rbac_ref_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_ref_group_user` (
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  KEY `fk_gu_group_idx` (`group_id`),
  KEY `fk_gu_user_idx` (`user_id`),
  CONSTRAINT `fk_gu_group` FOREIGN KEY (`group_id`) REFERENCES `t_rbac_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_gu_user` FOREIGN KEY (`user_id`) REFERENCES `t_rbac_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_ref_group_user`
--

LOCK TABLES `t_rbac_ref_group_user` WRITE;
/*!40000 ALTER TABLE `t_rbac_ref_group_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_ref_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_ref_perm_element`
--

DROP TABLE IF EXISTS `t_rbac_ref_perm_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_ref_perm_element` (
  `permission_id` bigint(20) NOT NULL,
  `page_element_id` bigint(20) NOT NULL,
  KEY `fk_pe_perm_idx` (`permission_id`),
  KEY `fk_pe_element_idx` (`page_element_id`),
  CONSTRAINT `fk_pe_element` FOREIGN KEY (`page_element_id`) REFERENCES `t_rbac_page_element` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pe_perm` FOREIGN KEY (`permission_id`) REFERENCES `t_rbac_permission` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_ref_perm_element`
--

LOCK TABLES `t_rbac_ref_perm_element` WRITE;
/*!40000 ALTER TABLE `t_rbac_ref_perm_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_ref_perm_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_ref_perm_menu`
--

DROP TABLE IF EXISTS `t_rbac_ref_perm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_ref_perm_menu` (
  `permission_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  KEY `fk_pm_perm_idx` (`permission_id`),
  KEY `fk_pm_menu_idx` (`menu_id`),
  CONSTRAINT `fk_pm_menu` FOREIGN KEY (`menu_id`) REFERENCES `t_rbac_menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pm_perm` FOREIGN KEY (`permission_id`) REFERENCES `t_rbac_permission` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_ref_perm_menu`
--

LOCK TABLES `t_rbac_ref_perm_menu` WRITE;
/*!40000 ALTER TABLE `t_rbac_ref_perm_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_ref_perm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_ref_perm_operation`
--

DROP TABLE IF EXISTS `t_rbac_ref_perm_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_ref_perm_operation` (
  `permission_id` bigint(20) NOT NULL,
  `operation_id` bigint(20) NOT NULL,
  KEY `fk_operation_idx` (`operation_id`),
  KEY `fk_perm` (`permission_id`),
  CONSTRAINT `fk_operation` FOREIGN KEY (`operation_id`) REFERENCES `t_rbac_operation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_perm` FOREIGN KEY (`permission_id`) REFERENCES `t_rbac_permission` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_ref_perm_operation`
--

LOCK TABLES `t_rbac_ref_perm_operation` WRITE;
/*!40000 ALTER TABLE `t_rbac_ref_perm_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_ref_perm_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_ref_user_role`
--

DROP TABLE IF EXISTS `t_rbac_ref_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_ref_user_role` (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  KEY `fk_ur_user_idx` (`user_id`),
  KEY `fk_ur_role_idx` (`role_id`),
  CONSTRAINT `fk_ur_role` FOREIGN KEY (`role_id`) REFERENCES `t_rbac_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ur_user` FOREIGN KEY (`user_id`) REFERENCES `t_rbac_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_ref_user_role`
--

LOCK TABLES `t_rbac_ref_user_role` WRITE;
/*!40000 ALTER TABLE `t_rbac_ref_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_ref_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_role`
--

DROP TABLE IF EXISTS `t_rbac_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_role`
--

LOCK TABLES `t_rbac_role` WRITE;
/*!40000 ALTER TABLE `t_rbac_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rbac_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rbac_user`
--

DROP TABLE IF EXISTS `t_rbac_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rbac_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `cn_name` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_user`
--

LOCK TABLES `t_rbac_user` WRITE;
/*!40000 ALTER TABLE `t_rbac_user` DISABLE KEYS */;
INSERT INTO `t_rbac_user` VALUES (1,'ray','7c4a8d09ca3762af61e59520943dc26494f8941b',NULL,NULL);
/*!40000 ALTER TABLE `t_rbac_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-19 15:24:28
