<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="m-0">My Exams</h3>
    </div>

    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Exam Name</th>
            <th>Exam Type</th>
            <th>Subject</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${exams}" var="e">
            <tr>
              <td>${e.examId}</td>
              <td>${e.examName}</td>
              <td>${e.examType}</td>
              <td>${e.subjectName}</td>
              <td>${e.status}</td>
              <td>
                <a href="${pageContext.request.contextPath}/examiner/addQuestion?examId=${e.examId}"
                   class="btn btn-primary btn-sm">
                  Add Question
                </a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty exams}">
            <tr>
              <td colspan="6" class="text-center text-muted">No exams found.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>