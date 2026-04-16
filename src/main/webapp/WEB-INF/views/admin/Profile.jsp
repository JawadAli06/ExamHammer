<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="${pageContext.request.contextPath}/admin/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<h3 class="fw-bold mb-1">My Profile</h3>
<p class="text-muted mb-3">Update your profile details and profile picture.</p>

<c:if test="${not empty success}">
  <div class="alert alert-success alert-dismissible fade show">
    <i class="bi bi-check-circle me-2"></i>${success}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>
<c:if test="${not empty error}">
  <div class="alert alert-danger alert-dismissible fade show">
    <i class="bi bi-exclamation-circle me-2"></i>${error}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body p-4">
    <form action="${pageContext.request.contextPath}/admin/updateProfile"
          method="post"
          enctype="multipart/form-data">

      <div class="row">

        <%-- LEFT: Profile picture --%>
        <div class="col-md-3 text-center mb-4">

          <%-- FIXED: ui-avatars fallback instead of missing default-user.png --%>
          <c:choose>
         
           <c:when test="${not empty userData.profilePicURL}">
              <img id="previewImg"
                   src="${userData.profilePicURL}"
                   class="rounded-circle mb-3"
                   style="width:140px;height:140px;object-fit:cover;
                          border:4px solid #e9ecef;">
            </c:when> 
            <c:otherwise>
              <img id="previewImg"
                   src="https://ui-avatars.com/api/?name=${userData.firstName}+${userData.lastName}&background=0D6EFD&color=fff&size=200"
                   class="rounded-circle mb-3"
                   style="width:140px;height:140px;object-fit:cover;
                          border:4px solid #e9ecef;">
            </c:otherwise>
          </c:choose>

          <div class="mb-2" style="font-size:13px;color:#6c757d;">
            Click below to change picture
          </div>

          <input type="file"
                 name="profilePic"
                 accept="image/*"
                 class="form-control form-control-sm"
                 onchange="previewImage(event)">

          <div style="font-size:11px;color:#adb5bd;margin-top:5px;">
            JPG, PNG — max 5MB
          </div>
        </div>

        <%-- RIGHT: User details --%>
        <div class="col-md-9">
          <div class="row">

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">First Name</label>
              <input type="text" name="firstName"
                     class="form-control"
                     value="${userData.firstName}" required>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Last Name</label>
              <input type="text" name="lastName"
                     class="form-control"
                     value="${userData.lastName}" required>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Email</label>
              <input type="email"
                     class="form-control bg-light"
                     value="${userData.email}"
                     readonly>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Role</label>
              <input type="text"
                     class="form-control bg-light"
                     value="${userData.role}"
                     readonly>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Gender</label>
              <select name="gender" class="form-select">
                <option value="">-- Select --</option>
                <option ${userData.gender == 'Male'   ? 'selected' : ''}>Male</option>
                <option ${userData.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option ${userData.gender == 'Other'  ? 'selected' : ''}>Other</option>
              </select>
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Contact Number</label>
              <input type="text" name="contactNum"
                     class="form-control"
                     value="${userData.contactNum}"
                     placeholder="Enter contact number">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Birth Year</label>
              <input type="number" name="birthYear"
                     class="form-control"
                     value="${userData.birthYear}"
                     min="1900" max="2015"
                     placeholder="e.g. 1995">
            </div>

            <div class="col-md-6 mb-3">
              <label class="form-label fw-bold">Member Since</label>
              <input type="text"
                     class="form-control bg-light"
                     value="${userData.createdAt}"
                     readonly>
            </div>

          </div>

          <button type="submit" class="btn btn-primary px-4">
            <i class="bi bi-save me-1"></i>Update Profile
          </button>
        </div>

      </div>
    </form>
  </div>
</div>

<script>
function previewImage(event) {
    const file = event.target.files[0];
    if (!file) return;
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

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>