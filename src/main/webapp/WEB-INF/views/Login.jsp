<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<title>Login</title>

			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

				<style>
				body{
				    background: linear-gradient(135deg,#667eea,#764ba2);
				    height:100vh;
				    display:flex;
				    align-items:center;
				    justify-content:center;
				}
				
				.login-card{
				    width:400px;
				    padding:35px;
				    border-radius:15px;
				    background:white;
				}
				</style>
				
				</head>
				
				<body>
				
				<div class="login-card shadow">
				
				<h3 class="text-center mb-4">Login</h3>
				
				<form action="${pageContext.request.contextPath}/authenticate" method="post">
				
				<div class="mb-3">
				<label>Email</label>
				<input type="email" name="email" class="form-control" required>
				</div>
				
				<div class="mb-3">
				<label>Password</label>
				<input type="password" name="password" class="form-control" required>
				</div>
				
				<button class="btn btn-primary w-100">Login</button>
				
				<c:if test="${not empty invalid}">
				<div class="text-danger text-center mt-3">
				${invalid}
				</div>
				</c:if>
				
				<div class="text-center mt-3">
				
				<p class="mb-1">
				Don’t have an account?
				<a href="${pageContext.request.contextPath}/signup">Sign Up</a>
				</p>
				
				<p>
				<a href="${pageContext.request.contextPath}/forgetPassword">
				Forgot Password?
				</a>
				</p>
				
				</div>
				
				</form>
				
				</div>

</body>
</html>