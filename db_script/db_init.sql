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
INSERT INTO `ACT_GE_BYTEARRAY` VALUES ('2',1,'flow/leave.bpmn','1','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.kafeitu.me/activiti/leave\">\n  <process id=\"leave\" name=\"请假流程-动态表单\" isExecutable=\"true\">\n    <documentation>请假流程演示-动态表单</documentation>\n    <startEvent id=\"startevent1\" name=\"Start\" activiti:initiator=\"applyUserId\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"请假开始日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"请假结束日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"请假原因\" type=\"string\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"validScript\" type=\"javascript\" default=\"alert(\'表单已经加载完毕\');\"></activiti:formProperty>\n      </extensionElements>\n    </startEvent>\n    <userTask id=\"deptLeaderAudit\" name=\"请假单-部门领导审批\" activiti:candidateGroups=\"deptLeader\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"请假开始日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"请假结束日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"请假原因\" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"deptLeaderApproved\" name=\"审批意见\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"同意\"></activiti:value>\n          <activiti:value id=\"false\" name=\"拒绝\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <exclusiveGateway id=\"exclusivegateway5\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <userTask id=\"modifyApply\" name=\"请假单-调整申请\" activiti:assignee=\"${applyUserId}\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"请假开始日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"请假结束日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"请假原因\" type=\"string\" required=\"true\"></activiti:formProperty>\n        <activiti:formProperty id=\"reApply\" name=\"重新申请\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"重新申请\"></activiti:value>\n          <activiti:value id=\"false\" name=\"取消申请\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"hrAudit\" name=\"请假单-人事审批\" activiti:candidateGroups=\"hr\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"请假开始日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"请假结束日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"请假原因\" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"hrApproved\" name=\"审批意见\" type=\"enum\" required=\"true\">\n          <activiti:value id=\"true\" name=\"同意\"></activiti:value>\n          <activiti:value id=\"false\" name=\"拒绝\"></activiti:value>\n        </activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <exclusiveGateway id=\"exclusivegateway6\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <userTask id=\"reportBack\" name=\"请假单-销假\" activiti:assignee=\"${applyUserId}\">\n      <extensionElements>\n        <activiti:formProperty id=\"startDate\" name=\"请假开始日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"endDate\" name=\"请假结束日期\" type=\"date\" datePattern=\"yyyy-MM-dd\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reason\" name=\"请假原因\" type=\"string\" writable=\"false\"></activiti:formProperty>\n        <activiti:formProperty id=\"reportBackDate\" name=\"销假日期\" type=\"date\" default=\"${endDate}\" datePattern=\"yyyy-MM-dd\" required=\"true\"></activiti:formProperty>\n      </extensionElements>\n    </userTask>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <exclusiveGateway id=\"exclusivegateway7\" name=\"Exclusive Gateway\"></exclusiveGateway>\n    <sequenceFlow id=\"flow2\" sourceRef=\"startevent1\" targetRef=\"deptLeaderAudit\"></sequenceFlow>\n    <sequenceFlow id=\"flow3\" sourceRef=\"deptLeaderAudit\" targetRef=\"exclusivegateway5\"></sequenceFlow>\n    <sequenceFlow id=\"flow4\" name=\"拒绝\" sourceRef=\"exclusivegateway5\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${deptLeaderApproved == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow5\" name=\"同意\" sourceRef=\"exclusivegateway5\" targetRef=\"hrAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${deptLeaderApproved == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow6\" sourceRef=\"hrAudit\" targetRef=\"exclusivegateway6\"></sequenceFlow>\n    <sequenceFlow id=\"flow7\" name=\"同意\" sourceRef=\"exclusivegateway6\" targetRef=\"reportBack\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${hrApproved == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow8\" name=\"销假\" sourceRef=\"reportBack\" targetRef=\"endevent1\">\n      <extensionElements>\n        <activiti:executionListener event=\"take\" expression=\"${execution.setVariable(\'result\', \'ok\')}\"></activiti:executionListener>\n      </extensionElements>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow9\" name=\"拒绝\" sourceRef=\"exclusivegateway6\" targetRef=\"modifyApply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${hrApproved == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow10\" name=\"重新申请\" sourceRef=\"exclusivegateway7\" targetRef=\"deptLeaderAudit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${reApply == \'true\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow11\" sourceRef=\"modifyApply\" targetRef=\"exclusivegateway7\"></sequenceFlow>\n    <sequenceFlow id=\"flow12\" name=\"结束流程\" sourceRef=\"exclusivegateway7\" targetRef=\"endevent1\">\n      <extensionElements>\n        <activiti:executionListener event=\"take\" expression=\"${execution.setVariable(\'result\', \'canceled\')}\"></activiti:executionListener>\n      </extensionElements>\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${reApply == \'false\'}]]></conditionExpression>\n    </sequenceFlow>\n    <textAnnotation id=\"textannotation1\" textFormat=\"text/plain\">\n      <text>请求被驳回后员工可以选择继续申请，或者取消本次申请</text>\n    </textAnnotation>\n    <association id=\"association1\" sourceRef=\"modifyApply\" targetRef=\"textannotation1\"></association>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_leave\">\n    <bpmndi:BPMNPlane bpmnElement=\"leave\" id=\"BPMNPlane_leave\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"10.0\" y=\"30.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"deptLeaderAudit\" id=\"BPMNShape_deptLeaderAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"90.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway5\" id=\"BPMNShape_exclusivegateway5\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"250.0\" y=\"27.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"modifyApply\" id=\"BPMNShape_modifyApply\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"218.0\" y=\"108.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"hrAudit\" id=\"BPMNShape_hrAudit\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"358.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway6\" id=\"BPMNShape_exclusivegateway6\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"495.0\" y=\"27.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"reportBack\" id=\"BPMNShape_reportBack\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"590.0\" y=\"20.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"625.0\" y=\"223.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"exclusivegateway7\" id=\"BPMNShape_exclusivegateway7\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"250.0\" y=\"220.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"textannotation1\" id=\"BPMNShape_textannotation1\">\n        <omgdc:Bounds height=\"57.0\" width=\"120.0\" x=\"361.0\" y=\"174.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow2\" id=\"BPMNEdge_flow2\">\n        <omgdi:waypoint x=\"45.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"90.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow3\" id=\"BPMNEdge_flow3\">\n        <omgdi:waypoint x=\"195.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"250.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow4\" id=\"BPMNEdge_flow4\">\n        <omgdi:waypoint x=\"270.0\" y=\"67.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"270.0\" y=\"108.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"280.0\" y=\"67.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow5\" id=\"BPMNEdge_flow5\">\n        <omgdi:waypoint x=\"290.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"358.0\" y=\"47.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"300.0\" y=\"30.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow6\" id=\"BPMNEdge_flow6\">\n        <omgdi:waypoint x=\"463.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"495.0\" y=\"47.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow7\" id=\"BPMNEdge_flow7\">\n        <omgdi:waypoint x=\"535.0\" y=\"47.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"590.0\" y=\"47.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"544.0\" y=\"30.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow8\" id=\"BPMNEdge_flow8\">\n        <omgdi:waypoint x=\"642.0\" y=\"75.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"642.0\" y=\"223.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"652.0\" y=\"75.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow9\" id=\"BPMNEdge_flow9\">\n        <omgdi:waypoint x=\"515.0\" y=\"67.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"514.0\" y=\"135.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"323.0\" y=\"135.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"22.0\" x=\"525.0\" y=\"67.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow10\" id=\"BPMNEdge_flow10\">\n        <omgdi:waypoint x=\"250.0\" y=\"240.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"142.0\" y=\"239.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"142.0\" y=\"75.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"44.0\" x=\"152.0\" y=\"221.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow11\" id=\"BPMNEdge_flow11\">\n        <omgdi:waypoint x=\"270.0\" y=\"163.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"270.0\" y=\"220.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow12\" id=\"BPMNEdge_flow12\">\n        <omgdi:waypoint x=\"290.0\" y=\"240.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"625.0\" y=\"240.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"11.0\" width=\"44.0\" x=\"429.0\" y=\"247.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"association1\" id=\"BPMNEdge_association1\">\n        <omgdi:waypoint x=\"323.0\" y=\"135.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"421.0\" y=\"174.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('3',1,'flow/leave.leave.png','1','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0\0\0\0h\�ʈ\0\0F�IDATx\�\��T\���G4�\��1�=�Ġ\�c�b�&�$�Qga\�\Z��\Z)�RDP��4�\"\n�B6��\� M!��\" ����\�9w�;\�\�\�l��\��}�\�\�\�\�\�{\�w\�o���sB!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�8c�.[�l\�)S\�\�ѣ\�ȑ#�4�Q�F�	&�փ��/0\��?�O(e\�0\'N46l0{�\�\�\�\�6n\�hƍw\�:P\'�T����/\0�\�?�\�/F&�\���\�˓\n\��\���\'�\"ze\�Ùަ\�)<�@}�Q_\0��B)��\�\0P_P_\0��\�8M\��\�Z�l��f��6�i]�x�q\Z������\0�\�?+�\�l߲\�\�\�\�\�\�8�i���`\�4i\�9\\\�\�|\Z�\�?�O(�Y�\�\�ƷU\�\��\�i҅\\k\�-�����\�?�O�J\�4�\�>�\�it��I�X;hm�[�\�P_P_\�\��\'��B��f�\�V	�F\�x�q�4i,[�Gh4�/�/�i��\�?O>�\�9ݻw��m۶;sssԯ_\�Ԯ]\�\�u\�]�\�w\�}�I�&۴i�˖[زe\�\�q\Z��F-�\Z\�\���Ƙ\�O}�Q_d�O�ڟ�O�3.O?�t�V�Z\�S��iѢ�y\�w̼y�A��\�\�o|6m\�d/^l�n:u\�d���%��\�\���^�z\�\�*�\�{4�\�\�6�Z�\�-�Q�\�C\�wT\�\�Ӿ\�}uκx�c*��=&�Q�}=K\��\�\�;[��\�\�\�1\��\�i\�ә\�\��\'���\r\Z��Y�f�\�֭k\�\�dطo��4i�\'�\�ׯ�~\�ӕQ/�\�5�\�\�6�Z\n\�\�\Z\�r��Al\�o��D\�uLe��i�\�rcZ5\�;k�]���iw\�D\�T�����E\��t��3��\�a�\�\�{\�׼�\�kf\�Ν��L�>\�ԫW\�<�\��k#�\��IoZ=\�\����\�_�\�}:ƃM���ץ�eT�؍\�G[LoE��6|�\�h4o\�5\�|\\���V\�ꋴ�\�L�g���x\�\'>�\�Cf\�̙�4ٶm�\�֭�\�\�\�\�\�w\\ZYD�l��\�s\Z\�㡦QKQcٺ�\�bG�\���AF�\��M{O\�\����s��}:F}�U��\"\�|:S��\�?=��\�{��e\���M�:u\�y\�7T\n�g�Y2�\�\�N\�>\���QK�Ʋ\�_�͆\�\'\�\�3\��5\�>q�,\�h\�i�ʧ[��x甠i��Q_`���HK�\�T\�?+�*B\��>\����p\�G�s\Z\� �Ť.	s�t�Yfh\�ʁ\�Rj\�r˺\�TǙ�?�ڼ��IS_P_T�\�T\�?+���r�\�̙cʋ7\�xc\�ڵ\�f�\�	�\��\"\\�d��lx�\�ʨ,�\"�e\�X�\�k\�&e\�h6\�:�\�vCW,�i=�ќaLG�~\�cZ\�\�Co1�\��kWo3��V	ꋴ�\�L�g���\�O<�[�\�ʛG}�@8T�Dpa��I���ץ~cY\�Z/�L�\�ϕj>aL\�AӾf}g~\�:\�\\�\�5vy��*U\�2v\���e\�3�Y�Y*w\r�V�담�\�L�g�����\�\�0h�1\nD��^�\�dee�B���\"���k��_�<\�\�2��\\\�[VI�����Rm4��M���d�9\�5d�۾\�E�\��7}\�\�\�\�_��_\�nL\�\�q\�\����3՟�\�JꟚcȐ!&Ut\�\�a\�]w\�5���\�\�:�o<\�\�2z�\�\�5z&�F3\�X�\�3\�kY�c�������O�3��SS!k&�d\'\�(\�h�+�fbnpQ�T�h\�ʑD�X�Ư�F��囄\�\�\��4��e��\�\�c�ftK5<��\�H$R������Q����PX���6�\�6�e>�FE�_\�������O,\r��m۶;\�����\�Ν;oK����I��g�m\n�\�u�|]ZX�UXc�lc��*cD������R�`|\Z�\�\�\�?sss̛7/\�\"x\�ԩ��\�܂\�`�\�|ϟo�Q�\�\�\�D�\�Q\�l,{m[YDp�����O\�X\Z�g���\�er�\�X�n\�~�P�i0Dp\�\�/\�GY�簸�{�\Zͽ%h,Kz>Iǽ_\��`|\Z�\�\�\�?k׮m�\�\�o\�=�8M\�m׮]fǎ�g�پ=�\�ڽ{w�\�[���\�|�\r\"�����e\�\rEI�4�\Z͒4�ɾƭ\�\"8\��*��\"]|߷D\�k{�\�1\�ׯ��E)���w��k��`|���g&�raV>�R�\��.d�N�Ӵn\�\�<��\�\�z׮]�CmjԨa�U�\�˾�\�\�.s\�\�N;ʹl\�\������K�.^y{͚5�D\�^hƍ\�m+=\�\�O4�V�*�\�[�v�i޼����\�\�z�\��7d�F�J�.½\�H\��t\r۬>\�Gŉ\�u�K¬�z\�kũ/\�\��c\��\�?���x\r��5i\�$\�y\������*�1\��g�76\'�p�4hP���0��\��s\��O~�\�\�JP\���.]���>�y��\��\�3ϘH$\���צO�>\��1\�㝃�\����uND��!�q���駟�3\�8\�<�\�s\���㏛?��\�.�\�5jd,X\��}�\�\�W\\ato�������\�o\���\�7�P\"U\��\�˽�3f\���\�n3\�^{��~��כ\�/�\�[\��x\�Δ�Q�\�?\�<�\�c\�O��\�޽��R�J�C	.�a;쏯ց\�K:}*Q�r�_ũ/\�\��cm\���\�;�l\�2��}�\�\'=kذ�wZ��t\\\�tm�=�Xs\�\r7$�\�|\�;fҤIސ�}��5\�{���\�/\�\�g�mF�Q*\"8�`|:��3�}Yod\�?�|\�\�N?�t���\�{\�7z�hO��\�\�Q�g�\�DNp�lܸ1\�s�S\�4A\�/DE[_x\�\��=�\�S\�q\�\�_y\�y��\�OZ=��	�{\��T��\Z�\��*g<\��r\�\�\�\�1-���:�\�yz�\�i^�u\��H�\r\��\�\�=�\�C���s\�9�ȯ=��>�\r%��x��[_��\�\�\�\�l�<�H�y�\�\�\�z\�-\�\\�ߘ_�\�W\�\�\�R\�گ\�*7a\�s\�5\�\�{��o0��~�\�٦W�^\�\�\�w����}���\�,0�\"\rD0>]A�3S}YoS�>�h3f\�O(+��\�+�x\�W���\�\�}V~�\�9e\�d�\�#F��\�V�\�pk۶�\����\�ͬY�\�w\�\�\�e�]f\�<�̼m�S\�Q�у�_u�\\r��\ZF��>#�=\�?��Ͻ[V�\�R\�ڟ\�y\�/���\�h-Y�\��%9mڴ<|뭷�\'�x��\��?\�\�\��E�H&\�(\r=\�Sp���/\�\��cM�&}V�A\"|\�)�x�\�?�����\�\�~_\�Ԑꍒo*�\�\�~7o[�`\�CH\�5\������R�\�i�\�A\�\�\�?3ݗ��!߹��\�=�3gN��f��\�I�SF��\�$M\�	��\�n�/����zB� \�\�(�.hzؕT�^=\�����*B�x�b3e\�ӱc\�<�_o\�9� w\�\��h\�=\�Zj[�9�^\�\�s��\�\����\�\�\n\"�\�\�_AQ��Fk\�jL\�\�P\�\'�H�+\��\"}?\�\�\'\�\�?���\�O\Z�\�\�ĉ��B�<_�-�}S�N\�\'l�R�âE���:���\����+����\����w�-\�0��`�Y|YoV\�/J�곟|�.S�K\"8\�sʘ��[�n\�۵k�r��\�\�b�N�8\�NΣ�\�\�\\/\��뮻\�K��_�(I\�P�=�jt�:\�(\��\"+z\�}\�Q���k֬\�9��\�\��DΣ\�#z\r:lذ<����\�\�>�̜|�\�fŊ�\�򥰨MY\�.\�>�Z_��\�M\r����}/��?���\��+ӿ\�|dw\�y��w�Զ^��|a{\�G�\�}\�{�\"�\�V��/�\'O�\�\�$긭�3\"\'�����ɾ<s\�Lבֿ�\�\�7\�\�8\�z��\�L���=\�sʘ��Q�F�\�\"\�ܹ3�cP\�Ĝ��q���GC�\�y�����T\�;�,���i\�&o�M7\�\�\�W�ŏ\�\�W�r�d\�*\�\�ߧ\�\�I�2\�`]t���{\�`W���\n\\\�$�%\��<�Dp:��l۶m淿�m\�\�\�\�R���\\~5��^zi�]|�\�\�\�\�R\�\'�tR^G!_K+7Q%�իcm_}�\�y\"X�\�H\���\�!*�Ƨ+�N_V*�ޠH̪ӛ�O�2d���U�Z\��ɞSF�\�M�6ݧ^���k׮;\��\�8M�Σ�ѷ\�r�ף�w���i߾�gJNO\�<���\�\�|�M�7�zq��Eh�\�\�^�\��\�W�D\"X�B�_��\�/B�_5fj��)�ž\�\�U�ס�\Z͞ID��Dp����&�w�#lٲ%o�\�_��\�^����!���w��W�\�VOs\��x\�|�?��g�\���\�XܬY3oH�\nT_\�\�@��/\�~����\�\�{>�\����~\�\���\�\��\�)\�\��\'�x���\�H\�Pi�L���ڋz%N�ؔn��S�I�7t��H\�<��j��\�R�[�r�u\�\�y\rE0�ATt\\\�\��DQ�\�{\�\�sf�\��E��>\��\r��L��ڕX�\�8�_2c}�R\r����\"\�|_����N>��`4\Z�\"�g�uV\�آ�*i�\'�\���J\�\�^�C��Dck\�\"�U�J\�\�M�\�\�|��\�W\"X)WJ��U��7ܚ>3v\�X�?�����\��t�\�\�؎\�-�ҍ4����>�||ߟ%v�6�\�9ed{n+�\��P\�\�����\�l\���\�~\�UBS\�\����\0���,�5�R�;�\�у�\��z��9�:� �VoV�\�V(6�\�\��5j�Iv��\�\�\��\�R_��\��\�\�\�k0�p�i�:\�\�\nP\�J�\�o\�\�V��G\�Nq�\����x����ih5��\�\�7\�x��9\r\��\�W_U\���\�\��<\�q��Ո\�\�V\"X?H�\�+?�\'\�)\�9eD{^�^�f\�������5k־���}V<��\�\��������\�\\:;��w��7\�\�7\�t��.�\�ֲ(硿\�Gz�\�\�\�/ǲ�%�.q�Y�e�\�t��\�Dl�\�\ZGX\�U쟫r\�\�D\���.����R_\�\�ޞ��/ǚ���YE���Z\�sʘ���X�WN\����4�Z�j5�i0Dp\�4��n\"\�\�|\Z�\�*�j8�{\�\�[�\�*K5\�\�\�\�qCq\Z�F�\�(\�\�NR �/�/�i�����/�S�\�Auf(���]w\�5��h\�R\�h&����>�b\�?5R�\����\�{�r�V�0N�\�d0ɾ�\�u)��>�b�\�?�bx�F�PtI�A\�(\��\�9�8\rNSɄpv��0�/�/�i����i\�� +^<��\�{�-[v ٙ\�w\�S\�_�=2y�����\�����������O�r��\�\�]w\�5\�\���\�ooǎ��3f\�+�\r#�iӦS�N\�չs\�m?�����\�2u\"���\�a^�R_P_\�\��\'�\�D�\�:A�\�ڷ֌oV��\�\�֦\��999\'\�4�Z\�5�4�\�\��4��ៀ\�\�4�JϢ��������O����L\�\�N��C&S\�sqъ��\�g\�\��>�b�\�8\r�Ӥ��,b{i\�h3��eZi\�Or_��6h��C�\\�Nm�\�\�Oh\�c\�\�=\�<n\�\�\�N����/\�M��O\��\'\�48\r���\r\�M��������\�:crs,X�4^\�6��.�\�n�v��\�\���%�{}�y\��\��\�}WR_`\�e\�\�7\�|>�⟀\�\�4P�\"�\�wטך�2u\�\"c�Q�\��:d�yS6|�\�\�\�]\�fв/f\��k>k\�u����i�\�\"3\��V��%\�����\�\�\�>�\�?�O�ip\Z(E|u�סj0�\�Z�DeM{Oߢ2c��\�j\�1�\�6�5\�9e��+M�&�D�ڦ���/\�̟ϲv�\�?�O(F�̓�\�T>\�@SOQ�g��բ\�W�\��\�\�hN1\�yo�-\�Nuy��6�F}Q�\�\�\�\\�\�\��\'�	e\�ĉlذ��3MmժU_Y�\�˓Z�\"X�ﮝ�\����>��!�)7\�E��n\�sʎ\�#�M�x�\�լόM�\�\\���JZ>\�o\�z\����l�]��\�֧\�\��\'�	e1c�7n\���\�\�󐦡Ì\Z5\�[k�xRK9\�ߓ\�E�.V\�pg\'�2�oL�<\�\�Q�Q\"��[�/0\�2�\�\�5\�+>�\�Pf؛\�\��:١0}&\������2��\�^�LE�1\r\�qʜ�5�(��a�\�:g�\�w\\�\�\�\'�F}Q��\�\�4�+>]y���m��#͈��\��pxtl\�a\��O��h�FcKr5��4�W������m�1�ST\�-\�r�\�0��]��r��>\�o޺�o,\\!\�\�W{\�G\\y�\�\'�\\g}z>M�^Joq�S���Ӱw\��6v��{N��!�d-\�_����5�Q��f}f}m�����1�+gq�\��\����7UC\�\�5\ZH\�n\��y�\�\�1���\�~^eL�f�foP\�ʶ\Z��r\�\�&m\�a\�\rY�����\�Q\�D��&\0d�?\�jmW�:� &0]{L6��\�b���k.6�[\\�Ջ#�MѺRe�]\�\�1va�5}\�ӭ\�\�;�\�˓wZ\�ܶ\�\�}���Lt�\�\0�,�\�\�Pa@撕�U\���n�uzA(\�a�r3�\��K\�N8`�<���ٚ4E\�\"�\�K�6\�2\�Dp�6�Yo�8v\�2\�)!\�d]�V4�\�`*L\0\�\\\"\�ӻ�\�酈\��\�pwZ*���]W~��Q���%��|෽t�j��\�\���\���	S\�W2\�A�\�`\�l�ٞ+D�	\0]��\�F�^���㰯g=\�u��Zj\n\�k\�\���x\�]�\\\�\�U\��\�_��\�p5k\�(�b�1͕/l��\�C&9\�\�D\"\�\�v�&\0d&�\�3�8uz��;�)�i�\�ߴ�\�Y\�\��Ɗ`/<h�\�\�5\�ji\���i>\�C�E	LAFn0&\0d&�H���\�\\	\��B1�J\�\�37+\n\�c�\�9^$\�\�	����v\�D�Kt�h\�t	�Lp�u��`^�Qa@Ɗ\�ֶp%�\�\��\�\�g���\�.�&�\�\��\�>�z��\�\�0jA\�G�5�p�AK�h�\���m\�\�\"��\0�Rjժ\�\���&�uzi���kL�|K\0��\0�.dee5�\��\�\�\0�\�\0��2�s+k\�\�\�\0�\�\0��2��3\�\�r%�\�\0�\�?@�!++�c8^ŕ�N\0��\0��H$\�\���\n�u:\0\�0���L�\�\�\�r�u:\0\�0���4�\�ទHd)W�:\0p\��T\Z�\0\�k}�s�u:\0\�0���L����E\\	\�t\0�a��Pi�\��O\�\�JP�\0\��JC$l���u:\0\�0���L�����\\	\�t\0�a ��^��]�\�\�Jd���om\ZW�6\0p\����\�p�5W\n 3��;\����m:\0\�0p��\�X�\�^�z��\\%���\�Q\�&r%h\�\0��\�\�w\�hp$i\�\�h�gm,W�6\0p�\�\�\�\� \n���I8ɕ�M\0\�\��lr�*�oOQ^0W�6\0pH|\�\��p~=M#Dp%h\�\0���\�\��\��~=+�\�JЦ\0\�{/7�(0@��\�V\�JЦ\0\��l\�?@��\��V\�JЦ\0S\�c�.[�l\�)S\�\�ѣ\�ȑ#�4�Q�F�	&�փ�*q}�\�\�\�\\	\�t\0�aJ	\��\'�\r6��{�bid7n4\�ƍ;hq\'�T��D\"�/jժՇ+A�\08L��08���ȑ#��B%�\���_\�JЦ\0S\�(��ަ��T����rk]��\�\0�Ô:XMD0@�\�\�+\"�Hg�m:\0\�0)�;�Yk�M\�,\�\�3�k\"P���\�p8�W�6\0p���\�\�[V��#Z��\�\Z\�3\�\�1�*\"��\��H\�i�m:\0\�0)�+�w�\0�mՂ���`���\�\�[kŕ�M\0&%\"x\�\�g�`C�\"�ʂp8�1++�9W�6\0p���\��#[%�:�PE�Q}�\�Z#�m:\0\�0�`D0@�!o�u����\�\0�äDk4�D\"X\���`�� �l�U�\�\\	\�t\0�aR\"��L\�P\�BPF���p8\\�+A�\08LJD�\��\����:<\�\�\�1�*\"��\��ֲ��\�\0�äD˖\�x�0�}�TD0@Y�wծ];̕�M\0&5\"x\��dr�\�S!\�>C�\"�ʨ>\�]�V�۹�\�\0�Ô�֌p_L\�0\'Xǘ5PF��k�r%h\�\0�)?�g�Y�d��lx�\�7�QY�`�R�\��E\"���\�\0�Ô�.,�KTPN����jպ�+A�\08L��\�D�\n#\\�\0�T�\��[�m:\0\�0\�\"��+�}C�\"�JQ_Ε�M\0�\\D0�H���@\�ڵ/\�JЦ\0�F\�{泭�\�i�\nX��\�p%h\�\0�A#�c\�\�:=�<�P��\�\�w\��#�m:\0\�0�`D�a\��>\�\�\�>�+A�\08\"��\�p8\\Wi�\��>��\�O\�JЦ\0��\"x׮]fǎ�g�۾=�\�ڽ{w�\�[����\��\�ܹ3o{OM�Q\�u)�\r8\�ċ�\"��2\�\�5k\�<�+A�\08LZ�\�֭[���~\�[\�ڵ�\�ܹ��Q���V���.�\�/�í͝kN;\�4ӲeK�׿�ճ.]�x\��\�5k\�\�}�7\�|c.��B3n\�8o{޼y\�\�O4�V�*�ڶmk:u\�\��\�����\�[�\�ӧ��>�\�\�w\�}\�\�k�5]t��.�iZs�\�w{W�~��\��Ɔ\r̑Gi���\�_�d�0�a٨�iӹ\n\08Lڈ\�O?�Ԝq\�\�\��\�\�\�?n��\�?�.��[oԨ�Y�`�W�\�6W\\q��]����\��n������\�߼�\�k�w\�޺Wf��\�^\�3fx\��\�n�D�֯��zs�\�{\�:�\�&O�lN9\��ꫯ�c�=\�\�O=��\'r\�|�M�\��\�>\�̟?\�<��\�����?�\�_|�ES�Js\�uי_�\��h�2e���|��\'le���\��6i\�$o��\�\'�V�ZM\���\0\0�\�\0�ä@\�\�\\�v�y\�\��\�oN=�Ts\�q\�y\�W^ye^TWQ\�\�͛{\"�nݺ\�{\��D��\�#�`�\��\�;\�+���\�\�R\�گ\���\�-[<�\��\���׿�įīĭD�W_}e~�\�zZ�\�\�~g\�9\�s\�G��\�z\�\�\�\�nݺ\�}�D���^ꝃ\"\�:���,o[�u<\�\�R\n\�r�mE\0m:\0\�0\�$��v 1��\��\�̚5\�\�q\��]v\�e\�\�3\�\�\�V��W�^�h\�g$�%�\�K��Ew���\� ����\�͏=���Y-����D�N7\�p��-<j\�(/\n}\�5\�xQ]_+�\�ꫯ�\�\�	\'�\�\�߿�\�U$YQ\�͛7\����\\�\�\�:�iӦy\�\�\�\�d�Ki\r�\�\"\�[�\0@�\08L�`	��^z\�s\�1^\�S��<�H>�hU.o�z�<�\�\�\r\Z�ŋ{��cǎy�lٲ<,�ܡCӢEOpj�m\�O$�uN\�?��9�\��D���\'�\�}\���^�\��cǎ��\�\�_l\�>�l/UC\"XZۊ+Ub�\�\�y\"�jժ椓N�\�:\'-����N溔�d�o\�i\0\�t\0\�H\�.\\\�=�+\�@\��h��j\�\�O\rPځ/���\�ƍ���:\�Ku�\�w�k>�\�<,!Z�N�����\�\���\�!}\r�\�C�z�S6hР<�\�au��h~�\�G�\�a�AH��3\��>�`^4X\"�aÆy\�tN~\�8\��C��0m2\0\0m:\0��\"XC�I\�)��OmP\'��\��\�6m\�\�\�馛��\����\'S���W^�L#)Hpj\�\���`\r{��\�|ǋ�����r|�\�\�`��DȔ���\�o\�4bE0⬳\�2իW7�\��\�j[�\�\�\\D0\0\0m:\0��\"XBSÎ=�\�^\��\�\�{��o�D�>�Nb\Z��o߾ވ��bJI� �M\��Z��\\\"���:}�\�\���\�7��ͱ\"Xv�\�7�ѣG\�\����o���r\��Ոo��\'\�UV\�cmG\"oć\�\\D0\0\0m:\0�a\"xذa�\�(J7�=�.$��\Z	By�J\�wH0�[�\�,]�\��^ߔ��\�Z��\\�s\Z0`�������̙3�a\�d\Z\�\"Mwlܸ\��\�W�2��\�\�ԩS��ӽ{�<S\�r�	>b\�!Jr]�\0\0�\�\08L��`�u�4?�U9�Z\���\�h��\�?L�Ј\�p\���`}G\�\�P\�2	J-�rN��&M�\�V��\���\�4\n���\�C.\�T.Y�\�uA\0Ц\�0&�cŪ?ę�VT7x\\#?�^�\��\���\��+�7-��KQZ-�=�\�t\�2�_\�\�\�U\�;�sq�\"\0�6\0�\�`���!��6\0pD0\"\0�6\0pD0\"\0�6\0��a��`\0\0\�t\0��`\0\0\�t\0��`\0\0\�t\0�\�D\0Ц\�0�`\0@��\� �1D0\0\0m:\0�\��\0\0�\�\08\"C\0Ц\�0�`\0@��\� ��\�ٰaÌ}�\�\�i\0\�t\0�a��\�:v\�(,k\�\0�\�\0�Ô�G�Fh��u\�\�Axw$��\�Y8~\�nߙ��S�\'\0h\�\0�)\'N<�a\�\�f�ڪU��\Z9r\�^+�O\���\��D+��\�9�˫\�>\�0\0Ц\�08L2�3\�q\�\�\\�~=�3\r�Q���\�ɿ_իW?\�\n\�:�9\�\�b��\�Z�f\0�M�a 	�\�j=r\�\�\�\�t\�������A\'�����{�ϵV��\Z\0h\�p\��Wh��Y8�\�����v_{�\0�N�a��_Y��\�\�~��]ϵ�@͚5�\�\�\0\0\�t\0��_�\�t��\�\�\�)\0\�t\0��\Z+~o�פ��6\�(q/�\0P�\�0���:ѽ\�r5\�a\0\0\�t\0���ڵk��f͚?pת3\�\0u:\0\��\�v�\ZY[bE�O��Dj�\�\0�:\0�\��@ì�T�\�~\�9�3\0\0u:\0\���,���\�/\'��T���2\0@��\�\0���\�nx��\�V��\�\�\�\�T\�\�\0\0u:\0\��\n�\�\"��`E���\�W�~�]�R4\0\0\�t\0��\�E$�]B\�\��\�S.�\�D0\0P�\�0����Ü:\�D0\0\0u:\0\����F�8\�c�\0@��\�\0��ҁ\0\�t\0���`\0\0\�t\0���\�\�s�\0�\�p\��g�~\�\��n�:k7Zkh��[���\�s�~\�\�\�1\�\�Y\�\�;\�\���}��\�\"`?�V\�\�I\��o�5��\�\�\�m��\Z/�g\�;n�V\�\�c\�^����Gb\�\�\�ֺƱ��)�k`g�r\�r���\�c\n\�\�\08p��|E�\�\�\�8�(њc����ܺ\�D��\�\��O��m\�k՜�hm���n]v����6�\�\�\�\\\�9�;%F`\��W<�(+?\�ړ\�\��gw>\'\'���v��s�s\�S����\����+W͉\�D�\�-\�c\n\�\�\08p��|E�8։Q�OE�?vbR\�Ϲ2��N�����n��P4�\�\�Z7k]B\��\�\��(=\�ڈP4R+�[���~\�~\��)*�\�\�\'�}&�L��m��VϺsh��qDp�\�2�\��\�p\��C��\��\�^�\�҉\�Vδo|`��!|\\\��ʧ�uE=���=�]\�D�\"�J��\��7Pn�[�\nESF[kgM3\�)\Z;6�En\�P4�a��aNp\��+ݾDvg��~\\\Z\�\�,���k\�#g�Cє	D0P�\�0����\�S� �UT��\��cݿ:�y�\�^h\�%\'�%n\�\n|����c\�k\�8Q��P4Bi��rG:\�re�\����\�\��\�\�\�\�u\����\�����颠h�\�Fı�����\"X)o�{��`�N�a��)�>\��\'\\[9{\�mQ�o��&\�v��y�\�B��v%��Z�:\�\�!\�\�Uz\���e���\�B\�s\�؜\�\�\�o\��\�P4�*�Vnn-��\�\�\�1��[`�\�������`\0\�t\0��Wk���qD��W(:��?:�l��q	\��Cё���\��\�P4�:\�\�wc��L\'D{�m�ڛC\�N{�\"�C��\��\�\�N�6w���\�\�\��UbjIE�\���\�\�\08p�!}D�������\�pb�\�cD�:�=:��\�?�,(\�5({�}�ӭ�v��\"\�A�QDY�\Z-\�oN8Ew�\�|g�ȍǤ��\�D\'��S\���\�?\�xi�`���\�hD0P�\�0���Ԋ`Ed5ʃR}\�	OY������>;?�~��7ǈ\�B\�t\0�=�\�ݻN��\�|��#k�\�K8�u\�V�̬P4\�\�f�r\�\�6ȭK7E�\"�-\'F��F��ΉZ�U\�0kd�kB�r�a\�[g_5W^��\�\�\\w�(�\�\�	\�\�\08p�!5\"��Сh\�=\�\�%�h*B[����?J�h\n\�Ę\�:& }��i��*\�yK@0+?8\�m�\�D�FzP>�\�С	<Nq\"�~�=9\�T�\�&�r�:A\�`�Ntؐ�V�Z#7h�6E�\��OW;�>\��`PG\�p\�\'	��\�\�\�\�<\�\��\�t\0���\Z\�Xg\�\'j\�\�f\����q\�Hg���\�|,U\n9�#\n8v|\���b�_ǔ\�=�N\�\�\0u:\0\�H�\�h�$8�Ngg�ۿbR�\�Z��\�=\�|V�\�#\�z�P4� h�c\�\'�o\rES($:�\rES2��n@ \�\�QV~�\�(f����\�\�\�2��\�P�飓e�\�=��\0�N�a��e,�%H���Pt<\� c��rs?v��\�PtH3���\�4ZC�\�:��\�\�ֱvq(:\�\�c�����k@���F{P�\�N,�8;\�)k��\�\��u�\�>7\�طe1\�\�Ρ$\�G\'\�w\����n9\�]\�\��u:\0\�H��p��Fv}\�q+6\r\�P4�W\�.rB�-k�E�%$\�\�\Z��,N\n\�\���������\�E�v%ʕ\�\�\'PV\�e��\\\�81\�=�\�\��绲�6��\�Ձ����\�\�P�h\�G\'é\�z\�\�\�SxL�:\0�\�?�F�_�\�\�\�=\�	\�P@\��\�	_	㻭�\�\�}�hz�}ϕF�M\�q\"[\�\�愮�+�A�\�Z��\�����FsP�}�OQ\�?��\�ws\�~\�D�F�PdY#2�w\�\��ف�!8�Yv@\';}t2<\�D�o�z��>�\�АG�\�p\��CjEpȉӟ��\�`\�V��5F�\"�\�cU\�\��\�\n\Z�\�m�\��\�Ŕ��\�\Z�Ҡ4Er5#��I\�(\nw��Q\�_8�vǖ��C�I\\k����4�aǔZ�\�\�\��s	D�\\w��m����\��\�\�0݉uY_w]_s\�%\'��\�p\��C�E�O;k\�\�?*�\�ЉfE��c�^\��6\'��\�Pi�B\�T\0�\�(��hτ��\��\�\�PmO��å\�(+A]ǉ\�;A{�;�ccε��`�d��.*�	1�:\���|\�(\�#\n\�\�\08p�!u\"�\�С1�	^\�U��J��Fg}���5������ʓ\�>\�@7ŭ�\�;\������t硨�\�1\�P4\�ArS(���Hr�PtB�\�\�-e5\"X◜m�\\�.\��\�EA��|0�@(�Di!��xu:\0\�H�V*�:~�#�&�\�عʃ\�pam\�\�g����\�>uP\�\���7\�	V\�W3\�)��ح\�:Ѭ�_��)\Z6���WD�q\�\"\�~\��t\'�\�v\�4{\�yn\�\�\�\���9[X׬nYqDpQ��\�\��Q�@\�B\�n\�/\�\�\�7��\�B��P�\�0���r�z\�v\"S9����*H�\��g�X\��ň<E�#�C\�ޞ��\�C\�|\�ɡCS\�{Ou\"Z\�\�q\�o\�\���OBY�\�\rES	\�9\�.��1�5��:�����uNǊ:}�\�HS�p\�r\�6ΉjE�5��P4�C�Ώ\�\\K\0\�t\0��P\"\�G\�\rÜp\"���\�_��)\n\�P�վʏp�4��N\�\�<\'X�HǦX(\��`\�И���3h\'���\�(�TMA|�\�V\�5�0�]\\\�\�\��\r���P�\�0�s?\"\�q?�;1}�)P�\�0���Ԉ`���>*\���c�<\�\��{�>Z�\�Ӌy\�G\���@��\�\0�R(��|4f��\n���\�c\�\���R&Ns\�\�\�>Xׄ\�\'�|�\�\�	/�?�\��ĵH�i��\�p\��C�E�:��r�\�\�>lg;��\��\��	*�/� �\��kkB\�W�zͿ\�	U_H�̹�\�\�\0�ow;Aݯ�sJ���t�OB\�\�+\�\��n�1_\\\�o�r\�d\0\�t\0�a����\"8H0��\�\���v�N�*\�@Í�\�\�>�u�rl5^�\�Nl^\Z��\�\�M�\�M��KS�1�/\nۉ\�{5�E���-sbY�z\�d\0\�t\0�a����\"X�\�\�L#Ch�6MM�\�\�T��F@�3�:ȭs\"���f�\�a�\\9E}5I\�9n\��S�)�;,\��H�v	E#���؎GU\'���\�ܶ\"�ʥô\�\0\�\�\0�\�\0�?\�DpEs5)��f\r\�%\�\�.7މ`ExG��\�sy(:np(�\�4_Ď�����p�\�p�ηA(:��/��\"�	;\����6�:\0p\����V\��#Nj&���h�\�Δ\�{D��4�\�n\n\Z�A\�ݡ�\�\'}��Uz\�tkC�n��ގnݏت\�݃q\�[S2?���\���S.�M�N\0��i&��s\�Q\�(\�q�CT��7�}\�\"��̱��:�	Vg�A�h�X�\�#��\�\��P�T�����	qDp��M�N\0��\�\�u�߅\��TJD��&�\�\�\�ؖ8\"��Pt��eN(Vu�rQ\�\�\�Bi]\�zA�`}\�ۡh\�7?wxG`])\�A�Õ\�\�Ļ\� \'̃ϧ��M\0\�t\0\n�\�م�\�p8ܚ+�r�\�e�\�،�\�t�\�B\�Ȭ\"��C\�\�\'^E�,�҉Hb	uZ;߭\�F��\�0ƭk\�\�\�	$b�H�\�ʜ\�\Z����n�r�\�\�K�A��6\0h\�p(\��\�X�\�^�z��\\���`Ek�\�\�\�P\�͔\�p��>�\� ��>��A,��Q(ZC�*\�[ݝ�:\�\�\�)�!\�\�z\�d\0�M�a�H�;a48��\�\n�\\:<�6\�\�l\"Nq\�\�i�\�M�|l`]y�Gr>�\��*h\n\�D½��M�\��9)n\0�`(��sQ\��\0\0E�\�Iq@CI+N*JD0\0dd}N�\0\"��\�k�#� \�\�rR\�\0��\�p�n��\�\� � c\�qR\�\0�P����\0]��\���d+\�\Z5jp��\0���9)n\0�`H�\\\'\�H�@@C�@�D�1\�dk\�\�\�3A٣\�?\�ڏ��*q\�_\�\�+M��6\�-yu��\�n\�Iq(+<�\��\�Еd-__�*��yk��\��\�Ͻ�~��_�.1�u\�^ӿ�\��к\�W�\��\�\�4uΆ\�W笳\�\�~���˻L�x�㰯g-7���܍/�\�5Iְ\��}��\�+w�X\���\Z@#� �	�\�Y{ɶ\�\�\"�\��\�3*\�\r�f\�,�\�Y���Pl�\��=&�Ѿ�\�?u\��W���L�Ux\�3�\�\�}?\�bz\rX`މ�\�\�c����2Y\�W>\�ڨ\�\�������m-�\�\�3�\�Ը\�\�Z\�7�Cl\Z���\�D0\0��j\�j����m�֛(1@�D�R\�K\�ʢ\�5��\��\��\�\�\�~�~���o.2CV�\�c��\���N�e[\�vk\'\���\�M�k����{��+���\�u\�\�J�Jk�Ԙ�\�\�\"�[�\����O���i�5�Îb�\�X۫\�0W �\\:D�\�\��J]h7d��Ah]\�\�\�\��TF�TQ\�&/O\��D\�Y��(�\�=>\�ռόM\r�O\���\�\�-_+MBQdE�s_��V\�\�\�\�i\�tn5��\�Gl�T\�톮Xk\�ϝ,�\0.L\�F@��\�Sb�l\�ڵM��\�\�\���͂\�ڵk\�\�ݻ�طo�ٰa��\�/̐!C�r\�\�\��\��F�=Wr���n�\�\��\��\��Z9�Z���E��}��r�%~�\�G��|q\�\�Uƴ��o\�7ۼo�(�k_��>\'�uE�%�}{\�_-\�.J�Pr\�d\�\"\0J�H$r�\��\��999f���\�M��;w�w\�y\�4h\� v,\��o4\�j\"��\"X\�66\'X\�ހ�Vi\r��~g\\l��ļ�4�x\"��3t�1/(�BW\�ڗH?\�{\�f��i��E����9�0\"\0\�Y\0۶ykP��h\��������?�Ћ$���Ý�\�.�7\�E\�<#{\����;}�y���c�\�Q\Z�\�3|�\"�_EwU\��\"X�{q\�)A,A��r�6n6��o\�\�.��\0.�\�\"\0���\"�J{��--V�^m\Z7n\�s\0Ɉ`�Ɛ�c�RTF�7(\rB\"\��Z�YEk\�a.VK0�\�\r�f\�\�i\�e܁\�4Q^�\";)2\�]�Ka�\�\��{\0\0��\��r��N�j\�\�+_8\�\�ʺ�;\0�\�8l3�Q���.�M��\�>����uO��\'\�r\�\�k�\�\�l>D�\�4�Z��\ru�s;���t��8w1�p-�T\"¥+�K\�\0�\�\�ٱ\�D�\�ڵk�o|a�A̝\0Dp��zS\��W\�\"\�\�$6�Wc3�r\�d��9`\0(C�\0\�\�.\��Dl۶\�ԫW/�1�;�`\�d\�: d?w�\��$�p�\�!�\0\�\07F\�(%\��3g\�̗�s��L��W(��(B8(�}NtB�0\0@\�\�\�|!�a\�ʛN�:��4\� �!SH$L\�	ڂ�pQ˓#\0PJ(78F�\�\0���\���|\���ÝD0d�\0\�-��MV0�\Z\0Px�)�\�/D�\�P�ؐ*��i\�sn\�\�D0�3E��	\�dp�\�\0H\�\�:\�d\�n\�e��׈��\�o\�A��Q��4�\�=��؇a\0�\�E�oc#\��\�1/^�2�1������`�� !����\�\0P\�Dp�\��Ű]\�\�\�/\�Q!bY�bE�1��{P�T�tå�K\�\�\�:\�\�l��=\�v[\�8��\�gw\�\�k\�\�\�5�7v�~\�nv\���]n��\�\�W�\�5\�V\��+\��+k_\��\�\��R��\�\�\�\�\�}�}f\�\�\�c�\�r�ݞnm��i\�k���6\�\�i�#l\�av�~�Z�޵6\�n\�\�\�z\�\�{\�Zk�\��>v/���\�\�j\�_����\��e\�iM-i�����kH�\�qk\r쾇\��vY\�n\�\�=ϲ\�kڲ5챿j6�}�]�\�ڵu\�Թ�v\�\�W\�r�\��\�\�㎟\�\�\�\\�	w\�}��4|͚5O��\�O�^�z\�V�Z)j[\�\�k<!\\+�\�\0(��͋�5�[�\�\��s\�\�A�@\�J\"\�\n�\�%����O�Q�ƙcV�] q&�fE\�emv�*�#(1g�7J\�I\�Y�]�/��Ġr��8|\�ڿ$\Z%�5���\�\�~��D�-��D�ħ\�\�Eb\�\�\�i\�{K�Z{]�U\�\�\�$1k�߱\�ߓȵ��;\�;\�\�X\'�%�\';�<͖�!�l�\�HLKT\��%�\��/\�r�ķ].��(�۫�H_놱\�`��\�\�$Q\�^e}#�o�os\�_�\��(\�\�~$\�u�\�ڲߺ�n����\�H�J\�޲�\�jIL\�F����%aV*|\�0,��\ZD0\0�3%��H0\0@\�#�;�fQ(\"�\0\0\�Nr�\02K\�\�@r�\0�!<�\Zyet\0�ԉ`��i�>�\0P|!\\�\0-�q��C�\0P�>,��\�\�t\'X; �\�r�\0 \�),[\�3\�1�\0@	p#�|Ƹƍ\'\�\�ĝ�L QD8Ya[\��`\0�R\�\r�\�O�n�mۖ\�|`\'�/\�\�\0@���pljB�P�)�pϘ�C0�\Z��=+f�g֪P�LY��2k4\���R\�\"�G�A��;\0�(���傂6�\�n�>\�0hP\��g��\�k7h�\�v�U�2�Z�޷>�\��\�>k\'�\\�~�7\�\�\�֮�v\�\��k�w\�\�Ӻ�ӭ\��\��\�g7\�=ss\�\�ӷl6��>\�f\�\�\�d-\�X��;\�M0%�~��\�:T\�\�ի�t \Z\�\0@&�\Z!\�3���g��+\��\�\0�\�m��\�m\\\�ډ��\�Y\'{�\��\��\�ؤ�	L{\�/?\�4ݷ\'�\�\�(\�enp���7�!o/1o�y{\�\�\'z\�\�\��3Ve�tBX�\���\�\�gV�\�\�����;\�/x�/D\�y\�r�mڴ	F�\�p7\0�\"	\�/\��D(r\�\�\�\�_*:ۢ���hpl$ؕ�\�g�.{j���2\�{ĕ�q�1M\��q�\�\�\�\�~q\�)یi\�\�9`��o�wk�Ę֊\nw��,Y\�Swpw ���\�~�\�e.�?��\�|�����;\0\�\�\0��yNQ\�ǻ��ֶ\�u%h�ݰ\��}\��\��Z\��*\�m��\�}m�\�\�h]��\�M\�F\�\�\�\�\�歕��\�m�ʔ\�O�g�b�\�6��}Ѵ��ol��]1p�,�ǘ\���V-`rw UX!�\��\r64;w\�,3<iҤ|i\�\�\�\0@E��)�@@��T�g?X?ǭW�vF�N�\�I���mޗ��#�Z\���E���\�|!�Ԙ���*Gx\�v�\�~�;�J4�\�{�\�絹\�ݧ\�X�U\�n�)EB\�\\���\��;\�Ԋ\��0m׮�7�qY\���:\�@�\�\�Fr\�e-�/T\�A\�[?m3h\�R\��6}\�ӭ��\�{L\�({\�\�=�G��6\�h\�cҮF/Oڥu\�\�j\�]��\�;�\�eV b|�\"ā2�zL6��f�m\�ԧ\��|�\"\�Z\�\�@*	�\�u���rv7m\�T�)1\���H\��<\0TD�Mi \�CW�d\��ږ��\���\�AM�\�\�\rY�\�\�-��\��\�ϵ�\�	�\�=\�|�Θ\�I\�Km1��\"\�.�V��\�\��$|}a�٘fJ�P$�\���_��b!wR��X\�\�*j�i�K:\n\�SO=�/\0\�Cd��\�G_ ��\�Е$H\�I�\�d3RbW�\�j~�\�>�z�\�\�T\�\�\��	\�\�ﯟc\�\�SY\ry�\�f}g~-q#�����O|\�`\�	VZwRM�Z��X�z0(Z5�\�\�ŋ��C\�\0\�D�0\0T\n\���G�@\0Cy�\�{���B\�ӌ\��� k\�s�7J\�*cZ��>\��\��m\�X��{.u�\�\��.{w�\�t	�k\r�6ߘ�\�\�\�g�\�\��<@�\�\�ʺŊ\��1\�\�<�\�#f\���f\�ĉ\�(~ް���\Z<\�4m\�4V�\�	\0*-�\"¤@\0\0�!�\�Z\�:%6*\\L[\�0h\0�>$x�\0\0iN\�ڵ��\"vb�\�\\���\�\0\0�\�Y`\0�\�!\'\'\�D�/<M\�b\�%\"���X\�dm�\�/Y���\0�\�\0�à\0\0\0@%\�.\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��eekU��\�\0\0\0\0IEND�B`�',1);
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
INSERT INTO `ACT_HI_ACTINST` VALUES ('10002','leave:1:4','2501','2504','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-09 01:32:41.407','2018-04-09 01:32:41.669',262,NULL,''),('10003','leave:1:4','2501','2504','hrAudit','10004',NULL,'请假单-人事审批','userTask',NULL,'2018-04-09 01:32:41.673','2018-04-13 15:04:38.808',394317135,NULL,''),('12502','leave:1:4','2501','2504','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:04:38.812','2018-04-13 15:04:38.844',32,NULL,''),('12503','leave:1:4','2501','2504','modifyApply','12504',NULL,'请假单-调整申请','userTask','1','2018-04-13 15:04:38.846',NULL,NULL,NULL,''),('15005','leave:1:4','15001','15004','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 15:08:08.754','2018-04-13 15:08:08.755',1,NULL,''),('15006','leave:1:4','15001','15004','deptLeaderAudit','15007',NULL,'请假单-部门领导审批','userTask',NULL,'2018-04-13 15:08:08.757','2018-04-13 15:08:34.845',26088,NULL,''),('15010','leave:1:4','15001','15004','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:08:34.846','2018-04-13 15:08:34.868',22,NULL,''),('15011','leave:1:4','15001','15004','hrAudit','15012',NULL,'请假单-人事审批','userTask',NULL,'2018-04-13 15:08:34.870','2018-04-13 15:40:21.648',1906778,NULL,''),('17502','leave:1:4','15001','15004','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 15:40:21.652','2018-04-13 15:40:21.689',37,NULL,''),('17503','leave:1:4','15001','15004','reportBack','17504',NULL,'请假单-销假','userTask','1','2018-04-13 15:40:21.691','2018-04-13 15:59:39.067',1157376,NULL,''),('20003','leave:1:4','15001','15004','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 15:59:39.106','2018-04-13 15:59:39.106',0,NULL,''),('20008','leave:1:4','20004','20007','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 16:18:12.150','2018-04-13 16:18:12.150',0,NULL,''),('20009','leave:1:4','20004','20007','deptLeaderAudit','20010',NULL,'请假单-部门领导审批','userTask',NULL,'2018-04-13 16:18:12.150','2018-04-13 16:18:33.114',20964,NULL,''),('20013','leave:1:4','20004','20007','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:18:33.114','2018-04-13 16:18:33.135',21,NULL,''),('20014','leave:1:4','20004','20007','hrAudit','20015',NULL,'请假单-人事审批','userTask',NULL,'2018-04-13 16:18:33.138','2018-04-13 16:22:43.390',250252,NULL,''),('20018','leave:1:4','20004','20007','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:22:43.390','2018-04-13 16:22:43.391',1,NULL,''),('20019','leave:1:4','20004','20007','reportBack','20020',NULL,'请假单-销假','userTask','1','2018-04-13 16:22:43.393','2018-04-13 16:22:52.517',9124,NULL,''),('20023','leave:1:4','20004','20007','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 16:22:52.522','2018-04-13 16:22:52.522',0,NULL,''),('20028','leave:1:4','20024','20027','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-13 16:29:00.691','2018-04-13 16:29:00.691',0,NULL,''),('20029','leave:1:4','20024','20027','deptLeaderAudit','20030',NULL,'请假单-部门领导审批','userTask',NULL,'2018-04-13 16:29:00.691','2018-04-13 16:29:19.657',18966,NULL,''),('20033','leave:1:4','20024','20027','exclusivegateway5',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:29:19.658','2018-04-13 16:29:19.658',0,NULL,''),('20034','leave:1:4','20024','20027','hrAudit','20035',NULL,'请假单-人事审批','userTask',NULL,'2018-04-13 16:29:19.660','2018-04-13 16:29:33.284',13624,NULL,''),('20038','leave:1:4','20024','20027','exclusivegateway6',NULL,NULL,'Exclusive Gateway','exclusiveGateway',NULL,'2018-04-13 16:29:33.284','2018-04-13 16:29:33.284',0,NULL,''),('20039','leave:1:4','20024','20027','reportBack','20040',NULL,'请假单-销假','userTask','1','2018-04-13 16:29:33.286','2018-04-13 16:30:55.293',82007,NULL,''),('20043','leave:1:4','20024','20027','endevent1',NULL,NULL,'End','endEvent',NULL,'2018-04-13 16:30:55.294','2018-04-13 16:30:55.294',0,NULL,''),('2505','leave:1:4','2501','2504','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-07 00:04:58.494','2018-04-07 00:04:58.497',3,NULL,''),('2506','leave:1:4','2501','2504','deptLeaderAudit','2507',NULL,'请假单-部门领导审批','userTask',NULL,'2018-04-07 00:04:58.500','2018-04-09 01:32:41.376',178062876,NULL,''),('7505','leave:1:4','7501','7504','startevent1',NULL,NULL,'Start','startEvent',NULL,'2018-04-08 11:42:04.744','2018-04-08 11:42:04.748',4,NULL,''),('7506','leave:1:4','7501','7504','deptLeaderAudit','7507',NULL,'请假单-部门领导审批','userTask',NULL,'2018-04-08 11:42:04.751',NULL,NULL,NULL,'');
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
INSERT INTO `ACT_HI_TASKINST` VALUES ('10004','leave:1:4','hrAudit','2501','2504','请假单-人事审批',NULL,NULL,NULL,NULL,'2018-04-09 01:32:41.675',NULL,'2018-04-13 15:04:38.783',394317108,NULL,50,NULL,NULL,NULL,''),('12504','leave:1:4','modifyApply','2501','2504','请假单-调整申请',NULL,NULL,NULL,'1','2018-04-13 15:04:38.846',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('15007','leave:1:4','deptLeaderAudit','15001','15004','请假单-部门领导审批',NULL,NULL,NULL,NULL,'2018-04-13 15:08:08.781',NULL,'2018-04-13 15:08:34.835',26054,NULL,50,NULL,NULL,NULL,''),('15012','leave:1:4','hrAudit','15001','15004','请假单-人事审批',NULL,NULL,NULL,NULL,'2018-04-13 15:08:34.870',NULL,'2018-04-13 15:40:21.625',1906755,NULL,50,NULL,NULL,NULL,''),('17504','leave:1:4','reportBack','15001','15004','请假单-销假',NULL,NULL,NULL,'1','2018-04-13 15:40:21.691',NULL,'2018-04-13 15:59:39.055',1157364,NULL,50,NULL,NULL,NULL,''),('20010','leave:1:4','deptLeaderAudit','20004','20007','请假单-部门领导审批',NULL,NULL,NULL,NULL,'2018-04-13 16:18:12.151',NULL,'2018-04-13 16:18:33.109',20958,NULL,50,NULL,NULL,NULL,''),('20015','leave:1:4','hrAudit','20004','20007','请假单-人事审批',NULL,NULL,NULL,NULL,'2018-04-13 16:18:33.138',NULL,'2018-04-13 16:22:43.380',250242,NULL,50,NULL,NULL,NULL,''),('20020','leave:1:4','reportBack','20004','20007','请假单-销假',NULL,NULL,NULL,'1','2018-04-13 16:22:43.393',NULL,'2018-04-13 16:22:52.509',9116,NULL,50,NULL,NULL,NULL,''),('20030','leave:1:4','deptLeaderAudit','20024','20027','请假单-部门领导审批',NULL,NULL,NULL,NULL,'2018-04-13 16:29:00.691',NULL,'2018-04-13 16:29:19.650',18959,NULL,50,NULL,NULL,NULL,''),('20035','leave:1:4','hrAudit','20024','20027','请假单-人事审批',NULL,NULL,NULL,NULL,'2018-04-13 16:29:19.660',NULL,'2018-04-13 16:29:33.279',13619,NULL,50,NULL,NULL,NULL,''),('20040','leave:1:4','reportBack','20024','20027','请假单-销假',NULL,NULL,NULL,'1','2018-04-13 16:29:33.286',NULL,'2018-04-13 16:30:55.287',82001,NULL,50,NULL,NULL,NULL,''),('2507','leave:1:4','deptLeaderAudit','2501','2504','请假单-部门领导审批',NULL,NULL,NULL,NULL,'2018-04-07 00:04:58.528',NULL,'2018-04-09 01:32:41.205',178062677,NULL,50,NULL,NULL,NULL,''),('7507','leave:1:4','deptLeaderAudit','7501','7504','请假单-部门领导审批',NULL,NULL,NULL,NULL,'2018-04-08 11:42:04.784',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,'');
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
INSERT INTO `ACT_ID_GROUP` VALUES ('deptLeader',1,'部门领导','assignment'),('hr',1,'人事部门','assignment');
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
INSERT INTO `ACT_RE_PROCDEF` VALUES ('leave:1:4',1,'http://www.kafeitu.me/activiti/leave','请假流程-动态表单','leave',1,'1','flow/leave.bpmn','flow/leave.png','请假流程演示-动态表单',0,1,1,'',NULL);
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
INSERT INTO `ACT_RU_TASK` VALUES ('12504',1,'2504','2501','leave:1:4','请假单-调整申请',NULL,NULL,'modifyApply',NULL,'1',NULL,50,'2018-04-13 07:04:38.846',NULL,NULL,1,'',NULL,NULL),('7507',1,'7504','7501','leave:1:4','请假单-部门领导审批',NULL,NULL,'deptLeaderAudit',NULL,NULL,NULL,50,'2018-04-08 03:42:04.751',NULL,NULL,1,'',NULL,NULL);
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
INSERT INTO `t_leave` VALUES (1,'2501',1,'2018-04-06','2018-04-13',NULL,'test','2018-04-06 23:22:44',NULL,NULL),(2,'7501',1,'2018-04-08','2018-04-24',NULL,'家里有事','2018-04-08 10:57:50',NULL,NULL),(3,'15001',1,'2018-04-13','2018-04-26',NULL,'家里有事','2018-04-13 15:08:06',NULL,NULL),(4,'20004',1,'2018-04-13','2018-04-26',NULL,'fdads','2018-04-13 16:09:43',NULL,NULL),(5,'20024',1,'2018-04-14','2018-04-25',NULL,'家里有事','2018-04-13 16:28:58',NULL,NULL);
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
  `is_delete` bigint(2) DEFAULT 0 NOT NULL,
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
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('1', 'OA办公', '/oa', NULL, '1');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('2', '系统设置', '/sys', NULL, '1');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('3', '在线开发', '/generate', NULL, '1');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('4', '测试', '/test', NULL, '1');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('6', '请假管理', '', '1', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('7', '工作流管理', '', '1', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('8', '用户管理', '', '1', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('9', '代码生成', '', '1', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('10', '超级管理员', '', '1', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('11', '待办任务', '/leave/task', '6', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('12', '请假单', '/leave/list', '6', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('13', '流程列表', '/workflow/processList', '7', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('14', '用户管理', '/user/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('15', '角色管理', '/role/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('16', '用户组管理', '/group/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('17', '用户-组 关联', '/user_group_relation/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('18', '角色-组 关联', '/role_group_relation/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('19', '角色-用户 关联', '/user_role_relation/list', '8', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('20', '数据表管理', '/generate/tableList', '9', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('21', '请假管理2', '', '2', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('22', '工作流管理2', '', '2', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('23', '用户管理2', '', '2', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('24', '代码生成2', '', '2', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('25', '超级管理员2', '', '2', '2');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('26', '待办任务2', '/leave/task', '21', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('27', '请假单2', '/leave/list', '21', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('28', '流程列表2', '/workflow/processList', '22', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('29', '用户管理2', '/user/list', '23', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('30', '角色管理2', '/role/list', '23', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('31', '用户组管理2', '/group/list', '3', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('32', '用户-组 关联2', '/user_group_relation/list', '23', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('33', '角色-组 关联2', '/role_group_relation/list', '23', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('34', '角色-用户 关联2', '/user_role_relation/list', '23', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('35', '数据表管理2', '/generate/tableList', '24', '3');
INSERT INTO `jfinal_activiti`.`t_rbac_menu` (`id`, `name`, `url`, `parent_id`, `seq`) VALUES ('36', '菜单', '/menu/list', '8', '3');

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
  `is_delete` bigint(2) NOT NULL DEFAULT '0',
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
   `is_delete` bigint(2) NOT NULL DEFAULT '0',
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

-- ----------------------------
-- Table structure for t_rbac_ref_perm_role
-- ----------------------------
DROP TABLE IF EXISTS `t_rbac_ref_perm_role`;
CREATE TABLE `t_rbac_ref_perm_role` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `t_rbac_ref_perm_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_rbac_role` (`id`),
  CONSTRAINT `t_rbac_ref_perm_role_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `t_rbac_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_rbac_ref_perm_role
-- ----------------------------

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
  `is_delete` bigint(2) NOT NULL DEFAULT '0',
  `remark` varchar(45) DEFAULT NULL,
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
 `is_delete` bigint(2) DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rbac_user`
--

LOCK TABLES `t_rbac_user` WRITE;
/*!40000 ALTER TABLE `t_rbac_user` DISABLE KEYS */;
INSERT INTO `jfinal_activiti`.`t_rbac_user` (`id`, `name`, `password`, `cn_name`, `mobile`, `is_delete`) VALUES ('1', 'ray', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, NULL, '0');
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
