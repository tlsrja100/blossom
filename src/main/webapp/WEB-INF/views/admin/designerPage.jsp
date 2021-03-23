<%@page import="com.blossom.controller.DesignerUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blossom.dto.DesignerDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../include/adminheader.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="text-align: -webkit-center;">
	<div style="float:left;">
		<h2>Blossom Dog Designer</h2>
	</div><br /><br />
	<div style="width: 1200px;">
		<div>
			<%@include file="designerModal.jsp"%>
			<button type="button" data-toggle="modal" data-target="#designerModal" style="float: right;">직원추가</button>
		</div>
	</div><br /><br />
	<div style="display:block; ">
		<ul style="list-style:none; display:block; float:left;">
			<c:forEach items="${list }" var="dto">
			<li style="display:list-item; text-align:-webkit-match-parent; padding:18px; width:900px;">
				<div style="display:block; float:right; ">
					<img src="/designerDisplay?fileName=${dto.uploadPath}/${dto.uuid }_${dto.fileName}" style="width:200px; height:200px; " /> 
				</div>
				<div style="overflow:hidden; display:block; height:200px;">
					<div style="display:block; float:left;"><!-- style="float:left; " -->
						<div style="font-size:2.0rem; text-align:left;">
							${dto.designer_name}
						</div>
						<div style="display:block; white-space:pre; text-align:left; padding-top:15px;">${dto.designer_memo }</div>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
</body>
</html>
