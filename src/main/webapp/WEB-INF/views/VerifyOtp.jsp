<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

			<style>
					body{
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
			
			<h4 class="text-center mb-4">OTP Verification</h4>
			
			<form action="${pageContext.request.contextPath}/verifyOtpAndReset" method="post">
			
			<div class="mb-3">
			<label class="form-label">Enter OTP</label>
			<input type="text" name="otp" class="form-control" required>
			</div>
			
			<div class="mb-3">
			<label class="form-label">New Password</label>
			<input type="password" name="newPassword" class="form-control" required>
			</div>
			
			<button class="btn btn-success w-100">Reset Password</button>
			
			<c:if test="${not empty error}">
			<div class="text-danger text-center mt-2">
			${error}
			</div>
			</c:if>
			
			</form>
			
			</div>

</body>
</html>