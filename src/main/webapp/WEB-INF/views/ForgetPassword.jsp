<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #667eea, #764ba2);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .card-box {
        border-radius: 15px;
        padding: 30px;
        background: #ffffff;
        width: 100%;
        max-width: 400px;
    }
</style>
</head>
<body>

<div class="card-box shadow">
    <h4 class="text-center mb-4">Reset Password</h4>

    <form action="${pageContext.request.contextPath}/resetPassword" method="post">

        <div class="mb-3">
            <label class="form-label">Registered Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="newPassword" class="form-control" required>
        </div>

        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-primary">
                Reset Password
            </button>
        </div>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/login">
                Back to Login
            </a>
        </div>

    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
