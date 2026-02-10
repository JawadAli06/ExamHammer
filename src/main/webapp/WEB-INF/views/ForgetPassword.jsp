<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .forgot-card {
            border-radius: 15px;
            padding: 30px;
            background: #ffffff;
            width: 100%;
            max-width: 420px;
        }
    </style>
</head>
<body>

<div class="forgot-card shadow">
    <h3 class="text-center mb-3">Forgot Password</h3>
    <p class="text-center text-muted mb-4">
        Enter your registered email to receive reset instructions.
    </p>

    <form action="${pageContext.request.contextPath}/forgetPassword" method="post">

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Registered Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <!-- Submit -->
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">
                Send Reset Link
            </button>
        </div>

        <p class="text-center mt-3 mb-0">
            <a href="${pageContext.request.contextPath}/login">Back to Login</a>
        </p>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
