<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signup</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .signup-card {
            border-radius: 15px;
            padding: 30px;
            background: #ffffff;
            width: 100%;
            max-width: 450px;
        }
    </style>
</head>
<body>

<div class="signup-card shadow">
    <h3 class="text-center mb-4">Create Account</h3>

    <form action="${pageContext.request.contextPath}/register" method="post">

        <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" name="firstName" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Last Name</label>
            <input type="text" name="lastName" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Gender</label>
            <select name="gender" class="form-select" required>
                <option value="">Select</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Number</label>
            <input type="text" name="contactNum" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Birth Year</label>
            <input type="number" name="birthYear" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Profile Picture URL</label>
            <input type="text" name="profilePicURL" class="form-control">
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Sign Up</button>
        </div>

        <p class="text-center mt-3 mb-0">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </p>

    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

