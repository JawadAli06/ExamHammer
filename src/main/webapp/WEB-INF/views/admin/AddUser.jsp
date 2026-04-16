<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/header.jsp" %>

<%-- Back button at top --%>
<a href="${pageContext.request.contextPath}/admin/users"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Users
</a>

<h3>Add / Edit User</h3>
<hr>

<form action="${pageContext.request.contextPath}/admin/users/save" method="post">

    <input type="hidden" name="userId" value="${user.userId}"/>

    <div class="mb-3">
        <label>First Name</label>
        <input type="text" name="firstName" class="form-control"
               value="${user.firstName}" required>
    </div>

    <div class="mb-3">
        <label>Last Name</label>
        <input type="text" name="lastName" class="form-control"
               value="${user.lastName}" required>
    </div>

    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control"
               value="${user.email}" required>
    </div>
    
    <c:if test="${user.userId == null}">
    <div>
        <label>Password:</label>
        <input type="password" name="password" required />
    </div>
</c:if>

   <!--   <div class="mb-3">
        <label>Password</label>
        <input type="text" name="password" class="form-control"
               value="${user.password}" required>
    </div>-->

    <div class="mb-3">
        <label>Gender</label>
        <select name="gender" class="form-control">
            <option value="Male"   ${user.gender == 'Male'   ? 'selected' : ''}>Male</option>
            <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
            <option value="Other"  ${user.gender == 'Other'  ? 'selected' : ''}>Other</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Contact Number</label>
        <input type="text" name="contactNum" class="form-control"
               value="${user.contactNum}">
    </div>

    <div class="mb-3">
        <label>Birth Year</label>
        <input type="number" name="birthYear" class="form-control"
               value="${user.birthYear}">
    </div>

    <div class="mb-3">
        <label>Role</label>
        <select name="role" class="form-control">
            <option value="ADMIN"     ${user.role == 'ADMIN'     ? 'selected' : ''}>ADMIN</option>
            <option value="EXAMINER"  ${user.role == 'EXAMINER'  ? 'selected' : ''}>EXAMINER</option>
            <option value="STUDENT"   ${user.role == 'STUDENT'   ? 'selected' : ''}>STUDENT</option>
        </select>
    </div>

    <button class="btn btn-success">
        <i class="bi bi-save me-1"></i>Save
    </button>
    <a href="${pageContext.request.contextPath}/admin/users"
       class="btn btn-secondary ms-2">
        <i class="bi bi-arrow-left me-1"></i>Back
    </a>

</form>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>