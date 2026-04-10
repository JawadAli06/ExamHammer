<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<h3 class="fw-bold mb-2">Change Password</h3>
<p class="text-muted mb-3">Update your account password securely.</p>

<c:if test="${not empty success}">
  <div class="alert alert-success">${success}</div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger">${error}</div>
</c:if>

<div class="card shadow-sm">
  <div class="card-body">
    <form action="${pageContext.request.contextPath}/student/updatePassword" method="post">
      <div class="mb-3">
        <label class="form-label">Current Password</label>
        <input type="password" name="currentPassword" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">New Password</label>
        <input type="password" name="newPassword" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Confirm New Password</label>
        <input type="password" name="confirmPassword" class="form-control" required>
      </div>

      <button type="submit" class="btn btn-primary">Update Password</button>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>