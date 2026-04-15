<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<a href="${pageContext.request.contextPath}/student/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<h3 class="mb-1">My Progress</h3>
<p class="text-muted mb-3">Your performance summary by subject.</p>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Subject</th>
            <th>Total Attempts</th>
            <th>Average Score</th>
            <th>Best Score</th>
            <th>Last Updated</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${progressList}" var="p" varStatus="i">
            <tr>
              <td>${i.count}</td>
              <td>${p.subject.subjectName}</td>
              <td>
                <span class="badge bg-primary">${p.totalAttempts}</span>
              </td>
              <td>${p.averageScore}</td>
              <td>
                <span class="fw-bold text-success">${p.bestScore}</span>
              </td>
              <td>${p.lastUpdated}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty progressList}">
            <tr>
              <td colspan="6" class="text-center text-muted py-3">
                No progress yet.
                <a href="${pageContext.request.contextPath}/student/exams">
                  Take an exam to start tracking.
                </a>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>