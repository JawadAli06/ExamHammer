<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Examiner Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-secondary">
    <div class="container-fluid">
        <span class="navbar-brand">Examiner Panel</span>
        <a href="/logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Welcome Examiner</h2>
    <hr>
    <a href="/examiner/createExam" class="btn btn-primary">Create Exam</a>
    <a href="/examiner/questions" class="btn btn-success">Manage Questions</a>
</div>

</body>
</html>
    