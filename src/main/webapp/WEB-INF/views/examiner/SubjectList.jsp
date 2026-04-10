<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4 mb-4">
<a href="${pageContext.request.contextPath}/examiner/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>
  <div class="card-body">
    <h3 class="mb-3">All Subjects</h3>
    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Subject Name</th>
            <th>Description</th>
            <th>Created By</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${subjects}" var="s" varStatus="i">
            <tr>
              <td>${i.count}</td>
              <td>${s.subjectName}</td>
              <td>${not empty s.description ? s.description : '—'}</td>
              <td>${s.createdBy.firstName} ${s.createdBy.lastName}</td>
              <td>
                <c:choose>
                  <c:when test="${s.active}">
                    <span class="badge bg-success">Active</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-secondary">Inactive</span>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty subjects}">
            <tr>
              <td colspan="5" class="text-center text-muted py-3">No subjects found.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <h5 class="mb-3">Add New Subject</h5>
    <form action="${pageContext.request.contextPath}/examiner/saveSubject" method="post">
      <div class="mb-3">
        <label class="form-label fw-bold">Subject Name</label>
        <input type="text" name="subjectName" class="form-control"
               required placeholder="e.g. Mathematics">
      </div>
      <div class="mb-3">
        <label class="form-label fw-bold">Description</label>
        <textarea name="description" class="form-control" rows="2"
                  placeholder="Optional description"></textarea>
      </div>
      <div class="mb-3">
        <label class="form-label fw-bold">Status</label>
        <select name="active" class="form-select">
          <option value="true">Active</option>
          <option value="false">Inactive</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary px-4">Save Subject</button>
      <a href="${pageContext.request.contextPath}/examiner/dashboard"
         class="btn btn-secondary ms-2">Cancel</a>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>