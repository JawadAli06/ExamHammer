<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/header.jsp" %>

<style>
.profile-card {
    max-width: 500px;
    margin: auto;
    border-radius: 15px;
    padding: 25px;
    background: #fff;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    text-align: center;
}

.profile-img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
    border: 3px solid #007bff;
}

.profile-name {
    font-size: 20px;
    font-weight: bold;
}

.profile-role {
    color: #6c757d;
    margin-bottom: 15px;
}

.info-row {
    text-align: left;
    margin-top: 10px;
}
</style>

<div class="container mt-4">

    <a href="${pageContext.request.contextPath}/admin/users" 
       class="btn btn-outline-secondary btn-sm mb-3">
       ← Back
    </a>

    <div class="profile-card">

        <!-- Profile Image -->
        <c:choose>
            <c:when test="${not empty user.profilePicURL}">
                <img src="${user.profilePicURL}" class="profile-img"/>
            </c:when>
            <c:otherwise>
                <img src="https://via.placeholder.com/120" class="profile-img"/>
            </c:otherwise>
        </c:choose>

        <!-- Name -->
        <div class="profile-name">
            ${user.firstName} ${user.lastName}
        </div>

        <div class="profile-role">
            ${user.role}
        </div>

        <hr>

        <!-- Details -->
        <div class="info-row"><strong>ID:</strong> ${user.userId}</div>
        <div class="info-row"><strong>Email:</strong> ${user.email}</div>

    </div>

</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>