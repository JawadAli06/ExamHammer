<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">

    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="m-0">My Results</h3>
      <a href="${pageContext.request.contextPath}/student/dashboard"
         class="btn btn-outline-primary btn-sm">Back to Dashboard</a>
    </div>

    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Exam Name</th>
            <th>Score</th>
            <th>Total Marks</th>
            <th>Percentage</th>
            <th>Result</th>
            <th>Status</th>
            <th>Submitted At</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${results}" var="r" varStatus="i">
            <tr>
              <td>${i.count}</td>
              <td>${r.exam.examName}</td>
              <td>${r.totalScore}</td>
              <td>${r.exam.totalMarks}</td>
              <td>${r.percentage}%</td>
              <td>
                <c:choose>
                  <c:when test="${r.result == 'PASS'}">
                    <span class="badge bg-success">PASS</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-danger">FAIL</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${r.status == 'COMPLETED'}">
                    <span class="badge bg-primary">Completed</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-warning text-dark">In Progress</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>${r.endTime}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty results}">
            <tr>
              <td colspan="8" class="text-center text-muted py-3">
                No results yet. 
                <a href="${pageContext.request.contextPath}/student/exams">
                  Take an exam now
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