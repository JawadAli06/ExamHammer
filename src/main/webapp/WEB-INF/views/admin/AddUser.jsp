<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

    <div class="mb-3">
        <label>Password</label>
        <input type="text" name="password" class="form-control"
               value="${user.password}" required>
    </div>

    <div class="mb-3">
        <label>Gender</label>
        <select name="gender" class="form-control">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
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
            <option value="ADMIN">ADMIN</option>
            <option value="EXAMINER">EXAMINER</option>
            <option value="STUDENT">STUDENT</option>
        </select>
    </div>

    <button class="btn btn-success">Save</button>
    <a href="${pageContext.request.contextPath}/admin/users"
       class="btn btn-secondary">Back</a>

</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
