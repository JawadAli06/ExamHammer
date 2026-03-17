<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="m-0">Question List</h3>
      <a href="${pageContext.request.contextPath}/examiner/addQuestion" class="btn btn-success">Add Question</a>
    </div>

    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Exam</th>
            <th>Subject</th>
            <th>Question</th>
            <th>Correct</th>
            <th>Marks</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${questions}" var="q">
            <tr>
              <td>${q.questionId}</td>
              <td>${q.exam.examName}</td>
              <td>${q.subject.subjectName}</td>
              <td>${q.questionText}</td>
              <td>${q.correctAnswer}</td>
              <td>${q.marks}</td>
              <td>
                <a href="${pageContext.request.contextPath}/examiner/questions/edit/${q.questionId}"
                   class="btn btn-primary btn-sm">Edit</a>
                <a href="${pageContext.request.contextPath}/examiner/deleteQuestion/${q.questionId}"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Delete this question?');">Delete</a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty questions}">
            <tr>
              <td colspan="7" class="text-center text-muted">No questions found.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>