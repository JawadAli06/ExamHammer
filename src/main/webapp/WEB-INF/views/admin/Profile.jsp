<%@ include file="/WEB-INF/views/admin/header.jsp" %>

<h3 class="fw-bold mb-2">My Profile</h3>
<p class="text-muted mb-3">View your admin details.</p>

<div class="card">
  <div class="card-body">
    <p class="mb-1"><b>Name:</b> ${sessionScope.user.firstName} ${sessionScope.user.lastName}</p>
    <p class="mb-1"><b>Email:</b> ${sessionScope.user.email}</p>
    <p class="mb-0"><b>Role:</b> ${sessionScope.user.role}</p>
  </div>
</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>