
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<h2>Exam List</h2>
<hr>

<a href="${pageContext.request.contextPath}/admin/exams/add" class="btn btn-primary mb-3">Add Exam</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>ID</th>
            <th>Exam Name</th>
            <th>Total Marks</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${exams}" var="e">
            <tr>
                <td>${e.examId}</td>
                <td>${e.examName}</td>
                <td>${e.totalMarks}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/exams/edit/${e.examId}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/exams/delete/${e.examId}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
