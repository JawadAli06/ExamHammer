
<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<h2>Exam List</h2>
<hr>

<a href="${pageContext.request.contextPath}/admin/exams/add" class="btn btn-primary mb-3">Add Exam</a>
<a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>ID</th>
            <th>Exam Name</th>
            <th>Total Marks</th>
            <th>Action</th>
            <th>Status</th>


        </tr>
    </thead>
    <tbody>
        <c:forEach items="${exams}" var="e">
            <tr>
                <td>${e.examId}</td>
                <td>${e.examName}</td>
                <td>${e.totalMarks}</td>
                <td>${e.status}</td>
                <td>
                   <a href="${pageContext.request.contextPath}/admin/exams/view/${e.examId}" 
                    class="btn btn-info btn-sm">View</a>
                    <a href="${pageContext.request.contextPath}/admin/exams/edit/${e.examId}" class="btn btn-warning btn-sm">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/exams/delete/${e.examId}" class="btn btn-danger btn-sm"onclick="return confirm('Are you sure you want to mark this exam as INACTIVE?')">Inactivate</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>
