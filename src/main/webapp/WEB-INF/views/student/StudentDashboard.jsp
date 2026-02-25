<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand">Student Panel</span>
        <a href="/logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Welcome Student</h2>
    <hr>
    <a href="/student/exams" class="btn btn-success">Available Exams</a>
    <a href="/student/results" class="btn btn-info">My Results</a>
</div>

</body>
</html>
    