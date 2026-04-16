<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<h3>Subject List</h3>

<a href="/admin/addSubject" class="btn btn-success mb-3">Add Subject</a>
<a href="${pageContext.request.contextPath}/admin/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
   <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<table class="table table-bordered table-hover">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Subject Name</th>
            <th>Description</th>
            <th>Created By</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody>
        <c:forEach items="${subjects}" var="s">
            <tr>
                <td>${s.subjectId}</td>

                <td>${s.subjectName}</td>

                <!-- Description -->
                <td>
                    <c:choose>
                        <c:when test="${not empty s.description}">
                            ${s.description}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>

                <!-- Created By -->
                <td>
                    <c:choose>
                        <c:when test="${not empty s.createdBy}">
                            ${s.createdBy.firstName}
                        </c:when>
                        <c:otherwise>Admin</c:otherwise>
                    </c:choose>
                </td>

                <!-- Status -->
                <td>
                    <c:choose>
                        <c:when test="${s.active}">
                            <span class="badge bg-success">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- Action -->
                <td>
                    <a href="${pageContext.request.contextPath}/admin/deleteSubject/${s.subjectId}"
   class="btn btn-danger btn-sm">
   Delete
</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>