<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

		<style>
				body {
				background: linear-gradient(135deg,#667eea,#764ba2);
				min-height:100vh;
				display:flex;
				align-items:center;
				justify-content:center;
				}
				
				.card-box{
				border-radius:15px;
				padding:30px;
				background:#ffffff;
				width:100%;
				max-width:400px;
		}
		</style>

</head>
				<body>
				
				<div class="card-box shadow">
				
				<h4 class="text-center mb-3">Forgot Password</h4>
				
				<p class="text-center text-muted" style="font-size:14px;">
				Enter your registered email. We will send you an OTP.
				</p>
				
				<form action="${pageContext.request.contextPath}/sendOtp" method="post">
				
				<div class="mb-3">
				<label class="form-label">Registered Email</label>
				<input type="email" name="email" class="form-control" required>
				</div>
				
				<div class="d-grid mb-3">
				<button type="submit" class="btn btn-primary">
				         Send OTP
				</button>
				</div>
				
				<c:if test="${not empty error}">
				<div class="alert alert-danger text-center p-2">
				         ${error}
				</div>
				</c:if>
				
				<c:if test="${not empty msg}">
				<div class="alert alert-success text-center p-2">
				${msg}
				</div>
				</c:if>
				
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