
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<h3>Subject List</h3>

<a href="/admin/addSubject" class="btn btn-success mb-3">Add Subject</a>

<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Subject Name</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${subjects}" var="s">
            <tr>
                <td>${s.subjectId}</td>
                <td>${s.subjectName}</td>
                <td>
                    <a href="/admin/deleteSubject/${s.subjectId}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
