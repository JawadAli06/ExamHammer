<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

.signup-card{
    border-radius:15px;
    padding:30px;
    background:#fff;
    width:100%;
    max-width:450px;
}

.profile-preview{
    width:90px;
    height:90px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #ddd;
}
</style>
</head>

<body>

<div class="signup-card shadow">

<h3 class="text-center mb-4">Create Account</h3>

<c:if test="${not empty error}">
<div class="alert alert-danger text-center">
${error}
</div>
</c:if>

<c:if test="${not empty success}">
<div class="alert alert-success text-center">
${success}
</div>
</c:if>

<form action="${pageContext.request.contextPath}/register"
      method="post"
      enctype="multipart/form-data">

<div class="mb-3">
<label class="form-label">First Name</label>
<input type="text" name="firstName" value="${param.firstName}" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Last Name</label>
<input type="text" name="lastName" value="${param.lastName}" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Email</label>
<input type="email" name="email" value="${param.email}" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Password</label>
<input type="password" name="password" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Gender</label>
<select name="gender" class="form-select" required>
<option value="">Select</option>
<option ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
<option ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
<option ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
</select>
</div>

<div class="mb-3">
<label class="form-label">Contact Number</label>
<input type="text" name="contactNum" value="${param.contactNum}" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Birth Year</label>
<input type="number" name="birthYear" value="${param.birthYear}" class="form-control" required>
</div>

<!-- PROFILE PIC UPLOAD -->

<div class="mb-3 text-center">

<img id="previewImg"
src="${pageContext.request.contextPath}/images/default-user.png"
class="profile-preview mb-2">

<br>

<a href="#" onclick="document.getElementById('profilePic').click();return false;">
Choose Profile Picture
</a>

<input type="file"
       id="profilePic"
       name="profilePic"
       accept="image/*"
       style="display:none"
       onchange="previewImage(event)">

</div>

<div class="d-grid">
<button type="submit" class="btn btn-primary">
Sign Up
</button>
</div>

<p class="text-center mt-3 mb-0">
Already have an account?
<a href="${pageContext.request.contextPath}/login">Login</a>
</p>

</form>
</div>

<script>

function previewImage(event){
    const reader = new FileReader();
    reader.onload = function(){
        document.getElementById('previewImg').src = reader.result;
    }
    reader.readAsDataURL(event.target.files[0]);
}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>