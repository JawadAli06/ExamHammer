<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">

        <!-- Welcome text instead of Admin Panel -->
        <span class="navbar-brand">
            Welcome ${sessionScope.user.firstName}
        </span>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            Logout
        </a>

    </div>
</nav>

<div class="container mt-4">
    <h2>Admin Dashboard</h2>
    <hr>

    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary m-2">Manage Users</a>
    <a href="${pageContext.request.contextPath}/admin/exams" class="btn btn-success m-2">Manage Exams</a>
    <a href="${pageContext.request.contextPath}/admin/subjects" class="btn btn-warning m-2">Manage Subjects</a>
    <a href="${pageContext.request.contextPath}/admin/subjects/add" class="btn btn-info m-2">Add Subject</a>
</div>

</body>
</html>