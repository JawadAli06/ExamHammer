<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
  <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>
    <h3 class="mb-3">Available Exams</h3>

    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Exam Name</th>
            <th>Subject</th>
            <th>Difficulty</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${exams}" var="e">
            <tr>
              <td>${e.examId}</td>
              <td>${e.examName}</td>
              <td>${e.subjectName}</td>
              <td>${e.difficulty.level}</td>
              <td>${e.status}</td>
              <td>
                <a href="${pageContext.request.contextPath}/student/exam/${e.examId}" class="btn btn-primary btn-sm">
                  View Exam
                </a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty exams}">
            <tr>
              <td colspan="6" class="text-center text-muted">No exams available.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>
