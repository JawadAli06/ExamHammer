<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExamHammer</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.sidebar {
    height: 100vh;
    background-color: #343a40;
    color: white;
}

.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 10px;
}

.sidebar a:hover {
    background-color: #495057;
}

.content {
    padding: 20px;
}
</style>

</head>
<body>

<div class="container-fluid">
<div class="row">

    <!-- Sidebar -->
    <div class="col-md-2 sidebar">

        <h4 class="p-3">Admin Panel</h4>

        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
        <a href="${pageContext.request.contextPath}/admin/subjects">Manage Subjects</a>
        <a href="${pageContext.request.contextPath}/admin/exams">Manage Exams</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
<c:if test="${not empty sessionScope.user}">
    Welcome, ${sessionScope.user.firstName}
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</c:if>
    </div>

    <!-- Main Content -->
    <div class="col-md-10 content">
