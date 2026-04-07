<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up — ExamHammer</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    background: linear-gradient(135deg, #667eea, #764ba2);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 30px 0;
}
.signup-card {
    border-radius: 15px;
    padding: 30px;
    background: #fff;
    width: 100%;
    max-width: 480px;
}

/* Profile pic upload area */
.pic-upload-area {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    padding: 16px;
    border: 2px dashed #ced4da;
    border-radius: 12px;
    cursor: pointer;
    transition: border-color .2s;
}
.pic-upload-area:hover {
    border-color: #667eea;
}
.profile-preview {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #667eea;
}
.pic-upload-label {
    font-size: 13px;
    color: #667eea;
    font-weight: 500;
    cursor: pointer;
    margin: 0;
}
.pic-upload-hint {
    font-size: 11px;
    color: #adb5bd;
    margin: 0;
}
</style>
</head>
<body>

<div class="signup-card shadow">
  <h3 class="text-center mb-4">Create Account</h3>

  <c:if test="${not empty error}">
    <div class="alert alert-danger text-center">${error}</div>
  </c:if>

  <%-- IMPORTANT: enctype="multipart/form-data" required for file upload --%>
  <form action="${pageContext.request.contextPath}/register"
        method="post"
        enctype="multipart/form-data">

    <div class="row">
      <div class="col-6 mb-3">
        <label class="form-label">First Name</label>
        <input type="text" name="firstName" class="form-control" required>
      </div>
      <div class="col-6 mb-3">
        <label class="form-label">Last Name</label>
        <input type="text" name="lastName" class="form-control" required>
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" name="email" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Password</label>
      <input type="password" name="password" class="form-control" required>
    </div>

    <div class="row">
      <div class="col-6 mb-3">
        <label class="form-label">Gender</label>
        <select name="gender" class="form-select" required>
          <option value="">Select</option>
          <option>Male</option>
          <option>Female</option>
          <option>Other</option>
        </select>
      </div>
      <div class="col-6 mb-3">
        <label class="form-label">Birth Year</label>
        <input type="number" name="birthYear" class="form-control"
               min="1900" max="2015" required>
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label">Contact Number</label>
      <input type="text" name="contactNum" class="form-control" required>
    </div>

    <%-- Profile Picture Upload --%>
    <div class="mb-3">
      <label class="form-label">Profile Picture</label>
      <div class="pic-upload-area" onclick="document.getElementById('profilePic').click()">

        <img id="previewImg"
             src="${pageContext.request.contextPath}/images/default-user.png"
             class="profile-preview"
             alt="Profile Preview">

        <label class="pic-upload-label">Click to choose photo</label>
        <p class="pic-upload-hint">JPG, PNG — max 5MB. Optional.</p>

        <%-- Hidden file input — name="profilePic" must match controller @RequestParam --%>
        <input type="file"
               id="profilePic"
               name="profilePic"
               accept="image/*"
               style="display:none"
               onchange="previewImage(event)">
      </div>
    </div>

    <div class="d-grid mb-3">
      <button type="submit" class="btn btn-primary btn-lg">Sign Up</button>
    </div>

    <p class="text-center mb-0">
      Already have an account?
      <a href="${pageContext.request.contextPath}/login">Login</a>
    </p>

  </form>
</div>

<script>
function previewImage(event) {
    const file = event.target.files[0];
    if (!file) return;
    // Size check — 5MB
    if (file.size > 5 * 1024 * 1024) {
        alert('File too large. Max 5MB allowed.');
        event.target.value = '';
        return;
    }
    const reader = new FileReader();
    reader.onload = function() {
        document.getElementById('previewImg').src = reader.result;
    };
    reader.readAsDataURL(file);
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>